resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    server_ip = tolist(linode_instance.todo_app.ipv4)[0]
    ssh_user           = "root"
    ssh_private_key    = var.ssh_private_key_path
    domain             = var.domain
    acme_email         = var.acme_email
    jwt_secret         = var.jwt_secret
    github_repo        = var.github_repo
    github_token       = var.github_token
  })

  filename        = "${path.module}/../ansible/inventory/hosts.ini"
  file_permission = "0644"

  depends_on = [linode_instance.todo_app]
}

resource "local_file" "ansible_vars" {
  content = templatefile("${path.module}/vars.tpl", {
    domain       = var.domain
    acme_email   = var.acme_email
    jwt_secret   = var.jwt_secret
    github_repo  = var.github_repo
    github_token = var.github_token
  })

  filename        = "${path.module}/../ansible/group_vars/all.yml"
  file_permission = "0644"
}
