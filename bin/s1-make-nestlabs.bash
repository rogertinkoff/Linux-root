#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "s1-make-nestlabs.bash: no BuildRoot defined"
	exit
fi

COMMAND="cd $BuildRoot/sw/nestlabs && make BuildProduct=j49 BuildConfig=development"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
