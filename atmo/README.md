# Descriptions

The following scripts install GIS software on an Atmosphere or Jetstream VM running Ubuntu 16.04 (Xenial). A GUI image is preferred, but not required if you don't want / need one.

## First Steps

Start an Atmosphere or Jetstream instance running  Linux [Ubuntu 14.04](https://atmo.cyverse.org/application/images/1135) or [16.04 GUI base](https://atmo.cyverse.org/application/images/1453).

Allow the instance to reach 'active' status. Instances  typically take 3-7 minutes to boot up the first time.

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

type `xrandr` in a Web Desktop terminal to see available resolutions.

an example for 1080HD screen size:

```
xrandr -s 1920x1080
```

# Github

Change into a directory you're comfortable installing into and have `sudo` privileges.

The next step is to `git clone` this repository onto your VM:

```
git clone https://github.com/cyverse-gis/focus-forum.git
```

change directory to the new repo with these installation scripts:

```
cd focus-forum/atmo
```

## install R and RStudio-Server

We are going to install RStudio-Server, which is basically the same as RStudio, but it runs through your browser over the `:8787` port.

```
. install_rstudio.sh
```

You might be prompted to confirm the installation of some packages, select `Y` `yes` or just hit `return` `enter` to move forward.

Go get a coffee or answer email - this is going to take a while.

Log into the RStudio by opening a new browser window, copy and paste the IP address of the instance from the Atmosphere window.

Add the `:8787` to the IP.

Use your CyVerse username and password to log into the RStudio.

## Install GRASS

to install GRASS

```
. build_grass.sh
```

## Install QGIS

to install QGIS 

```
. install_qgis.sh
```

In Apache Guacamole Desktop: Right click mouse, select Applications > Education > QGIS Desktop

# EZ Installation

We can also install data science software using containers or Python distribution.

CyVerse has set up an `ez` installation for Docker, Singularity, and Jupyter Notebooks (via Anaconda)

Follow the [CyVerse Learning Center's Quick Start](https://cyverse-ez-quickstart.readthedocs-hosted.com/en/latest/) 
