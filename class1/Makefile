.PHONY: clean tf-clean init plan

# Remove Terraform cache only (SAFE)
clean:
	@echo "Cleaning Terraform cache..."
	rm -rf .terraform
	rm -f .terraform.lock.hcl
	@echo "Terraform cache cleaned."

# Alias (some people prefer this name)
tf-clean: clean

# Reinitialize Terraform after cleanup
init:
	terraform init

plan:
	terraform plan
