## What is Terraform state?
Every time you run Terraform, it records information about what infrastructure it created in a Terraform state file. This file contains a custom JSON format that records a mapping from the Terraform resources in your configuration files to the representation of those resources in the real world. You should never edit the Terraform state files by hand or write code that reads them directly.

## Configure shared storage for state files.
The goal is to configure AWS S3 as shared storage to store the state file and DynamoDB for locking and isolation.
