#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "a1-build.bash: no BuildRoot defined"
	exit
fi

for i in $@;
do
    COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/$i && make BuildProduct=amber BuildConfig=development &&"
done

COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/shell && make BuildProduct=amber BuildConfig=development &&"
COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/amber && make BuildProduct=amber BuildConfig=development"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
