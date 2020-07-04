#!/bin/bash
TARGET="/Users/bkilleen/Desktop/ACTIONS/Test/"
CC_APP_DIR="/Users/bkilleen/Desktop/ACTIONS/Colorway.app"
#find /Users/bkilleen/Desktop/ACTIONS -name "*prod19770036*"

while IFS=',' read -a file; do 
	DONOR_SOURCE="${file[0]}"
	MAIN_SOURCE="${file[1]}"
	
	DONOR_FNAME=$(basename $DONOR_SOURCE)
	DONOR_PATH=$(dirname $DONOR_SOURCE)
	
	MAIN_FNAME=$(basename $MAIN_SOURCE)
	MAIN_WIPS_PATH=$(dirname $MAIN_SOURCE)
	MAIN_TIF_PATH=${MAIN_WIPS_PATH/WIPS/Processed}

	DESTNAME="${TARGET}${DONOR_FNAME}"

	echo "THE DONOR PATH IS: $DONOR_SOURCE"
	echo "THE MAIN PATH IS:  $MAIN_SOURCE"
	echo $DONOR_FNAME
	echo $DONOR_PATH
	echo $MAIN_FNAME
	echo $MAIN_WIPS_PATH
	echo $MAIN_TIF_PATH
	echo $DESTNAME

	rsync -av $DONOR_SOURCE $TARGET
	mv $TARGET$DONOR_FNAME $TARGET$MAIN_FNAME$DONOR_FNAME
	xattr -w "MAIN_WIPS_PATH" $MAIN_WIPS_PATH $TARGET$MAIN_FNAME$DONOR_FNAME
	xattr -w "MAIN_TIF_PATH" $MAIN_TIF_PATH $TARGET$MAIN_FNAME$DONOR_FNAME
	open -a $CC_APP_DIR $TARGET$MAIN_FNAME$DONOR_FNAME;

done < /Users/bkilleen/Desktop/Coding/Bash-Scripts/ToMove.txt

osascript -e 'display notification "All files moved to local directory /Users/bkilleen/Desktop/ACTIONS/Test/" with title "Batch File Transfer is Complete"'