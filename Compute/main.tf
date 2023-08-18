# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "vm-wo-pre-ops-agent" {
  boot_disk {
    auto_delete = true
    device_name = "vm-wo-pre-ops-agent"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230809"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-small"
  name         = "vm-wo-pre-ops-agent"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/serverless-gcp-391314/regions/us-west4/subnetworks/vpc-auto-mode-gcp-console"
  }

  scheduling {
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
    preemptible         = false
    provisioning_model  = "SPOT"
  }

  service_account {
    email  = "232560180807-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = "us-west4-b"
}
