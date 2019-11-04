data "terraform_remote_state" "ops-okta-app" {
  backend = "remote"

  config = {
    organization = "galser-paid"
    workspaces = {
      name = "tfe12-test"
    }
  }
}

resource "null_resource" "timed-hello" {
  triggers = { timey = "${timestamp()}" }
  provisioner "local-exec" {
    command = "echo Time is ${timestamp()}"
  }
}

variable "tfe_token" { }

output "tfe_token" {
  # value of this variable comes from the section
  # "Terraform Variables" of TF Cloud UI
  value = var.tfe_token
}

