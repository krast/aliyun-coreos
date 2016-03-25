#!/bin/bash

VERSION="$1"
URL="http://127.0.0.1"
HOME="/home/coreos_updates/amd64-usr"
D_URL="https://commondatastorage.googleapis.com/update-storage.core-os.net/amd64-usr"

if [ ! -d $HOME ]; then
    mkdir -p $HOME
fi

if [ ! -d $VERSION ]; then
    mkdir -p $VERSION
fi

#if [ ! -f $VERSION/update.gz ]; then
#        wget -qP $VERSION $D_URL/$VERSION/update.gz
#fi

SIZE=$(stat -c %s ${HOME}/${VERSION}/update.gz)
SHA1_b64=$(echo -ne "$(echo -n $(sha1sum ${HOME}/${VERSION}/update.gz | awk '{print $1}') | sed -e 's/../\\x&/g')" | base64 )
SHA256_b64=$(echo -ne "$(echo -n $(sha256sum ${HOME}/${VERSION}/update.gz | awk '{print $1}') | sed -e 's/../\\x&/g')" | base64)

XML="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<response protocol=\"3.0\" server=\"update.core-os.net\">
 <daystart elapsed_seconds=\"0\"></daystart>
 <app appid=\"e96281a6-d1af-4bde-9a0a-97b76e56dc57\" status=\"ok\">
  <updatecheck status=\"ok\">
   <urls>
    <url codebase=\"${URL}/${VERSION}/\"></url>
   </urls>
   <manifest version=\"${VERSION}\">
    <packages>
     <package hash=\"${SHA1_b64}\" name=\"update.gz\" size=\"${SIZE}\" required=\"false\"></package>
    </packages>
    <actions>
     <action event=\"postinstall\" ChromeOSVersion=\"\" sha256=\"${SHA256_b64}\" needsadmin=\"false\" IsDelta=\"false\" DisablePayloadBackoff=\"true\"></action>
    </actions>
   </manifest>
  </updatecheck>
 </app>
</response>"

echo "$XML" > $VERSION/index.html
