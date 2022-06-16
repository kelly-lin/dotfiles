#!/usr/bin/env python3

import os
import sys
import shutil
import platform
import subprocess
from enum import Enum, auto


def is_package_installed(name):
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
            ["stow", "--target={target}".format(target=target_dir), platform_dir_name])

    def unstow(self):
        print("unstowing {}".format(self.package_name))

        target_dir = get_target_dir(self.target, self.alt_dir)
        package_name = self.package_name

        subprocess.run(
            ["stow", "--delete", "--target={target}".format(target=target_dir), package_name])


def ensure_root_dir():
    if __file__.replace(os.getcwd(), "") != "/./install.py":
        print("you are not in the root directory, please execute this script inside the root directory")
        sys.exit()


class Package:
    # the shell name refers to the command you would type to invoke the
    # installed package on the command line. For example, the nodejs package
    # would have a shell name of "node" and not "nodejs"
    def __init__(self, package_name, platform, shell_name=""):
        self.package_name = package_name
        self.package_manager = platform
        self.shell_name = shell_name

    def install(self):
        shell_name = self.package_name
        if self.shell_name != "":
            shell_name = self.shell_name

        if is_package_installed(shell_name):
            print("{} already installed, skipping...".format(self.package_name))
            return

        print("installing {}".format(self.package_name))
        if is_linux():
            subprocess.run(["pacman", "-S", self.package_name])
            return

        if is_mac_os():
            subprocess.run(["brew", "install", self.package_name])
            return

        subprocess.run(["brew", "install", self.package_name])
        return


def install_packages(packages):
    print("installing dependencies")
    for package in packages:
        package.install()
    print("finished installing dependencies")


def stow(stowables):
    print("stowing stowables")
    for stowable in stowables:
        stowable.unstow()
        stowable.stow()
    print("finished stowing stowables")


def unstow(stowables):
    print("unstowing stowables")
    for stowable in stowables:
        stowable.unstow()
    print("finished unstowing stowables")


def uninstall_dotfiles(stowables):
    print("uninstalling dotfiles")
    for stowable in stowables:
        stowable.unstow()
    print("finished uninstalling dotfiles")


packages = [Package("stow", OS.LINUX),
            Package("xclip", OS.LINUX),
            Package("fzf", OS.LINUX),
            Package("nodejs", OS.LINUX, "node"),
            Package("npm", OS.LINUX),
            Package("picom", OS.LINUX),
            Package("nitrogen", OS.LINUX),
            Package("pulseaudio", OS.LINUX),
            Package("pamixer", OS.LINUX),
            Package("ruby", OS.LINUX),
            Package("python-pip", OS.LINUX, "pip"),
            Package("python", OS.LINUX),
            Package("fd", OS.LINUX),
            Package("xbindkeys", OS.LINUX),
            Package("stylua", OS.LINUX),
            Package("playerctl", OS.LINUX),
            Package("nautilus", OS.LINUX),
            Package("zathura", OS.LINUX),
            Package("numlockx", OS.LINUX),
            Package("noto-fonts-emoji", OS.LINUX),
            Package("zathura-pdf-mupdf", OS.LINUX)]

stowables = [Stowable("tmux"),
             Stowable("zsh"),
             Stowable("nvim"),
             Stowable("prettier"),
             Stowable("alacritty", is_platform_split=True),
             Stowable("fonts", is_platform_split=True),
             Stowable("dunst", target_platform=OS.LINUX),
             Stowable("google-chrome", target_platform=OS.LINUX),
             Stowable("nvidia-settings", target_platform=OS.LINUX),
             Stowable("i3", target_platform=OS.LINUX),
             Stowable("awesome", target_platform=OS.LINUX),
             Stowable("polybar", target_platform=OS.LINUX),
             Stowable("pulse", target_platform=OS.LINUX),
             Stowable("picom", OS.LINUX),
             Stowable("rofi", OS.LINUX),
             Stowable("tmuxinator", OS.LINUX),
             Stowable("xfiles", target_platform=OS.LINUX),
             Stowable("logid", target=Target.OTHER, alt_dir="/etc", target_platform=OS.LINUX)]

if __name__ == "__main__":
    ensure_root_dir()
    command = sys.argv[1]
    option = sys.argv[2] if len(sys.argv) == 3 else ''

    if command == 'install' and option == 'packages':
        install_packages(packages)

    if command == 'stow':
        stow(stowables)

    if command == 'unstow':
        unstow(stowables)
