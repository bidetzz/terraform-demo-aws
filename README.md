# Terraform demo in AWS

Welcome to my terraform demo project! This is a sample project to test my terraform knowledge with AWS!

## Features

* Creates two EC2 instances on Ubuntu 24.04
* First instance called "blue" is able to SSH to the second instance called "orange"
* Both instances are not reachable from the internet with no public IPs
* This project can be used to provision on any AWS account, region and VPC


## Requirements
Before getting started on this project, you will need to have:

* An AWS account ([AWS Documentation](https://aws.amazon.com/resources/create-account/))
* terraform installed ([Terraform Documentation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
* aws cli ([AWS CLI Documentation](https://aws.amazon.com/cli/))


## Getting started

1. Setup your connection to AWS with AWS profiles. To be able to deploy to different accounts, you can create multiple AWS profiles in the .aws/config file. Here's an example of a multi account profile config file:

```
[profile first-aws-account]
aws_access_key_id=<AWS_access_key>
aws_secret_access_key=<AWS_secret_key>
region = us-east-1
output = json

[profile second-aws-account]
aws_access_key_id=<AWS_access_key>
aws_secret_access_key=<AWS_secret_key>
region = ca-central-1
output = json
```

Change the access_key and secret_key with your own values from your IAM user.

Then you can run this command to define the environment variable that will be used to connect to the specific AWS account desired:

```shell
export AWS_PROFILE=first-profile
```
2. Clone this project!

```shell
git clone <this_repo_url>
```
3. Define the mandatory variables in a terraform.tfvars at the root of this project:

```
public_key_path = "<your_public_ssh_key_path>"
vpc_id = "<your_existing_VPC_ID>"
subnet_id = "<your_existing_subnet_ID>"
aws_region = "<aws_region>"
```

4. Use terraform to provision this project in AWS!

```shell
terraform init
terraform plan
terraform apply
```

You will then deploy my project into your AWS environment!
