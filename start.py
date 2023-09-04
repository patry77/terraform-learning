import os
import argparse


parser = argparse.ArgumentParser(description='Terraform GCP infrastructure - load balancer')

parser.add_argument('arg1', help="apply - to create infrastructure, destroy - to destroy infrastructure")

args = parser.parse_args()
if args.arg1 == "apply":
    os.environ['TF_VAR_project_id'] = ''
    os.environ['TF_VAR_credentials_file'] = ''
    os.system("terraform init")
    os.system("packer build ./packer/golden-image.json")
    os.system("terraform apply -auto-approve")
if args.arg1 == "destroy":
    os.system("terraform destroy -auto-approve")