# Descriptions

The following scripts install GIS software on an Atmosphere or Jetstream VM 

Log into the Apache Guacamole web shell to access terminal.

Or from the Apache Guacamole Desktop, right click mouse, select Terminal Emulator

## Access Clipboard in Guacamole

- Open Clipboard and virtual keyboard
  - On a standard keyboard: `ctrl` + `alt` + `shift` key
  - On a MAC OS X keyboard: `control` + `command ⌘` + `shift` key

- Select your text or paste text into the clipboard window.

- Close the Clipboard window by selecting `control` + `command ⌘` + `shift` keys again

- Right click with your mouse or double tap fingers on touchpad to paste in the web shell or Desktop

## To change Web Desktop screen resolution:

```
xrandr -s 1920x1200
```

# Github

The next step is to `git` and `clone` this repository to your VM from this Github page

```
#clone the private repository - you will be prompted for your password
git clone https://github.com/cyverse-gis/focus-forum.git
```
```
# change directory
cd bighorns/atmo
```

## Install GRASS

to install GRASS natively (without Singularity container) 

```
. build_grass_quick.sh
```

## Install QGIS

to install QGIS natively

```
. install_qgis.sh
```

In Apache Guacamole Desktop: Right click mouse, select Applications > Education > QGIS Desktop

# EZ Installation

Follow the [CyVerse Learning Center's Quick Start](https://cyverse-ez-quickstart.readthedocs-hosted.com/en/latest/) 
