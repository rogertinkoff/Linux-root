#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "d1-build-release.bash: no BuildRoot defined"
	exit
fi

for i in $@;
do
    COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/$i && make BuildProduct=topaz BuildConfig=release &&"
done

COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/shell && make BuildProduct=topaz BuildConfig=release &&"
COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/topaz && make BuildProduct=topaz BuildConfig=release"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
