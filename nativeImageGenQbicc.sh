#!/bin/bash

while getopts c:q: flag
do
    case "${flag}" in
        c) CLASS_NAME=${OPTARG};;
        q) QBICC_VERSION=${OPTARG};;
        *) ;;
    esac
done

cp -r src/* apps/
javac -source 11 -target 11 apps/$CLASS_NAME/*.java

IMAGE_NAME=debugeeImg

export PATH=/usr/lib/llvm-13/bin:$HOME/.jbang/bin:$PATH

export JDK_JAVA_OPTIONS=-Xss8m

# Make a jar file containing the input program
cd /jdwp/apps
jar -cfe $CLASS_NAME.jar $CLASS_NAME/$CLASS_NAME $CLASS_NAME/*.class


# Using qbicc to build a native image.
# Leave the 1000s of .ll and .s files in /tmp/output and only
# copy the actual executable to the /jdwp/apps volume.
rm -rf /tmp/output
jbang org.qbicc:qbicc-main:$QBICC_VERSION --boot-path-append-file $CLASS_NAME.jar --output-path /tmp/output -o $IMAGE_NAME $CLASS_NAME/$CLASS_NAME && cp /tmp/output/$IMAGE_NAME /jdwp/apps/$IMAGE_NAME



#Exit with status of process
exit $?
