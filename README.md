[![Quarkus](https://design.jboss.org/quarkus/logo/final/PNG/quarkus_logo_horizontal_rgb_1280px_default.png#gh-light-mode-only)](https://quarkus.io/#gh-light-mode-only)
[![Quarkus](https://design.jboss.org/quarkus/logo/final/PNG/quarkus_logo_horizontal_rgb_1280px_reverse.png#gh-dark-mode-only)](https://quarkus.io/#gh-dark-mode-only)

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

For non-Quarkus applications, pass the classname (like `Hello`) as input arg to make target (`ISQUARKUS` arg is defaulted to `false`):
```
make nativeimage CLASSNAME=Hello
```

For Quarkus applications, pass the jarname (like `getting-started-1.0.0-SNAPSHOT-runner`) as input to `CLASSNAME` arg, along with setting `ISQUARKUS` arg to `true`:

Note: The jar is built and packaged from the corresponding Quarkus project by running `./mvnw package -Dnative`.
This produces a jar in `target/*-1.0.0-SNAPSHOT-native-image-source-jar/*-1.0.0-SNAPSHOT-runner.jar` along with a `lib/` directory.
You will need to move the `*-1.0.0-SNAPSHOT-runner.jar` and `lib/` to `nativejdb/apps/` before running the following command:

```
make nativeimage CLASSNAME=getting-started-1.0.0-SNAPSHOT-runner ISQUARKUS=true
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