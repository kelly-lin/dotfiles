import os
import platform
import subprocess
from enum import Enum, auto


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


def main(command, stowables):
    if command == 'stow':
        stow(stowables)

    if command == 'unstow':
        unstow(stowables)
