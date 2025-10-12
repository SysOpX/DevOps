#### Tools Used:
Jenkins, Terraform, Ansible, Git

#### SSH private key

```bash
sudo chgrp ansiblekeys /etc/ansible/keys/external-servers.pem
sudo chmod 640 /etc/ansible/keys/cpfi-website.pem
sudo systemctl restart jenkins
```








