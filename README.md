# Week13-Homework-PROJECT
Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

Network%20Diagram/Cloud%20Security%20with%20ELK%20Stack.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the _____ file may be used to install only certain pieces of it, such as Filebeat.

install-elk.yml

  https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/3c7f7e5e080e1233ea9c5d550c0b6470b5710a7d/Scripts/Ansible/ELK/install-elk.yml
  
filebeat-playbook.yml
  
  https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/4cc26d9aa41114d953089e35c439a314f3813c05/Scripts/Ansible/Filebeat/filebeat-playbook.yml
  
metricbeat-playbook.yml

https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/802d4d1f86272a00d6d1c8b3afacf94e94bd184b/Scripts/Ansible/Metricbeat/metricbeat-playbook.yml

  

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.  Load balancers protect a website from a Denial of Service attack by distributing traffic across a group of backend web servers.

A jump box controls access to machines in the private network by allowing connections from specific IP addresses.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the log files and system use.

Filebeat watches the log files, collects log events and forwards them to either Elasticsearch or Logstash.

Metricbeat records the metrics and statistics that it collects and ships them to either Elasticsearch or Logstash.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name         | Function | IP Address | Operating System |
|--------------|----------|------------|------------------|
| Jump Box     | Gateway  | 10.0.0.4   | Linux            |
| Web-1        |  DVWA    | 10.0.0.5   | Linux            |
| Web-2        |  DVWA    | 10.0.0.6   | Linux            |
| Redundant-VM |  DVWA    | 10.0.0.7   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
1.41.54.222

Machines within the network can only be accessed by the jump box.
- _TODO: Which machine did you allow to access your ELK VM? What was its IP address?_

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 1.41.54.222          |
| ELK      | Yes                 | 1.41.54.222          |
|          |                     |                      |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it reduces the potential for human errors and simplifies the process of configuring potentially thousands of machines all at once.


The playbook implements the following tasks:
- Installs the docker.io, python3-pip and docker module
- Increases the virtual memory
- Downloads and launches the docker elk container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/4bacf4fff6a1283b810316ae80519e1d798ebc46/Images/docker%20ps%20output.png

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

| Name         | Function  | IP Addresses |
|--------------|-----------|--------------|
| Web-1        | DVWA      | 10.0.0.5     |
| Web-2        | DVWA      | 10.0.0.6     |
| Redundant-VM | DVWA      | 10.0.0.7     |

We have installed the following Beats on these machines:

| Name         | Filebeat installed | Metricbeat installed | 
|--------------|--------------------|----------------------|
| Web-1        |        Yes         |        Yes           |
| Web-2        |        Yes         |        Yes           | 
| Redundant-VM |        Yes         |        Yes           | 



These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
