#!/bin/bash

mkdir HyprSource
cd HyprSource

wget https://github.com/hyprwm/Hyprland/releases/download/v0.24.1/source-v0.24.1.tar.gz
tar -xvf source-v0.24.1.tar.gz

wget https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/1.31/downloads/wayland-protocols-1.31.tar.xz
tar -xvJf wayland-protocols-1.31.tar.xz

wget https://gitlab.freedesktop.org/wayland/wayland/-/releases/1.22.0/downloads/wayland-1.22.0.tar.xz
tar -xzvJf wayland-1.22.0.tar.xz

wget https://gitlab.freedesktop.org/emersion/libdisplay-info/-/releases/0.1.1/downloads/libdisplay-info-0.1.1.tar.xz
tar -xvJf libdisplay-info-0.1.1.tar.xz

cd wayland-1.22.0
mkdir build &&
cd    build &&

meson setup ..            \
      --prefix=/usr       \
      --buildtype=release \
      -Ddocumentation=false &&
ninja
sudo ninja install

cd ../..

cd wayland-protocols-1.31

mkdir build &&
cd    build &&

meson setup --prefix=/usr --buildtype=release &&
ninja

sudo ninja install

cd ../..

cd libdisplay-info-0.1.1/

mkdir build &&
cd    build &&

meson setup --prefix=/usr --buildtype=release &&
ninja

sudo ninja install

cd ../..

chmod a+rw hyprland-source

cd hyprland-source/

sed -i 's/\/usr\/local/\/usr/g' config.mk

sudo make install

echo "congratulations, hyprland is installed now"

reboot