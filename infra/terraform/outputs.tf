output "instance_id" {
  description = "Linode instance ID"
  value       = linode_instance.todo_app.id
}

output "public_ip" {
  description = "Public IP address"
  value       = tolist(linode_instance.todo_app.ipv4)[0]
}

output "domain" {
  description = "Application domain"
  value       = var.domain
}

output "ssh_command" {
  description = "SSH connection command"
  value       = "ssh -i ${var.ssh_private_key_path} root@${tolist(linode_instance.todo_app.ipv4)[0]
}"
}

output "application_url" {
  description = "Application URL"
  value       = "https://${var.domain}"
}

output "linode_status" {
  description = "Linode instance status"
  value       = linode_instance.todo_app.status
}
