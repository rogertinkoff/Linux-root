#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "d1-install-app: no BuildRoot defined"
	return -1
fi

cd $BuildRoot/sw/nestlabs/apps/topaz
make BuildProduct=topaz BuildConfig=development Verbose= flash SUDO="sudo -E"
cd $BuildRoot