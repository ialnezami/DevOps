# initialize terraform
terraform init
# plan
terraform plan
# apply
terraform apply
# destroy
terraform destroy
# destroy -auto-approve
terraform destroy -auto-approve
# destroy -auto-approve -parallelism=10
terraform destroy -auto-approve -parallelism=10
# destroy -auto-approve -parallelism=10 -refresh=true
terraform destroy -auto-approve -parallelism=10 -refresh=true
# destroy -auto-approve -parallelism=10 -refresh=true -target=module.mymodule
terraform destroy -auto-approve -parallelism=10 -refresh=true -target=module.mymodule
