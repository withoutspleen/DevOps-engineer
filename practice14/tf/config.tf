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
   " serviceusage.googleapis.com " ])
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

resource "google_compute_instance" "test" {
  name = "test1"
  machine_type = "e2-small"
  zone = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
  network_interface {
    network = "default"
  }
metadata_startup_script = <<EOF
#!/bin/bash
apt update -y
apt install maven git -y
cd /tmp/
git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
cd boxfuse-sample-java-war-hello
mvn package
EOF

depends_on = [google_project_service.api, google_compute_firewall.tomcat]
  }