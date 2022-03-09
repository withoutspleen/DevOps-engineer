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

resource "google_compute_firewall" "web" {
  name    = "tomcat-access"
  network = "default"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports = ["8080", "443", "22", "80"]
  }

}

##
## BUILD INSTANCE
##

resource "google_compute_instance" "build" {
  name         = "build"
  machine_type = "e2-small"
  zone         = "us-central1-a"
  # for default firewall use  tags = ["http-server","https-server"]
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
    # for startup script use startup-script = file("build.sh")
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

  provisioner "remote-exec" {
    script      = "build.sh"

    connection {
      type        = "ssh"
      user        = "withoutspleen"
      private_key = file("~/.ssh/gcp-key")
      agent       = "false"
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }

  depends_on = [google_project_service.api, google_compute_firewall.web]
}

##
## PRODUCTION INSTANCE
##

resource "google_compute_instance" "production" {
  name         = "production"
  machine_type = "e2-small"
  zone         = "us-central1-a"
  # for default firewall use  tags = ["http-server","https-server"]
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
    # for startup script use startup-script = file("prod.sh")
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

  provisioner "remote-exec" {
    script      = "prod.sh"

    connection {
      type        = "ssh"
      user        = "withoutspleen"
      private_key = file("~/.ssh/gcp-key")
      agent       = "false"
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }

  depends_on = [google_project_service.api, google_compute_firewall.web]
}
