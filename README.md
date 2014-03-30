OSX Media Center - Mavericks Edition
===============

Note: A clean install will erase all of the contents on your disk drive. Make sure to back up your important files, settings and apps before proceeding. If needed, upgrade the system to Mavericks (https://itunes.apple.com/us/app/os-x-mavericks/id675248567?mt=12)

Performing a clean install:

1. Restart your Mac and hold down the Command key and the R key (cmd⌘+R). Press and hold these keys until the Apple logo appears.

2. For a clean install, open up Disk Utility and erase your main hard drive. Once you've done so, you can go back to the Install OS X Mavericks disk and choose "Install a new copy of OS X."


Install
=====
Open a terminal window (Finder, Applications, Utilities, Terminal), and enter the following command
```
git
```
A popup will show, asking permission to install the command line developers tools.

Click Install -> Agree

Return to the terminal window and download the install script by entering the following commands:
```
mkdir Mediacenter
cd Mediacenter
git clone https://github.com/ajongsma/OSX_MediaCenter.git
```


Notes
===============

OS X Server 
https://itunes.apple.com/nl/app/os-x-server/id714547929?l=en&mt=12


Plex Media Server

Plex Home Theater

Plex Unsupported (as in totally unofficial) Appstore
https://forums.plex.tv/index.php/topic/25523-unsupported-as-in-totally-unofficial-appstore/


Plex Media Scrobbler for TraktTV
https://forums.plex.tv/index.php/topic/102818-rel-trakt/
https://forums.plex.tv/index.php/topic/35626-plex-media-server-scrobbler-for-trakttv/

PlexWatch
https://forums.plex.tv/index.php/topic/72552-plexwatch-plex-notify-script-send-push-alerts-on-new-sessions-and-stopped/

PlexWatch/Web
https://forums.plex.tv/index.php/topic/82819-plexwatchweb-a-web-front-end-for-plexwatch/

OS X Server

SabNZBD

SickBeard

CouchPotato

Auto-Sub Bootstrap Bill
http://gathering.tweakers.net/forum/list_messages/1572892/0
https://code.google.com/p/autosub-bootstrapbill/

----------------

Launch Control
http://www.soma-zone.com/LaunchControl/

HandBrake
http://handbrake.fr

GitHub

DaisyDisk

Path Finder

iTerm

MacPar Deluxe

Xlog

Xcode

Transmission

Unison
----------------

PlexWWWatch
https://forums.plex.tv/index.php/topic/98005-plexwwwatch/

mkdir /Users/Plex/Sites
cd /Users/Plex/Sites
git clone https://github.com/Gyran/PlexWWWatch.git
chmod 777 /Users/Plex/Sites/PlexWWWatch/settings
sudo ln -s /Users/Plex/Sites/PlexWWWatch/public /Library/Server/Web/Data/Sites/Default/plexwwwatch

plexwatchdb: /Users/Plex/plexWatch/plexWatch.db
