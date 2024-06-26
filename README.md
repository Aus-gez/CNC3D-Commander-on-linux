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

A short list, to be sure:

* PopOS 22.04
* Ubuntu 20.04
* Linux mint lmde 4

## What works?

As at May 2024, all functions I've tested so far works. If you find functions that don't work, and suspect Wine may be the culpret, let me know.

## Known issue

Some of the text in the Commander software doesn't fit onto the areas allotted for them on the interface. This might be resolved by you installing more fonts (see below).

## Mandatory step - Install a recent version of Wine (if you don't have it installed already)

Follow the steps for installing the latest Wine for your platform as per https://wiki.winehq.org/

For example, the steps for installing the latest wine on **Ubuntu**: https://wiki.winehq.org/Ubuntu.

## Option 1 - script

Execute the following script:

Alternatively download the script and make adjustments based on your needs: [scripts/create_commander_in_wine_prefix.sh](scripts/create_commander_in_wine_prefix.sh)

```sh
wget -N https://raw.githubusercontent.com/Aus-gez/CNC3D-Commander-on-linux/main/scripts/create_commander_in_wine_prefix.sh && chmod +x create_commander_in_wine_prefix.sh && ./create_commander_in_wine_prefix.sh
```

### Manual steps for USB access

Optional: Set up COM ports for USB access to your mill. This is for if you intend to directly connect to your CNC mill via USB.

Steps are:
    1. Add yourself to the dialout user groups on your machine. This is so you can access serial ports without root permissions. This can be done from Terminal:
    ```sh
    sudo adduser <your_username> dialout
    sudo adduser <your_username> sys
    ```
    2. Override Wine's default device mapping for COM/USB ports.
    Steps:
        1. ```sh
        env WINEPREFIX=~/.wineprefixes/cnc_commander wine regedit
        ```
        2. Create string entries in HKEY_LOCAL_MACHINE\Software\Wine\Ports where the entry name is the Windows device name and the entry value is the path to the Unix device. To make COM1 the first USB-attached serial port, create an entry with the name COM1 and the value /dev/ttyUSB0.

## Option 2 - using the Q4Wine (GUI)

If you prefer a GUI. I've tested this approach using [Q4Wine](https://q4wine.brezblock.org.ua/), however you may be able to adapt this approach using other GUIs.

In the steps below, I'll be using Q4Wine to create and manage a WINE prefix (a discrete set of environment settings for WINE). You can use that prefix to run Commander.

1. Install Q4Wine - follow the instructions for your distribution.
    1. Step through the first-time setup wizard. I found the default settings to be fine.
2. Create a wine prefix for Commander:
    1. Go to the prefix tab.
    2. Click on the [+] button to create a new prefix.
    3. Enter in a name for your prefix. eg: Commander software, then click ok.
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
    5. Install Commander in your Wine prefix:
        1. [Download the latest version of Commander](https://www.cnc3d.com.au/commander) from CNC3D. 
        2. Open Q4Wine, on the Programs tab, select your prefix from the list of prefixes. Right click it and select 'run'.
        3. In the run dialog, click the button to the right of the Program field. Select the setup program for commander that you downloaded earlier.
        4. Follow the prompts in the CNC3D setup wizard, and let it check online for updates.
        5. You should be done now! You will now have an icon in your Mint programs menu, and also on your desktop.
