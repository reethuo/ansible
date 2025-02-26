provider "google" {
  project     = "aswini-447207"  # Your Google Cloud project ID
  region      = "us-central1"     # Your desired region
}

resource "google_compute_instance_template" "default" {
  name           = "centos-instance-template"
  machine_type   = "e2-medium"
  region         = "us-central1"

  disk {
    auto_delete  = true
    boot         = true
    # Use CentOS 9 image from the Google Cloud project
    image = "projects/centos-cloud/global/images/centos-9-v20220510"
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_instance_group_manager" "default" {
  name               = "centos-instance-group"
  version {
    instance_template = google_compute_instance_template.default.id
  }
  base_instance_name = "centos-instance"
  target_size        = 2
  zone               = "us-central1-a"

  named_port {
    name = "http"
    port = 80
  }
}
