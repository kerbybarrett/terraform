# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED MODULE PARAMETERS
# These variables must be passed in by the operator.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
    description = "The name of the node instance."
}

variable "region" {
    description = "The region where to deploy this code (e.g. us-east-1)."
}

variable "instance_type" {
    description = "Instance type to create for this node."
    default = "t2.micro"
}

variable "ubuntu_amis" {
    description = "Map of AMIs used to create docker nodes in regions."
    type = "map"
    default = {
        "us-west-2" = "ami-6e1a0117"
    }
}

variable "tags" {
    description = "A map of tags to add to all resources"
    default     = {}
}

variable "subnet_id" {
    description = "Id of a subnet that the node should belong to."
}

variable "key_name" {
    description = "Access key name for remote access to the instance."
}

variable "vpc_security_group_ids" {
    type = "list"
    description = "List of security groups IDs to assign to the instance."
    default = []
}

variable certificate_path {
    description = "Path to the private key certificate for remote SSH connections."
}