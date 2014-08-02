#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "a1-build-release.bash: no BuildRoot defined"
	exit
fi

for i in $@;
do
    COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/$i && make BuildProduct=amber BuildConfig=release &&"
done

COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/shell && make BuildProduct=amber BuildConfig=release &&"
COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/amber && make BuildProduct=amber BuildConfig=release"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
