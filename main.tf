# AMI 

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [local.ubuntu_ami_name_latest]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [local.canonical_account_id]
}

# Security groups

resource "aws_security_group" "blue_sg" {
  name = "blue_sg"
  vpc_id = var.vpc_id
  description = "Security Group to allow outbound SSH to the orange instance from the blue instance"
}

resource "aws_vpc_security_group_egress_rule" "blue-outbound-ssh" {
    security_group_id = aws_security_group.blue_sg.id
    description = "Allow outbound SSH traffic from blue EC2 instance to orange EC2 instance"
    referenced_security_group_id = aws_security_group.orange_sg.id
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
}

resource "aws_security_group" "orange_sg" {
  name = "orange_sg"
  vpc_id = var.vpc_id
  description = "Security Group to allow inbound SSH from the blue instance to the orange instance"
}

resource "aws_vpc_security_group_ingress_rule" "orange-inbound-ssh" {
    security_group_id = aws_security_group.orange_sg.id
    description = "Allow inbound SSH traffic from blue EC2 instance to orange EC2 instance"
    referenced_security_group_id = aws_security_group.blue_sg.id
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
}

# SSH key pair

resource "aws_key_pair" "fun_key" {
  key_name   = "fun_key"
  public_key = file(var.public_key_path)
}

# EC2
resource "aws_instance" "ec2_instance" {
  for_each = local.aws_instances  
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  associate_public_ip_address = false
  subnet_id = var.subnet_id
  vpc_security_group_ids = each.value.ssh_reachable ? [aws_security_group.orange_sg.id] : [aws_security_group.blue_sg.id]
  key_name = aws_key_pair.fun_key.key_name
  tags = {
    Name = each.key
  }
}