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

resource "google_compute_firewall" "open-all" {
  name    = "open-all-ports"
  network = "default"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports = ["1-65535"]
  }

}

resource "google_compute_instance" "practice" {
  name         = "practice"
  machine_type = "custom-${var.cpu}-${var.memory}"
  zone         = "us-central1-a"
  tags         = ["http-server", "https-server"]
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
}
