# 1. What is Infrastructure as Code?
The idea behind the infrastructure as code (iac) is that you write and execute code to define, deploy, update and destroy your infrastructure. A key insight of DevOps is that you can manage almost everything in code.

There are five broad categories of IaC tools

1. **Ad hoc scripts** - The most straightforward approach to automate anything. You take whatever you were doing manually, break it down into discrete pieces using your favorite scripting language to define each of those steps in code, and execute that script on your servers.

2. **Configuration management tools** - Chef, Puppet, and Ansible are all configuration management tools, which means that they are designed to install and manage software on existing servers.

3. **Server templating tools** - An alternative to configuration management. The idea behind the server templating tools is to create an image of server that captures a fully self-contained "snapshot" of the operating system, the software, the files, and all other relevant details. Docker, packer and vagrant are all server templating tools.

4. **Orchestration tools** - Managing VMs and containers is the task of orchestration tools such as **Kubernetes**, Marathon/Mesos, Amazon Elastic Container Service (ECS), Docker Swarm etc.

5. **Provisioning tools** - Whereas configuration management, server templating, and orchestration tools define the code that runs on each server, provisioning tools such as Terraform, Cloud‐ Formation, OpenStack Heat, and Pulumi are responsible for creating the servers themselves. In fact, you can use provisioning tools to create not only servers but also databases, caches, load balancers, queues, monitoring, subnet configurations, firewall settings, routing rules, Secure Sockets Layer (SSL) certificates, and almost every other aspect of your infrastructure

# 2. What are the benefits of Infrastructure as Code?
- Self-Service
- Speed and safety
- Documentation
- Version control
- Validation
- Reuse

# 3. What is Terraform?
Terraform is an open source tool created by HashiCorp and written in Go programming language to deploy infrastructure from your laptop or a build server or just about any other computer, and you don't need to run any extra infrastructure to make that happen. Terraform code is written in HashiCorp Configuration Language (HCL) in files with '.tf' extension.

# 4. Main trade-offs to consider
- Configuration management versus provisioning
- Mutable infrastructure versus immutable infrastructure
- Procedural language versus declarative language
- General-purpose language (GPL) versus domain-specific language (DSL)
- Master versus masterless
- Agent versus agentless
- Paid versus offering
- Large community versus small community
- Mature versus cutting-edge
- Use of multiple tools together
  - Provisioning plus configuration management
  - Provisioning plus server templating
  - Provisioning plus server templating plus orchestration
