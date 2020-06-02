#!/bin/bash

# if a3config cannot be found, give the error message and exit with error code 1

if [ ! -f a3config ]
then
	echo "Error cannot find a3config"
	exit 1
fi

# execute a3config to store the env variables in it

source a3config

# if dirname or extension variables are empty strings or null, give error message and exit with error code 2

if [ "$DIRNAME" == "" ] || [ "$EXTENSION" == "" ]
then
	echo "Error DIRNAME and EXTENSION must be set"
	exit 2
fi

# if the directory does not exist, let the user know and exit with error code 3

if [ ! -d $DIRNAME ]
then
	echo "Error directory $DIRNAME does not exist"
	exit 3
fi

# store the pattern to search in a variable

ext=".$EXTENSION"

# search for the file with the given extension in the list of files and directories

if [ -z "`ls $DIRNAME | grep "$ext"`" ]

# if the no such file is found with the given extension, let the user know

then
	echo "Unable to locate any files with extension $EXTENSION in $DIRNAME"
	exit 0

# otherwise, if the show variable is true, loop through the matching files and print their contents

else
	if [ "$SHOW" == "true" ]
	then
		for i in $(ls $DIRNAME | grep "$ext")
		do
			echo "$DIRNAME/$i"
			cat $DIRNAME/$i
		done
		exit 0

# if show is false or the variable does not exist, only print the file location

	else
		for i in $(ls $DIRNAME | grep "$ext")
		do
			echo "$DIRNAME/$i"
		done
		exit 0
	fi
fi
