variable "region_ami_map"{
  type=map
  default={
    us-east-1="ami-0ecb62995f68bb549",
    ap-south-1="ami-02b8269d5e85954ef",
    ap-northeast-1="ami-0aec5ae807cea9ce0",
    ap-northeast-2="ami-0a71e3eb8b23101ed",    
  }
}

variable "region"{
  default="ap-south-1"
}
variable private_key{}
variable "key_name"{
  default="aws_pri_key"
}
variable "instance_type"{
  default="t3.micro"
}
variable "sg_id"{}
