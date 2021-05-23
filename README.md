# Week13-Homework-PROJECT
Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below:

![image](https://user-images.githubusercontent.com/84385348/119246995-82ab0a00-bbc9-11eb-9671-2f7da15e1d6f.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Ansible Playbook file may be used to install only certain pieces of it, such as Filebeat.

![install-elk.yml](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/6713bfd29db35878645abc59aec25516d9ae8cad/Scripts/Ansible/ELK/install-elk.yml)
  
![filebeat-playbook.yml](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/4cc26d9aa41114d953089e35c439a314f3813c05/Scripts/Ansible/Filebeat/filebeat-playbook.yml)
  
![metricbeat-playbook.yml](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/802d4d1f86272a00d6d1c8b3afacf94e94bd184b/Scripts/Ansible/Metricbeat/metricbeat-playbook.yml)

This document contains the following details:
- Description of the Topology
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

Filebeat watches the log files, collects log events and forwards to Elasticsearch.

Metricbeat records the metrics and statistics that it collects and ships them to Elasticsearch.


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

Machines within the network can only be accessed by the Jump Box

My home computer with IP address 1.41.54.222 can access the ELK VM via http on port 5601. 

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 1.41.54.222          |
| ELK      | Yes                 | 1.41.54.222          |
|          |                     |                      |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it reduces the potential for human errors and simplifies the process of configuring potentially thousands of machines all at once.

The install-elk.yml playbook implements the following tasks:
- Installs the docker.io, python3-pip and docker module
- Increases the virtual memory
- Downloads and launches the docker elk container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![image](https://user-images.githubusercontent.com/84385348/119248539-264de780-bbd5-11eb-8abb-ad20c994f77e.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

| Name         | Function  | IP Addresses |
|--------------|-----------|--------------|
| Web-1        | DVWA      | 10.0.0.5     |
| Web-2        | DVWA      | 10.0.0.6     |
| Redundant-VM | DVWA      | 10.0.0.7     |

The following Beats have been installed on these machines:

| Name         |Beats installed         | 
|--------------|------------------------|
| Web-1        | Filebeat, Metricbeat   |  
| Web-2        | Filebeat, Metricbeat   | 
| Redundant-VM | Filebeat, Metricbeat   | 

These Beats allow us to collect the following information from each machine:

1.  Filebeat collects logs such as log events and logon events.  For example, if a user tried to SSH to one of the VMs using the wrong public key, this will be logged in the auth.log file and subsequently reported in Kibana.

3.  Metric collects statistics such as CPU and RAM usage.   In the event of a CPU or memory spike, it will show in the Metric dashboard in the Kibana.

### Install and run containers using Docker.
To configure your Jump box to run Docker containers and to install a container:

1. SSH into your Jump box.
2. Run sudo apt update then sudo apt install docker.io
3. Run sudo systemctl status docker
4. Run sudo docker pull cyberxsecurity/ansible.
5. By running command:  sudo docker ps  -a, it will list all available containers as shown below:

![image](https://user-images.githubusercontent.com/84385348/119247525-935d7f00-bbcd-11eb-9b16-da8cf99d7119.png)

6. Select any container from the available list.   Start using the container by typing the command:  sudo docker start [container_name]
7. Get a shell in your container using docker attach [container_name]

### Set up Ansible connections to VMs
To set up Ansible connections to VMs in the Virtual Network:
1. Run ssh-keygen to create an SSH key as shown below.

![image](https://user-images.githubusercontent.com/84385348/119247532-a53f2200-bbcd-11eb-8264-f66e91f8da4a.png)

2. Run cat .ssh/id_rsa.pub to display your public key.

![image](https://user-images.githubusercontent.com/84385348/119247547-be47d300-bbcd-11eb-99d5-e0219bb7b96d.png)

3.  Copy the public key.  Go to one of the VM's details page and select Reset password.   Paste the public key in the SSH public key field, as shown below:

![image](https://user-images.githubusercontent.com/84385348/119247555-d3246680-bbcd-11eb-9e9a-e63a47fdca83.png)

4. Update the /etc/ansible/hosts file.
  - Run nano /etc/ansible/hosts
  - Search for [webservers]
  - Uncomment the [webserservers] header line.
  - Add the internal IP address of each webserver under the [webservers] and add the python line beside each IP.  
~~~
          [webservers]
          10.0.0.5 ansible_python_interpreter=/usr/bin/python3
          10.0.0.6 ansible_python_interpreter=/usr/bin/python3
          10.0.0.7 ansible_python_interpreter=/usr/bin/python3
~~~
    
5. In the same file, search for [elk].   If it doesn't exist yet, add the [elk] header line.  Add the internal IP address of the ELK server and add the python line beside the IP address.  
~~~
          [elk]
          10.1.0.4 ansible_python_interpreter=/usr/bin/python3
~~~

see updated /etc/ansible/hosts file:  ![hosts.txt](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/7ab1ff34f047c605a6d421448e2f109689ae4e62/Scripts/Ansible/Ansible%20config/hosts.txt)     

6. Next, update Ansible configuration file to use your administrator account for SSH connections.
  - Open the file with nano /etc/ansible/ansible.cfg 
  - Search for remote_user option.
  - Uncomment the remote_user line and replace root with your VM admin username 
~~~
          remote_user=azdmin
~~~
    
see updated /etc/ansible/ansible.cfg fie: ![ansible.cfg](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/7fce973fc1b1d53a8a43ff0a7df1f5ce647e4ab8/Scripts/Ansible/Ansible%20config/ansible.cfg)
  
### Using the Playbook    

Installing and configuring ELK using Ansible Playbook:
1. Create a file in /etc/ansible/ folder called install-playbook.yml by running command:  nano install-elk.yml
2.  To specify which machine to install the ELK server on, specify the hosts as elk in the header of the Ansible playbook as shown below:
~~~
--
- name: Config elk VM with Docker     
  hosts: elk                          
  remote_user: azadmin                
  become: true                    
  tasks:             
~~~
3. Install docker.io by adding the section the install-elk.yml:
~~~
- name: Install docker.io
      apt:
        update_cache: yes
        force_apt_get: yes
        name: docker.io
        state: present
      # Use apt module
 ~~~
4. Install python3-pip by adding below section to the install-elk.yml:
~~~
- name: Install python3-pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present
      # Use pip module (It will default to pip3)
~~~
5. Then, add below section to install the docker module:
~~~
- name: Install Docker module
      pip:
        name: docker
        state: present
~~~
6. Next, increase the virtual memory by adding the below section to the install-elk.yml:
~~~
- name: Increase virtual memory
      command: sysctl -w vm.max_map_count=262144
      # Use sysctl module
    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: 524288
        state: present
        reload: yes
~~~       
7.  Then download and launch the docker elk container and publish the ports that ELK runs on, by adding the following:
~~~
# Use docker_container module
    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        # Please list the ports that ELK runs on
        published_ports:
          - 5601:5601
          - 9200:9200
          - 5044:5044
        
        
To specify which machine to install the Filebeat on:
1)  In the filebeat-playbook.yml, specify the hosts as webservers in the header of Ansible playbook as shown below:
~~~
--
- name: installing and launching filebeat
  hosts: webservers
  become: yes
  tasks:
~~~
  
To specify which machine to install the Metricbeat on:
1)  In the metricbeat-playbook.yml, specify the hosts as webservers in the header of Ansible playbook as shown below:
~~~
--
- name: Install metric beat
  hosts: webservers
  become: true
  tasks:
~~~
 

The URL to navigate ELK is http://52.184.196.183:5601/app/kibana

