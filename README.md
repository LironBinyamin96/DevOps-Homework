# DevOps Homework Repository
This repository was created as part of the assignments in a DevOps course. It contains several exercises that demonstrate the use of common tools and technologies in the DevOps world, including Jenkins, Ansible, Vault, and Consul. The goal is to build automated processes for deployment, configuration management, secret management, and dynamic configuration services.

## Nginx-ansible-galaxy
An Ansible role built according to the structure of Ansible Galaxy. This role is responsible for installing the Nginx server, deploying a custom configuration file, and a simple HTML page.

#### Folder structure:
roles/nginx/defaults/main.yml – Default values for the role.

roles/nginx/files/index.html – HTML file used as the homepage.

roles/nginx/handlers/main.yml – Actions triggered by changes (e.g., restart Nginx).

roles/nginx/meta/main.yml – Information about the role.

roles/nginx/tasks/main.yml – Ansible tasks that make up the role.

roles/nginx/templates/nginx.conf.j2 – Nginx configuration template.

roles/nginx/tests/ – Testing folder with test.yml and inventory.

roles/nginx/vars/ – Variables for the role.

nginx.yml – Playbook that runs the role.

inventory.ini – File with server details for running the playbooks.

Jenkinsfile – Jenkinsfile that runs the playbook.

## Nginx-ansible
An additional folder demonstrating the use of Ansible for Nginx deployment, but not following the Galaxy structure. It includes a Jenkinsfile and a simple playbook named playbook-Nginx.yml.

## Artifactory
An Ansible-based setup for installing and configuring JFrog Artifactory OSS.
This role automates deployment using Ansible playbooks, which install the necessary dependencies and configure Artifactory as a systemd service.

## cloud-init
A new folder containing cloud-init scripts for automating tasks when the machine starts, including updating the IP in AWS Route 53.

## jenkins
Contains a Dockerfile and docker-compose.yaml for setting up Jenkins with all relevant plugins for this exercise. In addition to starting Jenkins, the docker-compose.yaml also starts Consul, Vault, and Nginx services, enabling a complete environment for testing.
It also defines Vault policies for Jenkins along with a vault.hcl configuration file, and an nginx.conf for configuring Nginx inside Jenkins, if needed.

## consul
Contains a process that allows Jenkins to update values in Consul (a configuration management service). Additionally, it includes a key-value-param file with sample values.

## vault
Scripts and files for setting up Vault, including a Jenkinsfile that demonstrates working with Vault and retrieving secrets within a Jenkins pipeline.
