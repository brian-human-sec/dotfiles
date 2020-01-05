#!/bin/sh

VER=3.0.24
#wget https://github.com/standardnotes/desktop/releases/download/v3.0.24/Standard-Notes-3.0.24.AppImage
wget https://github.com/standardnotes/desktop/releases/download/v${VER}/standard-notes-${VER}.AppImage
chmod 755 standard-notes-${VER}-x86_64.AppImage
mv standard-notes-${VER}-x86_64.AppImage $HOME/.local/bin/standard-notes

exit 0
