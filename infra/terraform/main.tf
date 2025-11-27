resource "linode_instance" "todo_app" {
  label           = "todo-app-server"
  image           = "linode/ubuntu22.04"
  region          = var.linode_region
  type            = var.linode_type
  root_pass       = var.root_pass
  authorized_keys = [var.ssh_public_key]
  tags            = ["production", "todo-app", "terraform"]

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      authorized_keys,
      root_pass
    ]
    prevent_destroy = false
  }
}

resource "linode_firewall" "todo_app" {
  label = "todo-app-firewall"

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = var.allowed_ssh_ips
  }

  inbound {
    label    = "allow-http"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = ["0.0.0.0/0"]
  }

  inbound {
    label    = "allow-https"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = ["0.0.0.0/0"]
  }

  inbound_policy = "DROP"

  outbound {
    label    = "allow-all-outbound"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "1-65535"
    ipv4     = ["0.0.0.0/0"]
  }

  outbound {
    label    = "allow-all-outbound-udp"
    action   = "ACCEPT"
    protocol = "UDP"
    ports    = "1-65535"
    ipv4     = ["0.0.0.0/0"]
  }

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.todo_app.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "null_resource" "ansible_provision" {
  depends_on = [linode_instance.todo_app, linode_firewall.todo_app]

  triggers = {
    instance_id = linode_instance.todo_app.id
    always_run  = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      sleep 45
      cd ../ansible && ansible-playbook -i inventory/hosts.ini playbook.yml
    EOT
  }

  lifecycle {
    create_before_destroy = true
  }
}
