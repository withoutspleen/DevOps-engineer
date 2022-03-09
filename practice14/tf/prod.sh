#!/bin/bash
apt update
apt install tomcat9 -y
apt install apt-transport-https ca-certificates gnupg -y
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
apt update
apt install google-cloud-cli -y
yes | gcloud auth login --cred-file=/tmp/gcp-creds.json
gsutil cp gs://test-bucket-practice/hello-1.0.war /var/lib/tomcat9/webapps/
service tomcat9 restart