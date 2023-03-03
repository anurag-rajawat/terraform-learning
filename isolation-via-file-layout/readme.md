##  Provide isolation between different environment like stage, test and prod etc.
Terraform workspaces can be a great way to quickly spin up and tear down different versions of your code, but they have a few drawbacks:
- The state files for all of your workspaces are stored in the same backend (e.g., the same S3 bucket). That means you use the same authentication and access controls for all the workspaces, which is one major reason workspaces are an unsuitable mechanism for isolating environments (e.g., isolating staging from production).
- Workspaces are not visible in the code or on the terminal unless you run terraform workspace commands. When browsing the code, a module that has been deployed in one workspace looks exactly the same as a module deployed in 10 workspaces. This makes maintenance more difficult, because you don’t have a good picture of your infrastructure.
- Putting the two previous items together, the result is that workspaces can be fairly error-prone. The lack of visibility makes it easy to forget what workspace you’re in and accidentally deploy changes in the wrong one (e.g., accidentally running terraform destroy in a “production” workspace rather than a “staging” workspace), and because you must use the same authentication mechanism for all workspaces, you have no other layers of defense to protect against such errors.

## The goal is to achieve full isolation between environments

