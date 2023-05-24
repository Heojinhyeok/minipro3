resource "aws_instance" "my_instance" {
  ami                         = "ami-035da6a0773842f64"
  instance_type               = "t2.micro"
  user_data                   = data.template_file.user_data.rendered
  user_data_replace_on_change = true
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  subnet_id                   = aws_subnet.web_server_subnet.id
}

resource "aws_security_group" "jenkins_sg" {
  description = "Open ports 22, 8080, and 443"
  vpc_id      = aws_vpc.hjh-vpc.id

  ingress {
    description = "Allow SSH from my Public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allows Access to the Jenkins Server"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allows Access to the Jenkins Server"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Jenkins Security Group"
  }
}

data "template_file" "user_data" {
  template = file("jenkins-server.sh")
}
