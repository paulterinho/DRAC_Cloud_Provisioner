# ===================================
# GENERAL COMMANDS
# ===================================
# Authorize with Compute Canada. You must have your `openrc.sh` file downloaded from the web console to the project root.
.PHONY: auth
auth:
	. openrc.sh

# ===================================
# TERRAFORM COMMANDS
# ===================================

# reset the state so we can get unstuck.
.PHONY: init
init:
	cd terraform; \
	terraform init -var-file="secrets.tfvars"

# TODO: put in pre-commit hook
.PHONY: fmt-check
fmt-check:
	terraform fmt -recursive -check terraform

# TODO: put in pre-commit hook
.PHONY: fmt
fmt:
	terraform fmt -recursive terraform

.PHONY: plan
plan:
	cd terraform; \
	terraform plan -var-file="secrets.tfvars"

# output:
# 	terragrunt run-all output

.PHONY: apply
apply:
	cd terraform; \
	terraform apply -var-file="secrets.tfvars"

.PHONY: destroy
destroy:
	cd terraform; \
	terraform destroy -var-file="secrets.tfvars"

# Shows us all the variables that our current terraform state has to offer.
.PHONY: show
show:
	cd terraform; \
	terraform show

.PHONY: ssh
ssh:
	cd terraform; \
	echo "Here the the format: 'ssh -i ~/.ssh/private_key server_user@ip.address'"
	echo "Find the values in the secrets.tfstate and outputs.tf files"

# need a phony above every target: if it does something remotely, the phoney tells the computer it's remote
# .PHONY: fmt provider-upgrade module-upgrade graph plan output apply

# ==========================
# PACKER
# ==========================

# installs all plugins in the main template
.PHONY: packer-init
packer-init:
	cd packer; \
	packer init  .

# make sure your syntax is correct and you can log in correctly
.PHONY: packer-validate
packer-validate:
	cd packer; \
	packer validate -syntax-only .

# make sure your syntax is correct and you can log in correctly
.PHONY: packer-fmt
packer-fmt:
	cd packer; \
	packer fmt .

# build your image
# NOTE: the `PACKER_LOG=1 packer build -on-error=ask .` will show debug logs.
.PHONY: packer-build
packer-build:
	cd packer; \
	packer build -on-error=ask .

# If you have a tutorial using JSON, use this command to convert it to HCL 2
.PHONY: packer-upgrade-json
packer-upgrade-json:
	cd packer; \
	packer hcl2_upgrade -with-annotations packer.json