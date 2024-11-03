resource "aws_instance" "jump_server" {

    ami="ami-04a37924ffe27da53"
    instance_type = "t2.micro"
    subnet_id     = aws_subnet.public_zone1.id
    associate_public_ip_address=true;

   tags = {
    Name = "Jump_server"
   }

}