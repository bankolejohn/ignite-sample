# Define the provider
provider "kubernetes" {
  config_path      = "~/.kube/config"
  load_config_file = "true"
}

# Define the KIND cluster
resource "kubernetes_cluster" "kind_cluster" {
  name = "kind-cluster"

  worker_node_pool {
    name  = "worker"
    count = 1
    config {
      kubernetes_version = "v1.22.0"
      # Add additional worker node pool configuration if needed
    }
  }
}

# Deploy the Node.js application on Kubernetes

# Create a Kubernetes namespace for the application
resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = "myapp"
  }
}

# Create a Kubernetes deployment for the Node.js application
resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = "myapp"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "myapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "myapp"
        }
      }

      spec {
        container {
          image = "node:14"
          name  = "myapp"

          # Specify the container ports
          port {
            container_port = 3000
          }

          # Specify the command and arguments for running the Node.js application
          command = ["node"]
          args    = ["/app/index.js"]
        }
      }
    }
  }
}
