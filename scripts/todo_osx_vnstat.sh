

## http://www.qlambda.com/2013/07/running-vnstat-in-os-x.html
## https://forums.plex.tv/index.php/topic/93731-upsboard-usenet-plex-stats/

exit 0


brew install install vnstat

nano vnstat.conf
echo "# default interface"
echo "Interface: en0"
echo ""
echo "# location of the database directory"
echo "DatabaseDir : /opt/local/var/db/vnstat"

vnstat -u -i en0

/Library/LaunchDaemons/local.vnstat.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple/DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>local.vnstat</string>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/local/bin/vnstat</string>
        <string>-u</string>
    </array>
    <key>StartInterval</key>
    <integer>300</integer>
</dict>
</plist>

sudo chown root:wheel /Library/LaunchDaemons/local.vnstat.plist
sudo launchctl load /Library/LaunchDaemons/local.vnstat.plist
#sudo launchctl unload /Library/LaunchDaemons/local.vnstat.plist

vnstat #lists complete usage
vnstat -d #lists daily usage

sudo launchctl list | grep vnstat
