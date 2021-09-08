# CNC3D-Commander-on-linux
How to get the CNC 3D software Commander running on Linux.

## What is Commander?
[CNC3D](https://www.cnc3d.com.au/) is an Australian based store for various maker products (eg: CNC, 3D printers etc...). 

They use software for their propiatary CNC [Nighthawk Controller](https://www.cnc3d.com.au/nhc). That software is called [Commander](https://www.cnc3d.com.au/commander). Unfortunately (for me) their software is designed for Windows.

From the [Commander](https://www.cnc3d.com.au/commander) page:
> The CNC3D Commander project (Formerly SharpCNC Commander) started off as a complimentary configuration tool for our CNC router kits. Over time, this project has turned into a full CNC control management suite with built in Creation tools that allow you to make your designs come to life. It is also completely FREE for personal use.
>
> This software is written in Microsoft .NET framework and is designed for use on Windows PCs and laptops.

So I figured out what was required to get the software working in Wine on Linux, and thought I'd document it to save future-me some time, and possibly others.

## What platforms has this been tested on?
A short list, to be sure.
* Ubuntu 20.04

## What works?
As at 9 Sep 2021, everything works that I've tested.

## The script
Sorry, this isn't done yet.

## The manual process
1. Install Wine (latest stable is fine).
2. Install wine tricks.
3. Create a wine prefix for Commander.
    * I like a gui for interacting with wine prefixes. So I use [Q4Wine](). You can use that to create the wine prefix, and carry out the below steps. 
4. Using wine tricks, install the latest dotnet 4.x package you have.
5. Install all the fonts you can under winetricks.



