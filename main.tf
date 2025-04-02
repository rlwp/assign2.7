# Better to use Data block to filter from existing cloud resources
# Avoid hardcoding
# But if you want, you can replace subnet_id and ami based on us-east-1
# if you create vpc with terraform, that's good. you can point to subnet

# Define your EC2 instance
resource "aws_instance" "rudy-ec2Instance" {
  ami           = "ami-071226ecf16aa7d96"  # Replace with your AMI ID
  instance_type = "t2.micro"
  # subnet_id     = "subnet-12345678"       # Replace with your subnet ID
  tags = {
    Name = "rudy-ec2Instance"
  }
}

# Create the EBS volume
resource "aws_ebs_volume" "rudy-ec2vol" {
  availability_zone = "us-east-1"         # Replace with your EC2 instance's AZ
  size              = 20
  tags = {
    Name = "rudy-ec2vol"
  }
}

# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "rudy-ec2" {
  instance_id = aws_instance.rudy-ec2Instance.id
  volume_id   = aws_ebs_volume.rudy-ec2vol.id
  device_name = "/dev/xvdf"               # Replace with desired device name
}