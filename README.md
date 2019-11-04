# tfe12-test
TFE 12 var test

# For the real (shell) env vars

- Code
  ```terraform
  data "terraform_remote_state" "ops-okta-app" {
	  backend = "remote"

		config = {
			organization = "galser-paid"
			workspaces = {
				name = "tfe-var-test"
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
	```
- Variable `TFETOKEN` defined in Environment Variables in TF Cloud UI as `777`
- Output :
  ```bash
  Terraform v0.12.6
  Initializing plugins and modules...
  2019/11/04 13:19:00 [DEBUG] Using modified User-Agent: Terraform/0.12.6 TFC/8a10f7761e
  null_resource.timed-hello: Destroying... [id=1108591062124960980]
  null_resource.timed-hello: Destruction complete after 0s
  null_resource.timed-hello: Creating...
  null_resource.timed-hello: Provisioning with 'local-exec'...
  null_resource.timed-hello (local-exec): Executing: ["/bin/sh" "-c" "echo Time is 2019-11-04T13:19:03Z, env var 'TFETOKEN' value is $TFETOKEN"]
  null_resource.timed-hello (local-exec): Time is 2019-11-04T13:19:03Z, env var TFETOKEN value is 777
  null_resource.timed-hello: Creation complete after 0s [id=7860824966591636177]

  Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

  Outputs:

  tfe_token = A11B12C13
  ```

