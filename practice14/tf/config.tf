terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.12.0"
    }
  }
}

provider "google" {
  credentials = file("gcp-creds.json")
  project     = "master-imagery-335207 "
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_compute_instance" "test" {
  name = "test1"
  machine_type = "e2-small"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"
  }
}