 variable "ec2_instance_type" {
    type = string
 }

variable "ec2_ami" {
    type = string
}

variable "ec2_tags" {
    type = map(string)
}