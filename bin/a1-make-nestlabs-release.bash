#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "a1-make-nestlabs.bash: no BuildRoot defined"
	exit
fi

COMMAND="cd $BuildRoot/sw/nestlabs && make BuildProduct=amber BuildConfig=release"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
