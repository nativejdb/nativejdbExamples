# NativeJDBExamples Repository

Main repo: https://github.com/nativejdb/nativejdb

## Getting started

### Checkout NativeJDB and NativeJDBExamples

1. Clone each repository to your machine:

**Note:** `nativejdb` repository must be cloned at the same parent level as `nativejdbExamples` for Docker's volume to file system mapping to work. 
This repository `make` targets output the native image executable and debug sources into `nativejdb`'s `/apps` directory.

```shell
git clone git@github.com:nativejdb/nativejdb.git (IF NOT CLONED ALREADY)
git clone git@github.com:nativejdb/nativejdbExamples.git
cd nativejdbExamples
```
### Generating native image executable for an example application

#### 1. Download GraalVM

To generate a native executable within the Linux environment in the Docker container, you will need to download graalvm binary from https://github.com/graalvm/graalvm-ce-builds/releases and untar `graalvm-ce-java11-linux-amd64-*.tar.gz` into the same `NativeJDB` directory.

```
 make graalvm
```

#### 2. Run the following command via a terminal to generate native image executable and debug sources for your application (generation takes a few mins):

- Start Docker Desktop

For existing example application (Hello), run this:
```
make nativeimage
```

For any other application, pass the class name as input arg to make target:
```
make nativeimage CLASSNAME=****
```

**Reminder**: Running `make nativeimage` outputs the native image executable and debug sources into `nativejdb`'s `/apps` directory which will be used by the debugger in the next setup.

Run the following command via a terminal to ssh into docker container:

```
make exec
```

Run the following command via a terminal to stop and remove existing docker container:

```
make stop
```

### Setup NativeJDB Debugger to start debugging your native image executable generated

Now, we will switch projects or directories to follow instructions for [compiling](https://github.com/nativejdb/nativejdb/blob/main/DEVELOPMENT.md#compiling-your-nativejdb-code) and 
[running](https://github.com/nativejdb/nativejdb/blob/main/DEVELOPMENT.md#running-your-nativejdb-code) NativeJDB Debugger on Docker.

This will start a `nativejdb` running Docker container.

### Connect IntelliJ Debugger to running `nativejdb` Docker container:

Set breakpoints in the source code file for your example application in this project (for example: [src/Hello/Hello.java](./src/Hello/Hello.java)

On IntelliJ, back from `nativeJDBExamples` open project: Run ---> Remote JVM Debug --> [Hello](./.run/Hello.run.xml)