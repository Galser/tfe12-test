variable "dl-token" {}

data "terraform_remote_state" "ops-okta-app" {
  backend = "remote"

  config = {
    organization = "digital-lightning"
    hostname     = "ptfe-pm-2.guselietov.com"
		token				 = "${var.dl-token}"
    workspaces = {
      name = "dl-ops-security"
    }
  }
}

resource "null_resource" "timed-hello" {
  triggers = { timey = "${timestamp()}" }
  provisioner "local-exec" {
    command = "echo Time is ${timestamp()}, env var 'TFETOKEN' value is $TFETOKEN"
  }
}

variable "tfe_token" {}

output "tfe_token" {
  # value of this variable comes from the section
  # "Terraform Variables" of TF Cloud UI
  value = var.tfe_token
}


# Configure the Terraform Enterprise Provider
#provider "tfe" {
#  hostname = "${var.hostname}"
#  token    = "${var.tfe_token}"
#}

