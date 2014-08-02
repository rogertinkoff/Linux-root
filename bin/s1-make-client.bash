#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "s1-make-client.bash: no BuildRoot defined"
	exit
fi

COMMAND="cd $BuildRoot/sw/nestlabs/app/client && make BuildProduct=j49 BuildConfig=development"

echo $COMMAND
eval $COMMAND

cd $BuildRoot
