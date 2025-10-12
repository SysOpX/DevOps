data "aws_vpc" "target" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0830a572b9d6d6e37"] # Modify as you wish
  }
}

data "aws_subnet" "target" {
  filter {
    name   = "subnet-id"
    values = ["subnet-032f27677657edd98"] # Modify as you wish
  }
}

data "aws_security_group" "web_sg" {
  filter {
    name   = "group-id"
    values = ["sg-04aae13f328114e2e"]  # Modify as you wish
  }
}
resource "aws_instance" "web" {
  ami = "ami-0933f1385008d33c4"  # Ubuntu 24.04 AMI
  instance_type = "t3.large" # Modify as you wish
  subnet_id = data.aws_subnet.target.id
  vpc_security_group_ids = [data.aws_security_group.web_sg.id]
  associate_public_ip_address = true
  monitoring = true
  key_name = "external-servers" # Modify as you wish
  ebs_optimized = true

  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    Environment = "Website"
    ManagedBy = "Terraform"
    Name = "${var.name}-terraform"
  }

  root_block_device {
    encrypted = true
    kms_key_id = "arn:aws:kms:ap-southeast-1:141421058106:key/6d09ff79-ee58-4c93-a058-6f0da3436270"
    volume_size = 100  # Modify as you wish
    volume_type = "gp3"
    
    tags = {
      Name = "${var.name} - Root Disk"
    }
  }
}

