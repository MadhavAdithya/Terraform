
module "ssh_key_module"{
  source="./modules/ssh_keys"
}
module "network_module"{
  source="./modules/security_groups"
}
module "compute_module"{
  source="./modules/instance"
  sg_id=module.network_module.id
  private_key=module.ssh_key_module.local_file_pri
}










