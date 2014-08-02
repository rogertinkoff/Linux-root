#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "d1-clean.bash: no BuildRoot defined"
	exit
fi

for i in $@;
do
    COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/$i && make BuildProduct=topaz BuildConfig=development clean &&"
done

COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/shell && make BuildProduct=topaz BuildConfig=development clean &&"
COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/topaz && make BuildProduct=topaz BuildConfig=development clean"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
