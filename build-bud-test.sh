#!/bin/bash

BASE_IMAGE=alpine
TARGET_IMAGE=python3-minimal

# check user or root running with UID
if [ $UID != 0 ]; then
	echo "### Running build test as unprivileged user"
else
	echo "### Running build test as root"
fi

echo "### Testing container creation"

# Creates a new container
container=$(buildah from $BASE_IMAGE)
if [ $? -ne 0 ]; then
	echo "Error initializing working container"
fi

echo "### Testing run command"
buildah run $container apk add --update python3 py3-pip
if [ $? -ne 0 ]; then
	echo "Error run build action"
fi

echo "### Testing image commit"
buildah commit $container $TARGET_IMAGE
if [ $? -ne 0 ]; then
	echo "Error comitting final image"

fi

echo "### Removing working container"
if [ $? -ne 0 ]; then
	echo"Error removing working container"
fi

echo"### Build test completed successfully!"
exit 0




