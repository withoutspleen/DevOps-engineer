#!/bin/bash
apt update
apt install maven git -y
cd /tmp
git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
cd boxfuse-sample-java-war-hello
mvn package
apt install apt-transport-https ca-certificates gnupg -y
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
apt update
apt install google-cloud-cli -y
yes | gcloud auth login --cred-file=/tmp/gcp-creds.json
gsutil cp target/hello-1.0.war gs://test-bucket-practice/