#!/usr/bin/env bash

if [ ! -f config.sh ]; then
  source ../config.sh
else
  source config.sh
fi

echo "#------------------------------------------------------------------------------"
echo "# Creating Media folders"
echo "#------------------------------------------------------------------------------"

[ -d $INST_FOLDER_SERIES_COMPLETE ] || mkdir -p $INST_FOLDER_SERIES_COMPLETE
[ -d $INST_FOLDER_MOVIES_COMPLETE ] || mkdir -p $INST_FOLDER_MOVIES_COMPLETE

echo "#------------------------------------------------------------------------------"
echo "# Creating Media folders - Complete"
echo "#------------------------------------------------------------------------------"
