
#creating ec2-instances jenkins and builder
resource "aws_instance" "jenkins" {
	ami = data.aws_ami.AmznLinx.id
  instance_type = var.instance_type 
  associate_public_ip_address = true
  key_name = "instance"
  vpc_security_group_ids = [aws_security_group.main-SG.id] 
  subnet_id = aws_subnet.pb-subnet-1.id
  user_data = file("install_Jenkins.sh") 

  tags = {
    Name = "Jenkins_Master"
  }
}
