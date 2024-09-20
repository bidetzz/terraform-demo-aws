locals {
    ubuntu_ami_name_latest = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    canonical_account_id =  "099720109477"

    aws_instances = {
        blue = {
            ssh_reachable = false
        },
        orange = {
            ssh_reachable = true
        }
    }
}