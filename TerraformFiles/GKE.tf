# Define required Terraform and provider versions
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }

  # Backend configuration for Google Cloud Storage
  backend "gcs" {
    bucket = "my-terrform-state-oksana-flask-project"
    prefix = "terraform/state"
  }
}

# Variable definitions to make the configuration more modular
variable "project_id" {
  description = "The ID of the Google Cloud project"
  default     = "ultra-palisade-393305"
}

variable "region" {
  description = "The Google Cloud region"
  default     = "me-west1"
}

variable "zone" {
  description = "The Google Cloud zone"
  default     = "me-west1-a"
}

# Provider configuration for Google Cloud
provider "google" {
  project = var.project_id
  region  = var.region
}

# Local values for constants or computations
locals {
  oauth_scopes = [
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring"
  ]
}

# VPC Network Configuration
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = true

  lifecycle {
    ignore_changes = all
  }
}

# GKE Cluster Configuration with default node pool
resource "google_container_cluster" "primary" {
  name       = "cluster-flask2"
  location   = var.zone
  network    = google_compute_network.vpc_network.name
  node_pool {
    name       = "default-pool"
    node_count = 1

    node_config {
      preemptible  = false
      machine_type = "e2-small"
      disk_size_gb = 30
      image_type   = "COS_CONTAINERD"

      metadata = {
        disable-legacy-endpoints = "true"
      }

      oauth_scopes = local.oauth_scopes
    }

    management {
      auto_repair  = true
      auto_upgrade = true
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# Firewall Rule for NodePort Range
resource "google_compute_firewall" "gke_nodeport_rule" {
  name    = "allow-gke-nodeport"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  allow {
    protocol = "udp"
    ports    = ["30000-32767"]
  }

  # Apply the rule to all instances in the network
  source_ranges = ["0.0.0.0/0"]

  depends_on = [google_container_cluster.primary]
}