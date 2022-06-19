#!/usr/bin/env python3

from installer.main import main, Stowable, OS, Target
import sys
import os

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


def ensure_root_dir():
    if __file__.replace(os.getcwd(), "") != "/./install.py":
        print("you are not in the root directory, please execute this script inside the root directory")
        sys.exit()


if __name__ == "__main__":
    ensure_root_dir()

    if len(sys.argv) < 2:
        print("please provide a command to run")
        sys.exit()

    command = sys.argv[1]
    main(command, stowables)
