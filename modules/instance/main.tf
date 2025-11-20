resource "aws_instance" "demo-modules-1"{
  ami=lookup(var.region_ami_map,var.region)
  instance_type=var.instance_type
  vpc_security_group_ids=[var.sg_id]
  key_name=var.key_name
  iam_instance_profile="DockerEc2RoleForLoggingAgent"
  connection {
    host=self.public_ip
    type="ssh"
    user="ubuntu"
    private_key=var.private_key
  }
  provisioner "remote-exec"{
    inline=[
      "cd","sudo wget https://s3.ap-south-1.amazonaws.com/amazoncloudwatch-agent-ap-south-1/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb","sudo dpkg -i -E /home/ubuntu/amazon-cloudwatch-agent.deb"
    ]
  }
  provisioner "remote-exec"{
    inline=[
      "sudo groupadd cwagent",
      "sudo usermod -aG cwagent ubuntu",
      "sudo chown root:cwagent -R /opt",
      "sudo chmod 770 -R /opt"
    ]
  }
  provisioner "file"{
    source="/home/ubuntu/config.json"
    destination="/opt/aws/amazon-cloudwatch-agent/bin/config.json"
  }
  provisioner "remote-exec"{
    inline=[
      "export PATH=\"$PATH:/opt/aws/amazon-cloudwatch-agent/bin/\"",
      "cd /opt/aws/amazon-cloudwatch-agent/bin/","sudo amazon-cloudwatch-agent-ctl -a fetch-config -m auto -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s",
      "sudo snap install aws-cli --classic"
    ]
  }
  provisioner "file"{
    source="/home/ubuntu/docker_sh.sh"
    destination="/home/ubuntu/docker_sh.sh"
  }
  provisioner "file"{
    source="/home/ubuntu/docker_cron.txt"
    destination="/home/ubuntu/docker_cron.txt"
  }
  provisioner "remote-exec"{
    inline=[
      "sudo apt update",
      "sudo apt install -y docker.io",
      "sudo docker run -itd --name nginx-container nginx",
      "sudo crontab /home/ubuntu/docker_cron.txt"
    ]
  }
}
