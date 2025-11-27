# Security is handled by linode_firewall in main.tf
# This file can be used for additional security configurations

resource "linode_stackscript" "docker_setup" {
  label       = "docker-setup"
  description = "Initial Docker setup script"
  script      = <<-EOF
#!/bin/bash
set -e

# Update system
apt-get update
apt-get upgrade -y

# Install basic packages
apt-get install -y python3 python3-pip curl git

# Set up unattended upgrades for security
apt-get install -y unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades
EOF

  images = ["linode/ubuntu22.04"]
}
