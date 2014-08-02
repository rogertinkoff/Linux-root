#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "d1-build-unopt.bash: no BuildRoot defined"
	exit
fi

for i in $@;
do
    COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/$i && make BuildProduct=topaz BuildConfig=development OPTIMIZER=\"-O0 -g\" &&"
done

COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/shell && make BuildProduct=topaz BuildConfig=development &&"
COMMAND="$COMMAND cd $BuildRoot/sw/nestlabs/apps/topaz && make BuildProduct=topaz BuildConfig=development"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
