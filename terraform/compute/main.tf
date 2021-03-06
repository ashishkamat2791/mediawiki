provider "aws" {
  region  = "us-east-1"
  profile = "mediawiki"
}

data "aws_availability_zones" "data_az" {
}

#-------------- Key-Pair --------------#
resource "aws_key_pair" "mw_key_pair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

#-------------- AWS Instances --------------#
resource "aws_instance" "mw_instance_web_a" {
  ami                    = var.ami
  instance_type          = var.web_instance_type
  key_name               = aws_key_pair.mw_key_pair.id
  vpc_security_group_ids = [var.web_security_group]
  subnet_id              = var.web_subnet_a
# provisioner "remote-exec" {
#     inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

#     connection {
#       host        = coalesce(self.public_ip, self.private_ip)
#       type        = "ssh"
#       user        = "ubuntu"
#       private_key = file(var.private_key_path)
#     }
#   }

  tags = {
    Name    = "mw_instance_web_a"
    Project = "mediawiki"
  }
}

resource "aws_instance" "mw_instance_web_b" {
  ami                    = var.ami
  instance_type          = var.web_instance_type
  key_name               = aws_key_pair.mw_key_pair.id
  vpc_security_group_ids = [var.web_security_group]
  subnet_id              = var.web_subnet_b
  # provisioner "remote-exec" {
  #   inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

  #   connection {
  #     host        = coalesce(self.public_ip, self.private_ip)
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = file(var.private_key_path)
  #   }
  # }

  tags = {
    Name    = "mw_instance_web_b"
    Project = "mediawiki"
  }
}

# data "template_file" "user_data" {
#   template = "${file("${path.module}/files/user-data.sh")}"
# }

# resource "aws_instance" "mw_instance_db" {
#   ami                    = var.ami
#   instance_type          = var.web_instance_type
#   key_name               = aws_key_pair.mw_key_pair.id
#   vpc_security_group_ids = [var.db_security_group]
#   subnet_id              = var.db_subnet
#   user_data              = data.template_file.user_data.rendered
		           

#   tags = {
#     Name    = "mw_instance_db"
#     Project = "mediawiki"
#   }
# }

#-------------- ELB --------------#
resource "aws_elb" "mw_elb" {

  name            = "media-wiki-elb"
  subnets         = [var.web_subnet_a, var.web_subnet_b]
  instances       = [aws_instance.mw_instance_web_a.id, aws_instance.mw_instance_web_b.id]
  security_groups = [var.web_security_group]
   provisioner "local-exec" {
    command = <<EOD
cat <<EOF > ../aws_hosts 
[dev-mediawiki-web]
dev-mediawiki-web-1 ansible_host=${aws_instance.mw_instance_web_a.public_ip}
dev-mediawiki-web-2 ansible_host=${aws_instance.mw_instance_web_b.public_ip}

[dev-mediawiki-web:vars]
lb_url=${aws_elb.mw_elb.dns_name}
mediawiki_password=${var.db_password}
[apache-servers:children]
dev-mediawiki-web

EOF
EOD
   }
   # front-end
    provisioner "local-exec" {
    command = <<EOF
              ANSIBLE_HOST_KEY_CHECKING=False \
              ansible-playbook \
              -i ../aws_hosts \
              -u ubuntu \
              --private-key ${var.private_key_path}  \
              ../ansible_templates/mediawiki.yaml
             EOF
  }
 # back-end
  #     provisioner "local-exec" {
  #   command = <<EOF
  #             ANSIBLE_HOST_KEY_CHECKING=False \
  #             ansible-playbook \
  #             -i ../aws_hosts \
  #             --ssh-common-args ' \
  #             -o ProxyCommand="ssh -A -W %h:%p -q ubuntu@${aws_instance.mw_instance_web_a.public_ip} \
  #                  -i ${var.private_key_path}"' \
  #             -u ubuntu \
  #             --private-key ${var.private_key_path}  \
  #             ../ansible_templates/mysql.yaml
  #            EOF
  # }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "3"
    timeout             = "3"
    target              = "TCP:80"
    interval            = "30"
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 300
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name    = "mw_elb"
    Project = "mediawiki"
  }
}

resource "aws_lb_cookie_stickiness_policy" "mw_lb_policy" {
  name                     = "mw-lb-policy"
  load_balancer            = aws_elb.mw_elb.id
  lb_port                  = 80
  cookie_expiration_period = 600
}

