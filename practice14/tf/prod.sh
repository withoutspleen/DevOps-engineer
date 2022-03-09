#!/bin/bash
sudo apt update
sudo apt install tomcat -y
sudo apt install apt-transport-https ca-certificates gnupg -y
sudo echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt update
sudo apt install google-cloud-cli -y
sudo yes | gcloud auth login --cred-file=/tmp/gcp-creds.json
sudo gsutil cp gs://test-bucket-practice/hello-1.0.war /var/lib/tomcat9/webapps/
sudo service tomcat restart
exit