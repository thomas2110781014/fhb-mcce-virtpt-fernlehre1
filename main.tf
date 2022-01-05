data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "gitea" {
  ami = data.aws_ami.amazon-2.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    aws_security_group.egress-all-all.id,
    aws_security_group.ingress-all-2222.id,
    aws_security_group.ingress-private-gitea.id,
  ]

  user_data = templatefile("${path.module}/templates/init_gitea.tftpl", { db_host = aws_instance.db.private_ip, db_name = var.db_name, db_user = var.db_user, db_pass = var.db_pass })

  tags = {
    Name = "gitea"
  }
}

resource "aws_instance" "db" {
  ami = data.aws_ami.amazon-2.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    aws_security_group.egress-all-all.id,
    aws_security_group.ingress-private-db.id,
  ]

  user_data = templatefile("${path.module}/templates/init_db.tftpl", { db_name = var.db_name, db_user = var.db_user, db_pass = var.db_pass })

  tags = {
    Name = "db"
  }
}

resource "aws_instance" "proxy" {
  ami = data.aws_ami.amazon-2.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [
    aws_security_group.egress-all-all.id,
    aws_security_group.ingress-all-http.id,
    aws_security_group.ingress-all-https.id,
  ]

  user_data = templatefile("${path.module}/templates/init_proxy.tftpl", { gitea_host = aws_instance.gitea.private_ip })

  tags = {
    Name = "proxy"
  }
}
