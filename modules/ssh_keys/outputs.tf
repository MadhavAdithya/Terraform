output "private_key"{
 value=tls_private_key.new_key.private_key_pem
}

output "local_file_pri"{
  value=local_file.file_op.content
}
