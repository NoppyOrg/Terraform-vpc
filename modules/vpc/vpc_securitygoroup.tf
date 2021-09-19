
####################################################
# Security Groups
####################################################

# SG for VPCE(Interface type)
resource "aws_security_group" "vpc_endpoint_interface" {
  name        = "${var.vpcname}-vpce-sg"
  description = "For VPC Endpoint Interface"
  vpc_id      = aws_vpc.this.id
  ingress {
    description = "Inbound Rule For VPC"
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = [aws_vpc.this.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.vpcname}-sg-vpce"
  }
}

# SG for EC2 instances
resource "aws_security_group" "ec2" {
  name        = "${var.vpcname}-ec2-sg"
  description = "For EC2"
  vpc_id      = aws_vpc.this.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.vpcname}-sg-ec2"
  }
}

resource "aws_security_group_rule" "sg_ec2_ingress_ssh" {
  count = var.sg_ec2_ssh_ingress_source_cidr != "" ? 1 : 0

  security_group_id = aws_security_group.ec2.id
  description       = "Inbound Rule For SSH"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = [var.sg_ec2_ssh_ingress_source_cidr]
}

resource "aws_security_group_rule" "sg_ec2_ingress_ownself" {
  security_group_id = aws_security_group.ec2.id
  description       = "Inbound Rule For Self"
  type              = "ingress"
  protocol          = -1
  from_port         = 0
  to_port           = 0
  self              = true
}



