#!/bin/bash

if [ "$BuildRoot" == "" ];
then
	echo "d1-install-shell: no BuildRoot defined"
	return -1
fi

cd $BuildRoot/sw/nestlabs/apps/shell
make BuildProduct=topaz BuildConfig=development Verbose= flash-shell SUDO="sudo -E"
cd $BuildRoot