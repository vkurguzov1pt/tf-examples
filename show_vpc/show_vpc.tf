provider "aws" {
    region = "eu-central-1"
    profile = "default"
}

data "aws_vpc" "default" {
    default =   true
}

output "show" {
    value = ["${data.aws_vpc.default.*}"]
}
