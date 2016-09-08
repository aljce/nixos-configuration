#!/usr/bin/env python3
from pathlib import Path
from shutil import copy
import argparse
import os

class Dotfile:
    def __init__(self, src, dest, link):
        self.src  = Path(src)
        self.dest = Path(dest)
        self.link = link

    def install(self):
        if self.link:
            if os.path.lexists(dest):
                os.remove(dest)
                os.symlink(src, dest)
            else:
                os.symlink(src, dest)
        else:
            if os.path.exists(dest):
                os.remove(dest)
                copy(src, dest)
            else:
                copy(src, dest)

parser = argparse.ArgumentParser(description='Dotfile Installation Manager')
parser.add_argument('resources', metavar='DIR', type=str,
                    help='The directory that holds all the resources needed for installation')
args = parser.parse_args()
home = os.getenv("HOME")

def dirs(resrc):
    os.mkdir(home + '/.config')
    force_symlink(resrc + '/dotfiles/user-dirs.dirs',
                  home + '/.config/user-dirs.dirs')

commands = [ ("dirs", "config", False),
             ("git", "", True) ]
# dotfiles = [ Dotfile(*d).install(args.resources) for d in commands ]
