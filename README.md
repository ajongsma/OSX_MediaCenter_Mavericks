OSX Media Center - Mavericks Edition
===============
![minions](http://www.donankleer.com/wp-content/uploads/2013/05/minions_cheering.gif)

![OSX_Mavericks](img/osx_mavericks_64x64.jpg)
![OSX_Server](img/osx_server_64x64.jpeg)
![Plex_Client](img/plex_client_64x64.jpeg)
![Plex_Server](img/plex_server_64x64.png)
![SABnzbd](img/sabnzbd_64x64.png)
![SickBeard](img/sickBeard_64x64.png)
![CouchPotato](img/couchpotato_64x64.png)
![Trakt](img/trakt_64x64.png)


Note:
=====
A clean install will erase all of the contents on your disk drive. Make sure to back up your important files, settings and apps before proceeding. If needed, upgrade the system to Mavericks (https://itunes.apple.com/us/app/os-x-mavericks/id675248567?mt=12)

Performing a clean install:

1. Restart your Mac and hold down the Command key and the R key (cmd⌘+R). Press and hold these keys until the Apple logo appears.

2. For a clean install, open up Disk Utility and erase your main hard drive. Once you've done so, you can go back to the Install OS X Mavericks disk and choose "Install a new copy of OS X."


Install 
=====
Open a terminal window (Finder -> Applications -> Utilities -> Terminal), enter the following command and follow the instructions to accept the XCode agreement
```
xcodebuild -license
```
After this, enter the following command:
```
xcode-select --install
```
A popup will show, asking permission to install the Xcode Command Line Tools.  
Click Install -> Agree

Return to the terminal window and download the install script by entering the following commands:
```
mkdir ~/Github
cd ~/Github
git clone https://github.com/ajongsma/OSX_MediaCenter.git
```

After the repository has been downloaded, enter the following commands:
```
cd OSX_MediaCenter
./install.sh
```


###Installed applications (if enabled)
===============
#### OS X
[OS X Server](https://itunes.apple.com/nl/app/os-x-server/id714547929?l=en&mt=12)

[MySQL](http://www.mysql.com)

[CPAN](http://www.cpan.org)

[Cheetah](http://www.cheetahtemplate.org)

[PHP 5.5](http://www.php.net)

#### Utilities
[Homebrew](http://brew.sh)

[iTerm 2](http://www.iterm2.com)

[Xlog](https://itunes.apple.com/us/app/xlog/id430304898?mt=12&ign-mpt=uo%3D4)

[Textwrangler](https://itunes.apple.com/nl/app/textwrangler/id404010395?mt=12)

[MacPar Deluxe](http://gp.home.xs4all.nl/Site/MacPAR_deLuxe.html)

#### Plex
[Plex Media Server](http://plex.tv)

[Plex Media Scrobbler for TraktTV](https://forums.plex.tv/index.php/topic/102818-rel-trakt/)

[PlexWatch](https://forums.plex.tv/index.php/topic/72552-plexwatch-plex-notify-script-send-push-alerts-on-new-sessions-and-stopped/)

[PlexWatch/Web](https://forums.plex.tv/index.php/topic/82819-plexwatchweb-a-web-front-end-for-plexwatch/)

[Plex Home Theater](http://plex.tv)

#### Other
[SABnzbd](http://sabnzbd.org/)

[CouchPotato](https://couchpota.to)
- SABnzbd Integrated
- Trakt Integrated
- Plex Media Server Integrated

[SickBeard](http://sickbeard.com)
- SABnzbd Integrated
- SpotWEB Integrated
- Trakt Integrated
- Plex Media Server Integrated

[nzbToMedia](https://github.com/clinton-hall/nzbToMedia)
- SABnzbd to CouchPotato Integrated

[Auto-Sub Bootstrap Bill](https://code.google.com/p/autosub-bootstrapbill)

[SpotWEB](https://github.com/spotweb/spotweb)
- SABnzbd Integrated


Some other stuff
===============

Plex Unsupported (as in totally unofficial) Appstore
https://forums.plex.tv/index.php/topic/25523-unsupported-as-in-totally-unofficial-appstore/
https://github.com/mikedm139/UnSupportedAppstore.bundle
~/Library/Application Support/Plex Media Server/Plug-ins

NewzNAB
http://forums.sabnzbd.org/viewtopic.php?f=6&t=12557&sid=269049b5a017f34a3329cc9c075b7998

----------------

[Sequel Pro](http://www.sequelpro.com)

Launch Control
http://www.soma-zone.com/LaunchControl/

HandBrake
http://handbrake.fr

DaisyDisk

Path Finder

Transmission

Unison

nzbdrone

[launchrocket](https://github.com/jimbojsb/launchrocket)

Random thoughts to check and verify
===============

##### Randoms

- https://github.com/sivel/speedtest-cli
- http://www.pixelbeat.org/scripts/ls_color/ | http://www.pixelbeat.org/scripts/l

#####OS X Server

- http://codedmemes.com/lib/mavericks-server-pitfalls-fixes/
- http://codedmemes.com/lib/php-performance-apc-os-x-server/
- http://www.zeroiq.com/2013/01/20/php-modules-mcrypt-gettext-en-intl-toevoegen-aan-standaard-php-versie-mountain-lion-server/
- http://coolestguidesontheplanet.com/install-mcrypt-php-mac-osx-10-9-mavericks-development-server/
- http://www.gigoblog.com/2013/11/14/rebuilding-php-extensions-to-work-with-mac-os-x-mavericks-server-and-php-5-4/
- http://computers.tutsplus.com/tutorials/perfect-configurations-with-homebrew-and-cask--cms-20768

#####MKV

- http://www.bunkus.org/videotools/mkvtoolnix/downloads.html
- https://github.com/BrunoReX/jmkvpropedit
