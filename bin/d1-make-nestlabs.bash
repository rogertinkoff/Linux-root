#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "d1-make-nestlabs.bash: no BuildRoot defined"
	exit
fi

COMMAND="cd $BuildRoot/sw/nestlabs && make BuildProduct=topaz BuildConfig=development"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
