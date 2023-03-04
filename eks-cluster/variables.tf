variable "name" {
  type        = string
  description = "The name to use for the EKS cluster"
}

variable "min_size" {
  type        = number
  description = "The minimum number of nodes to have in the EKS cluster"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "The maximum number of nodes to have in the EKS cluster"
  default     = 2
}

variable "desired_size" {
  type        = number
  description = "The desired number of nodes to have in the EKS cluster"
  default     = 1
}

variable "instance_type" {
  type        = list(string)
  description = "The type of EC2 instances to run in the node group"
  default     = ["t3.small"]
}
