# What is Terraform workspace?
Terraform workspaces allow you to store your Terraform state in multiple, separate, named workspaces. Terraform starts with a single workspace called “default,” and if you never explicitly specify a workspace, the default workspace is the one you’ll use the entire time. To create a new workspace or switch between workspaces, you use the terraform workspace commands

This is handy when you already have a Terraform module deployed and you want to do some experiments with it (e.g., try to refactor the code) but you don’t want your experiments to affect the state of the already-deployed infrastructure. Terraform workspaces allow you to run terraform workspace new and deploy a new copy of the exact same infrastructure, but storing the state in a separate file.
