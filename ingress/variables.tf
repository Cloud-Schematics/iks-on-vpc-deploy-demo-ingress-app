##############################################################################
# Account Variables
##############################################################################

variable ibmcloud_api_key {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  type        = string
}

variable generation {
  description = "Generation of VPC. Can be 1 or 2"
  type        = number
}

variable ibm_region {
  description = "IBM region for IKS on VPC cluster"
  type        = string
  default     = "us-south"
}

variable resource_group {
  description = "Name of resource group to provision resources"
  type        = string
  default     = "asset-development"
}

variable cluster_name {
  description = "name of IKS cluster"
  type        = string
}

##############################################################################

##############################################################################
# App Variables
##############################################################################

variable app_name {
  description = "Name for app in kubernetes"
  default     = "demo-app"
  type        = string
}

variable namespace {
  description = "Namespace to deploy application"
  default     = "default"
  type        = string
}

variable container_name {
  description = "Name for container in deployment"
  default     = "api-service"
  type        = string
}

variable app_image {
  description = "link to app image to install"
  type        = string
}

variable app_port {
  description = "Port for app to run"
  type        = number
  default     = 8080
}

variable protocol {
  description = "Service protocol"
  default     = "TCP"
  type        = string
}

variable service_port {
  description = "Port for application"
  default     = 8080
  type        = number
}

##############################################################################