resource "tls_private_key" "new_key"{
  algorithm="RSA"
  rsa_bits=4096
}

resource "local_file" "file_op"{
  content=tls_private_key.new_key.private_key_pem
  filename="${path.cwd}/key.pem"
  file_permission="0600"
  directory_permission="0700"
}

resource "aws_key_pair" "aws_key_name"{
  key_name=var.key_name
  public_key=tls_private_key.new_key.public_key_openssh
}
