#!/bin/bash
set -e

LOCAL_REPO=$(mvn --batch-mode help:evaluate -Dexpression=settings.localRepository -q -DforceStdout)

GROUP_ID="me.friwi"

JOGL_ALL_VERSION="v2.4.0-rc-20210111"
JOGL_ALL_PATCHED_VERSION="2.4.0"

GLUEGEN_RT_VERSION="v2.4.0-rc-20210111"
GLUEGEN_RT_PATCHED_VERSION="2.4.0"

JCEF_API_VERSION="jcef-ca49ada+cef-135.0.20+ge7de5c3+chromium-135.0.7049.85"
JCEF_API_PATCHED_VERSION="135.0.20"

JCEF_NATIVES_WINDOWS_AMD64_VERSION="jcef-ca49ada+cef-135.0.20+ge7de5c3+chromium-135.0.7049.85"
JCEF_NATIVES_WINDOWS_AMD64_PATCHED_VERSION="135.0.20"

JCEF_MAVEN_VERSION="135.0.20"

mvn --batch-mode dependency:get \
  -DgroupId=$GROUP_ID \
  -DartifactId=jogl-all \
  -Dversion=$JOGL_ALL_VERSION \
  -Dtransitive=false

JAR_PATH="$LOCAL_REPO/$(echo $GROUP_ID | tr '.' '/')/jogl-all/$JOGL_ALL_VERSION/jogl-all-$JOGL_ALL_VERSION.jar"
POM_PATH="$LOCAL_REPO/$(echo $GROUP_ID | tr '.' '/')/jogl-all/$JOGL_ALL_VERSION/jogl-all-$JOGL_ALL_VERSION.pom"

mvn --batch-mode install:install-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=jogl-all \
  -Dversion=$JOGL_ALL_PATCHED_VERSION \
  -Dpackaging=jar \
  -Dfile="$JAR_PATH" \
  -DpomFile="$POM_PATH"

mvn --batch-mode dependency:get \
  -DgroupId=$GROUP_ID \
  -DartifactId=gluegen-rt \
  -Dversion=$GLUEGEN_RT_VERSION \
  -Dtransitive=false

JAR_PATH="$LOCAL_REPO/$(echo $GROUP_ID | tr '.' '/')/gluegen-rt/$GLUEGEN_RT_VERSION/gluegen-rt-$GLUEGEN_RT_VERSION.jar"
POM_PATH="$LOCAL_REPO/$(echo $GROUP_ID | tr '.' '/')/gluegen-rt/$GLUEGEN_RT_VERSION/gluegen-rt-$GLUEGEN_RT_VERSION.pom"

mvn --batch-mode install:install-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=gluegen-rt \
  -Dversion=$GLUEGEN_RT_PATCHED_VERSION \
  -Dpackaging=jar \
  -Dfile="$JAR_PATH" \
  -DpomFile="$POM_PATH"

mvn --batch-mode dependency:get \
  -DgroupId=$GROUP_ID \
  -DartifactId=jcef-api \
  -Dversion=$JCEF_API_VERSION \
  -Dtransitive=false

JAR_PATH="$LOCAL_REPO/$(echo $GROUP_ID | tr '.' '/')/jcef-api/$JCEF_API_VERSION/jcef-api-$JCEF_API_VERSION.jar"
POM_PATH="$LOCAL_REPO/$(echo $GROUP_ID | tr '.' '/')/jcef-api/$JCEF_API_VERSION/jcef-api-$JCEF_API_VERSION.pom"

sed -i "s/$JOGL_ALL_VERSION/$JOGL_ALL_PATCHED_VERSION/g" $POM_PATH

mvn --batch-mode install:install-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=jcef-api \
  -Dversion=$JCEF_API_PATCHED_VERSION \
  -Dpackaging=jar \
  -Dfile="$JAR_PATH" \
  -DpomFile="$POM_PATH"

mvn --batch-mode dependency:get \
  -DgroupId=$GROUP_ID \
  -DartifactId=jcef-natives-windows-amd64 \
  -Dversion=$JCEF_NATIVES_WINDOWS_AMD64_VERSION \
  -Dtransitive=false

JAR_PATH="$LOCAL_REPO/$(echo $GROUP_ID | tr '.' '/')/jcef-natives-windows-amd64/$JCEF_NATIVES_WINDOWS_AMD64_VERSION/jcef-natives-windows-amd64-$JCEF_NATIVES_WINDOWS_AMD64_VERSION.jar"
POM_PATH="$LOCAL_REPO/$(echo $GROUP_ID | tr '.' '/')/jcef-natives-windows-amd64/$JCEF_NATIVES_WINDOWS_AMD64_VERSION/jcef-natives-windows-amd64-$JCEF_NATIVES_WINDOWS_AMD64_VERSION.pom"

mvn --batch-mode install:install-file \
  -DgroupId=$GROUP_ID \
  -DartifactId=jcef-natives-windows-amd64 \
  -Dversion=$JCEF_NATIVES_WINDOWS_AMD64_PATCHED_VERSION \
  -Dpackaging=jar \
  -Dfile="$JAR_PATH" \
  -DpomFile="$POM_PATH"

mvn --batch-mode dependency:get \
  -DgroupId=$GROUP_ID \
  -DartifactId=jcefmaven \
  -Dversion=$JCEF_MAVEN_VERSION \
  -Dtransitive=false

JAR_PATH="$LOCAL_REPO/$(echo $GROUP_ID | tr '.' '/')/jcefmaven/$JCEF_MAVEN_VERSION/jcefmaven-$JCEF_MAVEN_VERSION.jar"
POM_PATH="$LOCAL_REPO/$(echo $GROUP_ID | tr '.' '/')/jcefmaven/$JCEF_MAVEN_VERSION/jcefmaven-$JCEF_MAVEN_VERSION.pom"

sed -i "s/$JCEF_API_VERSION/$JCEF_API_PATCHED_VERSION/g" $POM_PATH