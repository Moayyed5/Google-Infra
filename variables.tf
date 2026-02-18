variable "gcp_project_id" {
    description = "This is gcp project id"
    type        = string
#    default = "first-project-487719"
}

variable "region" {
    description = "This is gcp region"
    type        = string
#    default = "us-central1"
}

variable "zone" {
  description = "This is GCP Zone"
  type        = string
#  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "terraform-gke-cluster"
}

variable "machine_type" {
  description = "Node pool instance type"
  type        = string
  default     = "e2-medium"
}

variable "network" {
  description = "VPC network name"
  type        = string
  default     = "custom_vpc"
}

variable "subnetwork" {
  description = "Subnetwork name"
  type        = string
  default     = "custom_subnetwork"
}

variable "node_count" {
  description = "Number of nodes per zone"
  type        = number
  default     = 1
}

variable "vm_name" {
  description = "This is Name of the VM"
  type        = string
#  default     = "my-vm"
}
