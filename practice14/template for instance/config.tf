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

resource "google_compute_instance" "build" {
  name         = "build"
  machine_type = "e2-small"
  zone         = "us-central1-a"
  tags = ["http-server","https-server"]
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
    ssh-keys = "root:${file("~/.gcp/gcp-key.pub")}"
  }

  output "instance_ip_address" {
    value = "$self.network_interface[0].access_config[0].nat_ip"
  }
}