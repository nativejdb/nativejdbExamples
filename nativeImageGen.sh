#!/bin/bash

while getopts c:k: flag
do
    case "${flag}" in
        c) CLASS_NAME=${OPTARG};;
        k) IS_QUARKUS=${OPTARG};;
        *) ;;
    esac
done

IMAGE_NAME=$CLASS_NAME
SOURCES_DIR=/jdwp/apps/${CLASS_NAME}sources

# Usage: native-image [options] class [imagename] [options]
#    or  native-image [options] -jar jarfile [imagename] [options]
if [ "$IS_QUARKUS" == "true" ];
then
  #Expecting quarkus jar to already exist in apps/ - built and packaged by Quarkus project via ./mvnw package -Dnative
  #Jar will be in target/*-1.0.0-SNAPSHOT-native-image-source-jar/*-1.0.0-SNAPSHOT-runner.jar along with a lib/ directory
  #Move the *-1.0.0-SNAPSHOT-runner.jar and lib/ to apps/
  echo "Building $CLASS_NAME executable...(expecting quarkus jar and lib to already exist in apps/ - built and packaged by Quarkus project)"
  cd /jdwp/apps && $GRAALVM_HOME/bin/native-image -g -O0
  -H:-SpawnIsolates -H:+SourceLevelDebug -H:-OmitInlinedMethodDebugLineInfo -H:DebugInfoSourceSearchPath=/jdwp/src -J-Dsun.nio.ch.maxUpdateArraySize=100 -J-Djava.util.logging.manager=org.jboss.logmanager.LogManager -J-Dvertx.logger-delegate-factory-class-name=io.quarkus.vertx.core.runtime.VertxLogDelegateFactory -J-Dvertx.disableDnsResolver=true -J-Dio.netty.leakDetection.level=DISABLED -J-Dio.netty.allocator.maxOrder=3 -J-Duser.language=en -J-Duser.country=US -J-Dfile.encoding=UTF-8 -H:-ParseOnce -J--add-exports=java.security.jgss/sun.security.krb5=ALL-UNNAMED -J--add-opens=java.base/java.text=ALL-UNNAMED -H:InitialCollectionPolicy=com.oracle.svm.core.genscavenge.CollectionPolicy\$BySpaceAndTime -H:+JNI -H:+AllowFoldMethods -J-Djava.awt.headless=true -H:FallbackThreshold=0 -H:+ReportExceptionStackTraces -H:-AddAllCharsets -H:EnableURLProtocols=http -H:NativeLinkerOption=-no-pie -H:-UseServiceLoaderFeature -cp $CLASS_NAME.jar -H:Name=$CLASS_NAME -H:DebugInfoSourceCacheRoot=$SOURCES_DIR -H:+StackTrace $CLASS_NAME -jar $CLASS_NAME.jar
else
  #Compile all java classes and build a Jar file to be put into apps dir
  javac -g src/$CLASS_NAME/*.java
  cd /jdwp/src && jar -cfe $CLASS_NAME.jar $CLASS_NAME/$CLASS_NAME $CLASS_NAME/*.class && cp $CLASS_NAME.jar /jdwp/apps

  echo "Building $CLASS_NAME executable..."
  cd /jdwp/apps && $GRAALVM_HOME/bin/native-image -g -O0 -H:-SpawnIsolates -H:+SourceLevelDebug -H:-OmitInlinedMethodDebugLineInfo -H:DebugInfoSourceSearchPath=/jdwp/src -cp $CLASS_NAME.jar -H:Class=$CLASS_NAME.$CLASS_NAME -H:Name=$IMAGE_NAME -H:DebugInfoSourceCacheRoot=$SOURCES_DIR
fi

#Exit with status of process
exit $?
