variable "linode_token" {
  description = "Linode API token"
  type        = string
  sensitive   = true
}

variable "linode_region" {
  description = "Linode region (us-east, us-southeast, us-central, us-west, ca-central, eu-west, eu-central, ap-south, ap-northeast, ap-west, ap-southeast)"
  type        = string
  default     = "us-southeast"
}

variable "linode_type" {
  description = "Linode instance type (g6-nanode-1, g6-standard-1, g6-standard-2, g6-standard-4, etc.)"
  type        = string
  default     = "g6-standard-2"
}

variable "root_pass" {
  description = "Root password for Linode instance (min 6 chars, must include uppercase, lowercase, and numbers)"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key for server access"
  type        = string
}

variable "domain" {
  description = "Domain name for the application"
  type        = string
}

variable "acme_email" {
  description = "Email for Let's Encrypt SSL certificates"
  type        = string
}

variable "jwt_secret" {
  description = "JWT secret key (minimum 32 characters)"
  type        = string
  sensitive   = true
}

variable "github_repo" {
  description = "GitHub repository URL"
  type        = string
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "allowed_ssh_ips" {
  description = "List of IP addresses allowed to SSH (CIDR format)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
