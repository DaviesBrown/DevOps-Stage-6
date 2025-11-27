output "instance_id" {
  description = "Linode instance ID"
  value       = linode_instance.todo_app.id
}

output "public_ip" {
  description = "Public IP address"
  value       = linode_instance.todo_app.ip_address
}

output "domain" {
  description = "Application domain"
  value       = var.domain
}

output "ssh_command" {
  description = "SSH connection command"
  value       = "ssh -i ${var.ssh_private_key_path} root@${linode_instance.todo_app.ip_address}"
}

output "application_url" {
  description = "Application URL"
  value       = "https://${var.domain}"
}

output "linode_status" {
  description = "Linode instance status"
  value       = linode_instance.todo_app.status
}