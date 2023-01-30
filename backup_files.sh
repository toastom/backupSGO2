#!/bin/bash

# Backup Documents, Downloads, and Pictures to SD card
readonly SD_CARD_DIR="/media/toastom/BC0D-7F19"
readonly SGO_DIR="$SD_CARD_DIR/SGO2 Backups"
readonly HOME_DIR="/home/toastom"

# Check if SD card is inserted

if [[ ! -d $SD_CARD_DIR ]]; then
	echo "$0 ERROR: SD card is not inserted"
	exit 1
fi

# Make sure the SGO2 Backups folder is on the card
# This is where we will store all subsequent backups

echo -e "SD card found at $SD_CARD_DIR \n"
if [[ ! -d $SGO_DIR ]]; then
	echo -e "Folder 'SGO2 Backups' not found\n"
	echo -e "Creating this folder at '$SGO_DIR'. Prior backups may be missing or stored in another location.\n"
	mkdir "$SGO_DIR"
	echo -e "Successfully created '$SGO_DIR' \n"
else
	echo -e "Backup directory '$SGO_DIR' has been found \n"
fi

# Create new backup directory with date, day, and time label

readonly DATE=$(date -I)
readonly DAY=$(date | cut -d ' ' -f 1)
readonly TIME=$(date +"%H-%M-%S")
readonly BACKUP_DIR="$SGO_DIR/Backup $DAY $DATE $TIME"

# Create the backup

mkdir "$BACKUP_DIR"

echo "Backing up $HOME_DIR/Documents to SD card"
if [[ -d "$HOME_DIR/Documents" ]]; then
	echo -n "Copying files..."
	cp -r "$HOME_DIR/Documents" "$BACKUP_DIR/"
	echo -e "done\n"
else
	echo -e "$HOME_DIR/Documents not found\n"
fi

echo "Backing up $HOME_DIR/Downloads to SD card"
if [[ -d "$HOME_DIR/Downloads" ]]; then
	echo -n "Copying files..."
	cp -r "$HOME_DIR/Downloads" "$BACKUP_DIR/"
	echo -e "done\n"
else
	echo -e "$HOME_DIR/Downloads not found\n"
fi

echo "Backing up $HOME_DIR/Pictures to SD card"
if [[ -d "$HOME_DIR/Pictures" ]]; then
	echo -n "Copying files..."
	cp -r "$HOME_DIR/Pictures" "$BACKUP_DIR/"
	echo -e "done\n"
else
	echo -e "$HOME_DIR/Pictures not found\n"
fi

echo "Backup complete! Files saved to '$BACKUP_DIR'"
