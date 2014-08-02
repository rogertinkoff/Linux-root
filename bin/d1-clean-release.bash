#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "d1-clean-release.bash: no BuildRoot defined"
	exit
fi

for i in $@;
do
    COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/$i && make BuildProduct=topaz BuildConfig=release clean &&"
done

COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/shell && make BuildProduct=topaz BuildConfig=release clean &&"
COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/topaz && make BuildProduct=topaz BuildConfig=release clean"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
