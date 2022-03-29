#!/bin/bash

while getopts c: flag
do
    case "${flag}" in
        c) CLASS_NAME=${OPTARG};;
        *) ;;
    esac
done

cp -r src/* apps/
javac apps/$CLASS_NAME/*.java

IMAGE_NAME=debugeeImg

# Usage: native-image [options] class [imagename] [options]
#    or  native-image [options] -jar jarfile [imagename] [options]
cd /jdwp/apps && jar -cfe $CLASS_NAME.jar $CLASS_NAME/$CLASS_NAME $CLASS_NAME/*.class && $GRAALVM_HOME/bin/native-image -g -O0 -H:-OmitInlinedMethodDebugLineInfo -cp $CLASS_NAME.jar $CLASS_NAME.$CLASS_NAME $IMAGE_NAME

#Exit with status of process
exit $?
