#!/usr/bin/env bash
source config.sh

if [ -e /usr/local/bin/brew ] ; then
 printf "$PRINTF_MASK" "Homebrew detected, updating..." "$YELLOW" "[WAIT]" "$RESET"
 brew update
 brew doctor
 brew upgrade
else
  printf "$PRINTF_MASK" "Homebrew not detected" "$RED" "[ERR]" "$RESET"
  exit 1
fi

if [ ! -e /usr/local/bin/mysql ] ; then
  printf "$PRINTF_MASK" "MySQL not detected, installing..." "$YELLOW" "[WAIT]" "$RESET"
  if [ -f /etc/my.cnf ] ; then
    printf "$PRINTF_MASK" "/etc/my.cnf file detected, renaming file..." "$YELLOW" "[WAIT]" "$RESET"
  else
    printf "$PRINTF_MASK" "/etc/my.cnf not detected" "$GREEN" "[OK]" "$RESET"
  fi
  brew install mysql
else
  printf "$PRINTF_MASK" "MySQL detected" "$GREEN" "[OK]" "$RESET"
fi


/usr/local/bin/mysqladmin ping| grep 'mysqld is alive' > /dev/null 2>&1
if [ $? != 0 ]; then
  printf "$PRINTF_MASK" "Starting up MySQL..." "$YELLOW" "[WAIT]" "$RESET"
  mysql.server start
else
  printf "$PRINTF_MASK" "MySQL started" "$GREEN" "[OK]" "$RESET"
fi

printf "$PRINTF_MASK" "Securing MySQL installation..." "$YELLOW" "[WAIT]" "$RESET"
mysql_secure_installation


##### TESTING #####
exit 0
##### TESTING #####





printf "$PRINTF_MASK" "Configuring allow MySQL to run under current account" "$YELLOW" "[WAIT]" "$RESET"
## Allow MySQL to run under the current account:
unset TMPDIR
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp


##### NOTES #####
##  A "/etc/my.cnf" from another install may interfere with a Homebrew-built server starting up correctly.
## 
## To connect:
##     mysql -uroot
## 
## To have launchd start mysql at login:
##     ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
## Then to load mysql now:
##     launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
## Or, if you don't want/need launchctl, you can just run:
##     mysql.server start
    

##### TESTING #####
exit 0
##### TESTING #####

## http://blog.joefallon.net/2013/10/install-mysql-on-mac-osx-using-homebrew/
## http://hivelogic.com/articles/installing-mysql-on-mac-os-x/
## http://theablefew.com/blog/very-simple-homebrew-mysql-and-rails
## --------------------

## /usr/local/opt/mysql/bin/mysqladmin -u root password 'new-password'
## /usr/local/opt/mysql/bin/mysqladmin -u root -h Pooky.local password 'new-password'
##
## Alternatively you can run:
##   /usr/local/opt/mysql/bin/mysql_secure_installation
##
## You can start the MySQL daemon with:
##   cd /usr/local/opt/mysql ; /usr/local/opt/mysql/bin/mysqld_safe &
##
## You can test the MySQL daemon with mysql-test-run.pl
##   cd /usr/local/opt/mysql/mysql-test ; perl mysql-test-run.pl

#/usr/local/Cellar/mysql/5.5.29/bin/mysqladmin -u root password 'YOUR_NEW_PASSWORD'
#/usr/local/Cellar/mysql/5.5.29/bin/mysqladmin -u root password '$MYSQL_PASSWORD'


mkdir -p ~/Library/LaunchAgents
#cp /usr/local/Cellar/mysql/5.5.29/homebrew.mxcl.mysql.plist ~/Library/LaunchAgents/
#launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

/usr/local/Cellar/mysql/5.5.29/bin/mysql_secure_installation

sudo mkdir /var/mysql
sudo ln -s /private/tmp/mysql.sock /var/mysql/mysql.sock


## ??? ERROR DUE TO MY.CONF ???
#if [ ! -e $DIR/conf/my.conf ] ; then
#	sudo cp $DIR/conf/my.conf /etc/my.cnf
#else
#	#sudo cp $(brew --prefix mysql)/support-files/my-small.cnf /etc/my.cnf
#    sudo cp $(brew --prefix mysql)/support-files/my-medium.cnf /etc/my.cnf
#
#    # https://newznab.readthedocs.org/en/latest/install/
#    echo "-----------------------------------------------------------"
#    echo "| Change the following information:"
#    echo "| [mysqld]"
#    echo "| ;max_allowed_packet = 1M"
#    echo "| max_allowed_packet = 12582912"
#    echo "| "
#    echo "| ?? group_concat_max_len = 8192 ??"
#    sudo subl /etc/my.cnf
#fi

mysql.server start

mysql.server status
