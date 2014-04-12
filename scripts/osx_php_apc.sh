#!/usr/bin/env bash
source config.sh

brew install pcre
sudo pecl install apc

echo "-----------------------------------------------------------"
echo "| Paste the information as seen in the installer:"
echo "| Enable per request file info  : No"
echo "| Enable spin locks             : No"
echo "| Enable memory protection      : No"
echo "| Enable pthread mutexes        : No"
echo "-----------------------------------------------------------"
echo " --- press any key to continue ---"
read -n 1 -s

## Add "extension=apc.so" to php.ini
if [ ! -f /Library/Server/Web/Config/php/php_apc.ini ] ; then
  printf "$PRINTF_MASK" "Copying Lauch Agent file: $INST_FILE_LAUNCHAGENT" "$YELLOW" "[WAIT]" "$RESET"
  sudo cp $DIR/config/launchctl/php/php_apc.ini /Library/Server/Web/Config/php/
  if [ "$?" != "0" ]; then
    echo -e "${RED}  ============================================== ${RESET}"
    echo -e "${RED} | ERROR ${RESET}"
    echo -e "${RED} | Copy failed: ${RESET}"
    echo -e "${RED}  ============================================== ${RESET}"
    read -n 1 -s
    exit 1
  fi
else
  printf "$PRINTF_MASK" "Copying config file php_apc.ini" "$GREEN" "[OK]" "$RESET"
fi

