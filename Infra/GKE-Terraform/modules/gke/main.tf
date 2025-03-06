resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-central1-a"
  initial_node_count = 1  # Uses default node pool
  deletion_protection = false 

  node_config {
    machine_type = "e2-standard-4"
    disk_size_gb = 50  #Reduce default disk size from 100GB to 50GB
    preemptible  = true
  }
}
