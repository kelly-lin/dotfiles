#!/usr/bin/env python

import os
import sys
import shutil
import platform
import subprocess
from enum import Enum, auto


def app_exists(name):
    result = shutil.which(name)
    return result is not None


def is_linux():
    return platform.system().lower() == "linux"


def is_mac_os():
    return platform.system().lower() == "darwin"


class Target(Enum):
    HOME = auto()
    OTHER = auto()


class OS(Enum):
    LINUX = auto()
    MAC_OS = auto()
    ALL = auto()


class Platorm_Dir():
    LINUX = "linux"
    MAC_OS = "mac"


def get_target_dir(dest, alt_dir):
    if dest == Target.OTHER:
        return alt_dir
    return os.getenv("HOME")


def get_platform_dir_name():
    if is_mac_os():
        return Platorm_Dir.MAC_OS
    return Platorm_Dir.LINUX


class Stowable:
    def __init__(self, package_name, target=Target.HOME, alt_dir="",
                 is_platform_split=False, target_platform=None):
        self.package_name = package_name
        self.target = target
        self.alt_dir = alt_dir
        self.is_platform_split = is_platform_split
        self.target_platform = target_platform

    def stow(self):
        print("stowing {}".format(self.package_name))

        target_dir = get_target_dir(self.target, self.alt_dir)
        package_name = self.package_name
        platform_dir_name = get_platform_dir_name()

        if self.target_platform == OS.LINUX and is_linux():
            subprocess.run(
                ["stow", "--target={target}".format(target=target_dir), package_name])
            return

        if self.target_platform == OS.MAC_OS and is_mac_os():
            subprocess.run(
                ["stow", "--target={target}".format(target=target_dir), package_name])
            return

        if not self.is_platform_split:
            subprocess.run(
                ["stow", "--target={target}".format(target=target_dir), package_name])
            return

        subprocess.run(
            ["stow",
                "--dir={package_name}".format(package_name=package_name),
                "--target={target}".format(target=target_dir), platform_dir_name])


def root_dir_guard():
    if __file__.replace(os.getcwd(), "") != "/./install.py":
        print("you are not in the root directory, please execute this script inside the root directory")
        sys.exit()


if __name__ == "__main__":
    root_dir_guard()

    print("installing dependencies")
    if not app_exists("stow"):
        if is_linux():
            print("stow could not be found, installing stow")
            subprocess.run(["sudo", "pacman", "-S", "--noconfirm", "stow"])

        if is_mac_os():
            subprocess.run(["brew", "install", "stow"])

    if not app_exists("xclip"):
        print("stow could not be found, installing stow")
        if is_linux():
            subprocess.run(["sudo", "pacman", "-S", "--noconfirm", "stow"])
    print("finished installing dependencies")

    print("stowing dotfiles")
    stowables = [Stowable("tmux"), Stowable("zsh"), Stowable("nvim"),
                 Stowable("prettier"), Stowable("alacritty",
                                                is_platform_split=True),
                 Stowable("fonts", is_platform_split=True), Stowable("dunst",
                                                                     target_platform=OS.LINUX),
                 Stowable("google-chrome", target_platform=OS.LINUX),
                 Stowable("i3", target_platform=OS.LINUX), Stowable("awesome",
                                                                    target_platform=OS.LINUX),
                 Stowable("polybar", target_platform=OS.LINUX),
                 Stowable("picom", OS.LINUX), Stowable("xfiles",
                                                       target_platform=OS.LINUX),
                 Stowable("logid", target=Target.OTHER, alt_dir="/etc", target_platform=OS.LINUX)]
    for stowable in stowables:
        stowable.stow()
