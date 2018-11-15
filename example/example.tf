provider "aws" {
    region  = "eu-central-1"
    profile = "default"

    skip_get_ec2_platforms  = true
    skip_metadata_api_check = true
    skip_region_validation  = true
}

data "aws_vpc" "default" {
    default = true
}

data "aws_ami" "amazon-linux-2" {
    filter {
        name    = "owner-alias"
        values  = ["amazon"]
    }    

    filter {
        name    = "name"
        values  = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"] 
    }

    most_recent = true
}

resource "aws_instance" "tf-example-vm" {
    ami = "${data.aws_ami.amazon-linux-2.id}"
    instance_type = "t2.micro"
    
    tags {
        Name = "tf-example-vm"
    }
}

resource "aws_security_group" "tf_ssh" {
    name        = "tf_ssh"
    description = "SSH via Terraform"
    vpc_id      = "${data.aws_vpc.default.id}"

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "Terraform-example"
    }
}


resource "aws_launch_configuration" "tf_config" {
    name_prefix     =   "tf-example-launch-config-"
    image_id        =   "${data.aws_ami.amazon-linux-2.id}"
    instance_type   =   "t2.micro" 
}




