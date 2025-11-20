resource "aws_security_group" "sg_1"{
  name="sg_1"
}

resource "aws_vpc_security_group_ingress_rule" "ingress-1"{
  security_group_id=aws_security_group.sg_1.id
  ip_protocol="tcp"
  cidr_ipv4="0.0.0.0/0"
  from_port=22
  to_port=22
}

resource "aws_vpc_security_group_egress_rule" "egress-1"{
  security_group_id=aws_security_group.sg_1.id
  ip_protocol="-1"
  cidr_ipv4="0.0.0.0/0"
  from_port=0
  to_port=0
}
