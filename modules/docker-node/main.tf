resource "aws_instance" "node" {
    provider = "aws"
    ami             = "${lookup(var.ubuntu_amis, var.region)}"
    instance_type   = "${var.instance_type}"
    subnet_id          = "${var.subnet_id}"
    associate_public_ip_address = "true"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${var.vpc_security_group_ids}"]

    timeouts {
        create = "10m"
        delete = "3m"
    }

   provisioner "file" {
      source       = "${path.module}/bootstrap.sh"
      destination  = "/tmp/bootstrap.sh"

        connection {
            type     = "ssh"
            user     = "ubuntu"
            timeout = "2m"
            private_key = "${file("${var.certificate_path}")}"
        }
   }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/bootstrap.sh",
            "/tmp/bootstrap.sh ${var.name}"
        ]

        connection {
            type     = "ssh"
            user     = "ubuntu"
            timeout = "2m"
            private_key = "${file("${var.certificate_path}")}"
        }
    }

    tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}