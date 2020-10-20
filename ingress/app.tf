##############################################################################
# Get ALB list, separated by a semicolon
##############################################################################

locals {
  alb_list = join(";", [
    for i in data.ibm_container_vpc_cluster.cluster.albs:
    i.id if i.enable
  ])
}

##############################################################################

##############################################################################
# Test App Deployment
##############################################################################

resource kubernetes_deployment app_deployment {
  metadata {
    name      = var.app_name
    namespace = var.namespace

    labels = {
      app = var.app_name
    }
  }

  spec {
    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          name  = var.container_name
          image = var.app_image
        
          env {
            name  = "PORT"
            value = var.app_port
          }
        }
      }
    }
  }
}

##############################################################################


##############################################################################
# Nodeport Service
##############################################################################

resource kubernetes_service app_service_alb {
  metadata {
    name      = "${var.app_name}-service-alb"
    namespace = var.namespace

    labels = {
      app = "${var.app_name}-alb"
    }
  }

  spec {
    port {
      port = var.service_port
    }

    selector = {
      app = kubernetes_deployment.app_deployment.metadata.0.name
    }

    type = "NodePort"
  }

  depends_on = [kubernetes_deployment.app_deployment]
}

##############################################################################


##############################################################################
# Ingress Setup
##############################################################################

resource kubernetes_ingress myingress {
  
  metadata {
    name      = "${var.app_name}-ingress"
    namespace = var.namespace

    annotations = {
      "ingress.bluemix.net/ALB-ID" = local.alb_list
    }
  }

  spec {
    rule {
      host = "${var.app_name}.${data.ibm_container_vpc_cluster.cluster.ingress_hostname}"

      http {
        path {
          path = "/"

          backend {
            service_name = kubernetes_service.app_service_alb.metadata.0.name
            service_port = var.service_port
          }
        }
      }
    }
  }

  depends_on = [kubernetes_service.app_service_alb]

}

##############################################################################