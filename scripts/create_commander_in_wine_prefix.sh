#!/bin/bash

# vars
DOWNLOADS_PATH=$HOME/tmp_commander_setup
WINEPREFIX_PATH=$HOME/.wineprefixes
COMMANDER_PREFIX_NAME=cnc_commander
COMMANDER_DOWNLOAD_LOCAL_NAME=cnc_commander_setup.exe

mkdir -p $DOWNLOADS_PATH

# download latest winetricks
echo "Downloading the latest Winetricks"
wget -P $DOWNLOADS_PATH https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks 
chmod +x $DOWNLOADS_PATH/winetricks

# creating dir for prefix if it doesn't exist
echo "Creating the wine prefix..."

# Set windows version to 10 and install dotnet 4.8
echo "Setting up prefix: Installing dotnet 4.8 and setting the windows version to Windows 10"
env WINEPREFIX=$WINEPREFIX_PATH/$COMMANDER_PREFIX_NAME sh $DOWNLOADS_PATH/winetricks -q dotnet48 win10
# Install fonts
echo "Setting up prefix: Installing common fonts"
env WINEPREFIX=$WINEPREFIX_PATH/$COMMANDER_PREFIX_NAME sh $DOWNLOADS_PATH/winetricks -q corefonts georgia tahoma verdana calibri cambria candara comicsans

# Download commander software
echo "Downloading the latest version of CNC Commander"
echo "Downloads path: $DOWNLOADS_PATH"
wget -P $DOWNLOADS_PATH https://libraries.sharpsoft.com.au/software/setup.exe 

# Install commander
echo "Install commander"
env WINEPREFIX=$WINEPREFIX_PATH/$COMMANDER_PREFIX_NAME wine $DOWNLOADS_PATH/setup.exe

# Cleaning up delete winetricks
echo "Cleanup: Removing winetricks file"
rm -r $DOWNLOADS_PATH