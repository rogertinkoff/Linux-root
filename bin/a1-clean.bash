#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "a1-clean.bash: no BuildRoot defined"
	exit
fi

for i in $@;
do
    COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/$i && make BuildProduct=amber BuildConfig=development clean &&"
done

COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/shell && make BuildProduct=amber BuildConfig=development clean &&"
COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/amber && make BuildProduct=amber BuildConfig=development clean"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
