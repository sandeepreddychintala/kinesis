data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
data "aws_subnet_ids" "example" {
  vpc_id = "vpc-01f1087a6589fac38"
}

data "aws_subnet" "example" {
  count = "${length(data.aws_subnet_ids.example.ids)}"
  id    = "${data.aws_subnet_ids.example.ids[count.index]}"
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = "${aws_iam_role.test_role.name}"
}
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id = "${element(data.aws_subnet_ids.example.ids,0)}"
  root_block_device {
      volume_type = "gp2"
      volume_size = 8
      delete_on_termination = true
  }
  associate_public_ip_address = false
  key_name ="javakey"
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  tags = {
    Name = "HelloWorld"
  }
}