resource "aws_elb" "jenkins_elb" {
  name            = "${var.name}-ELB"
  subnets         = [aws_instance.jenkins.subnet_id]
  instances       = [aws_instance.jenkins.id]
  security_groups = [aws_security_group.jenkins_elb_security_group.id]

  access_logs {
    bucket   = var.log_bucket_name
    interval = 60
    enabled  = true
  }

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = var.jenkins_wildcard_elb_cert_arn
  }

  listener {
    instance_port     = 22
    instance_protocol = "tcp"
    lb_port           = 22
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "TCP:22"
    interval            = 30
  }

  tags = {
    Name = "${var.name} ELB"
  }
}

