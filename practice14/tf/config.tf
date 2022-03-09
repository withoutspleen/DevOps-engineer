terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.12.0"
    }
  }
}

provider "google" {
  credentials = file("~/.gcp/gcp-creds.json")
  project     = "master-imagery-335207"
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_project_service" "api" {
  for_each = toset ([
   "cloudresourcemanager.googleapis.com",
   "compute.googleapis.com"
  ])
  disable_on_destroy = false
  service = each.value
}

resource "google_compute_firewall" "tomcat" {
  name    = "tomcat-access"
  network = "default"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports = ["8080", "443", "22", "80"]
  }

}

resource "google_compute_instance" "build" {
  name         = "build"
  machine_type = "e2-small"
  zone         = "us-central1-a"
  #  tags = ["http-server","https-server"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys       = "withoutspleen:${file("~/.gcp/gcp-key.pub")}"
    startup-script = file("build.sh")
#    <<-EOF
#  apt update
#  apt install maven git -y
#  cd /tmp
#  git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
#  cd boxfuse-sample-java-war-hello
#  mvn package
#  apt install apt-transport-https ca-certificates gnupg -y
#  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
#  apt update
#  apt install google-cloud-cli -y
#  yes | gcloud auth login --cred-file=/tmp/gcp-creds.json
#  gsutil cp target/hello-1.0.war gs://test-bucket-practice/
#  EOF
  }

  provisioner "file" {
    source      = "~/.gcp/gcp-creds.json"
    destination = "/tmp/gcp-creds.json"

    connection {
      type        = "ssh"
      user        = "withoutspleen"
      private_key = file("~/.ssh/gcp-key")
      agent       = "false"
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }


  depends_on = [google_project_service.api, google_compute_firewall.tomcat]
}

#resource "google_compute_instance" "build" {
#  name         = "build"
#  machine_type = "e2-small"
#  zone         = "us-central1-a"
#  #  tags = ["http-server","https-server"]
#  boot_disk {
#    initialize_params {
#      image = "ubuntu-os-cloud/ubuntu-2004-lts"
#    }
#  }
#  network_interface {
#    network = "default"
#    access_config {}
#  }
#
#    metadata = {
#    ssh-keys       = "withoutspleen:${file("~/.gcp/gcp-key.pub")}"
#    startup-script = <<-EOF
#  apt update
#  apt install tomcat -y
#  apt install apt-transport-https ca-certificates gnupg -y
#  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
#  apt update
#  apt install google-cloud-cli -y
#  gcloud auth login --cred-file=/tmp/gcp-creds.json
#  gsutil cp target/hello-1.0.war gs://test-bucket-practice/
#  EOF
#  }
#
#  provisioner "file" {
#    source      = "~/.gcp/gcp-creds.json"
#    destination = "/tmp/gcp-creds.json"
#
#    connection {
#      type        = "ssh"
#      user        = "withoutspleen"
#      private_key = file("~/.ssh/gcp-key")
#      agent       = "false"
#      host        = self.network_interface[0].access_config[0].nat_ip
#    }
#  }
#
#
#  depends_on = [google_project_service.api, google_compute_firewall.tomcat]
#}
