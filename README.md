# CNC3D-Commander-on-linux
How to get the CNC 3D software Commander running on Linux.

## What is Commander?
[CNC3D](https://www.cnc3d.com.au/) is an Australian based store for various maker products (eg: CNC, 3D printers etc...). 

They use software for their propiatary CNC [Nighthawk Controller](https://www.cnc3d.com.au/nhc). That software is called [Commander](https://www.cnc3d.com.au/commander). Unfortunately (for me) their software is designed for Windows.

From the [Commander](https://www.cnc3d.com.au/commander) page:
> The CNC3D Commander project (Formerly SharpCNC Commander) started off as a complimentary configuration tool for our CNC router kits. Over time, this project has turned into a full CNC control management suite with built in Creation tools that allow you to make your designs come to life. It is also completely FREE for personal use.
>
> This software is written in Microsoft .NET framework and is designed for use on Windows PCs and laptops.

I figured out what was required to get the software working in Wine on Linux, and thought I'd document it to save future-me some time, and possibly others.

## What platforms has this been tested on?
A short list, to be sure.
* Ubuntu 20.04 (used extensively)
* Linux mint lmde 4 (to the point of getting the program working)

## What works?
As at 9 Sep 2021, all functions I've tested so far works so far. If you find functions that don't work, and suspect you suspecg Wine may be the culpret, let me know.
Some of the text doesn't all fit on to the spaces allotted for them on the interface. This might be resolved by you installing more fonts (see below).

## Install Wine (if you don't have it installed already)

1. Follow the steps for installing the latest Wine for your platform. I suggest you do the recommended install of Wine. 

Example for **Ubuntu**, follow the steps on https://wiki.winehq.org/Ubuntu. For convenience I've reproduced the steps below.
1. Enable the 32bit architecture.
   ```sh
   sudo dpkg --add-architecture i386
   ```
3. Set up the wineHQ repository key.
    ```sh
    sudo mkdir -pm755 /etc/apt/keyrings
    sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
    ```
4. Add the repository (only execute one of these commands).
    ```sh
    # Ubuntu 23.04
    # (Lunar Lobster)
    sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/lunar/winehq-lunar.sources

    # Ubuntu 22.10
    # (Kinetic Kudu)
    sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/kinetic/winehq-kinetic.sources

    # Ubuntu 22.04
    # (Jammy Jellyfish)
    # Linux Mint 21.x
    sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

    # Ubuntu 20.04
    # (Focal Fossa)
    # Linux Mint 20.x
    sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources
    ```
5. Update the package database.
    ```sh
    sudo apt update
    ```
6. Install wine 
    ```sh
    sudo apt install --install-recommends winehq-stable
    ```

## WINE setup
I like a gui for interacting with wine prefixes. I use [Q4Wine](https://q4wine.brezblock.org.ua/), however I'm also exploring alternatives like [Bottles](https://usebottles.com/download/).

In the steps below, I'll be using Q4Wine to create and manage a WINE prefix (a discrete set of environment settings for WINE). You can use that prefix to run Commander. 

1. Install Q4Wine - follow the instructions for your distribution.
2. Create a wine prefix for Commander:
    1. Step through the first-time setup wizard. I found the default settings to be fine.
    2. Go to the prefix tab.
    3. Click on the [+] button to create a new prefix.
    4. Enter in a name for your prefix. eg: Commander software, then click ok.
3. Set up your new prefix:
    1. On the main Q4Wine panel, go to the Setup tab, and ensure your new prefix is selected in the drop down located at the top of that tab.
    2. You should see two options in the left panel. System and Winetricks. Select Winetricks.
    3. If there are no options under Winetricks, that means your system does not currently have it installed. In the panel on the right, run 'Install or update Winetricks script', then run 'Refresh Winetricks application list'. This should create a bunch of options under Winetricks in the panel on the left.
    4. Select dlls from the list under Winetricks.
    5. Scroll through the list of DLLs on the right-panel. Find and run the most recent dotnet 4 package. At the time of writing, that is 'dotnet48'. This will pop up a terminal window that will execute the download and install of this dotnet package in to your prefex. When the windows installation wizard window pops up, follow the prompts.
    6. Install some fonts, I'd suggest some of the common ones. I haven't checked which font is in use on the interface yet. I'll update this when I do. 
4. Optional: Set up COM ports for USB access to your mill. This is for if you intend to directly connect to your CNC mill. Steps are:
    1. Add yourself to the dialout user groups on your machine. This is so you can access serial ports without root permissions. This can be done from Terminal:
    ```sh
    sudo adduser <your_username> dialout
    sudo adduser <your_username> sys
    ```
    2. Override Wine's default device mapping for COM/USB ports. Select the system folder under your prefix in Q4Wine. Run regedit (in the right panel).
    3. Create string entries in HKEY_LOCAL_MACHINE\Software\Wine\Ports where the entry name is the Windows device name and the entry value is the path to the Unix device. To make COM1 the first USB-attached serial port, create an entry with the name COM1 and the value /dev/ttyUSB0. 
    4. After editing the registry, shut down Q4Wine, and Wine with the command:
        ```sh
        wineserver -k
        ```
        The next time Wine runs a program, your changes will take effect. 

## Install Commander in your Wine prefix
1. [Download the latest version of Commander](https://www.cnc3d.com.au/commander) from CNC3D. 
2. Open Q4Wine, on the Programs tab, select your prefix from the list of prefixes. Right click it and select 'run'.
3. In the run dialog, click the button to the right of the Program field. Select the setup program for commander that you downloaded earlier.
4. Follow the prompts in the CNC3D setup wizard, and let it check online for updates.
5. You should be done now! You will now have an icon in your Mint programs menu, and also on your desktop.
