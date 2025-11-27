[todo_servers]
${server_ip} ansible_user=root ansible_ssh_private_key_file=${ssh_private_key} ansible_python_interpreter=/usr/bin/python3

[todo_servers:vars]
domain=${domain}
acme_email=${acme_email}
jwt_secret=${jwt_secret}
github_repo=${github_repo}
github_token=${github_token}
