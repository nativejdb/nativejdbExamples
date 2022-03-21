# NativeJDB Examples Repository

Main repo: https://github.com/nativejdb/nativejdb

#### 1. Download GraalVM

To generate a native executable within the Linux environment in the Docker container, you will need to download graalvm binary from https://github.com/graalvm/graalvm-ce-builds/releases and untar `graalvm-ce-java11-linux-amd64-*.tar.gz` into the same `NativeJDB` directory.

```
 make graalvm
```

#### 2. Run the following command via a terminal to generate native image executable and debug sources for your application (generation takes a few mins):

For existing example application (Hello), run this:
```
make nativeimage
```

For any other application, pass the class name as input arg to make target:
```
make nativeimage CLASSNAME=****
```

Run the following command via a terminal to ssh into docker container:

```
make exec
```
