variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default = "norse-glow-452406-g1"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default = "central1"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "my-gke-cluster"
}

variable "node_count" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 1
}
