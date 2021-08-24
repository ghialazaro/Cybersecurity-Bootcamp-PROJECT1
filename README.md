# Automated ELK Stack Deployment

The files in this repository and the instructions in this document were used to configure the network depicted below:
![image](https://github.com/ghialazaro/Cybersecurity-Bootcamp-PROJECT1/blob/e0fab3503767c3dfee4b65f3c4e3ad500476029f/Images/Cloud%20Security%20with%20ELK%20Stack.png)


These files and instructions have been tested and used to generate a live ELK deployment on Azure. They can be used to recreate the entire deployment pictured above.

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
- Target machines and Beats in use
- Install and run containers using Docker
- Set up Ansible connections to VMs
- Using the Playbook to install:
  -  ELK
  -  Filebeat
  -  Metricbeat
- Navigating to ELK


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.  Load balancers protect a website from a Denial of Service attack by distributing traffic across a group of backend web servers.

A Jump Box controls access to machines in the private network by allowing connections from specific IP addresses.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the log files and system use.

Filebeat watches the log files, collects log events and forwards to Elasticsearch.

Metricbeat records the metrics and statistics that it collects and ships them to Elasticsearch.

The configuration details of each machine may be found below:

| Name         | Function | IP Address | Operating System |
|--------------|----------|------------|------------------|
| Jump Box     | Gateway  | 10.0.0.4   | Linux            |
| Web-1        |  DVWA    | 10.0.0.5   | Linux            |
| Web-2        |  DVWA    | 10.0.0.6   | Linux            |
| Redundant-VM |  DVWA    | 10.0.0.7   | Linux            |
| ELK-VM       |  ELK     | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from my home IP address.

Machines within the network can only be accessed by the Jump Box

My home IP address can access the ELK VM via http on port 5601. 

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |  Protocol |  Port  |
|----------|---------------------|----------------------|-----------|--------|
| Jump Box | Yes                 | home IP address      |   SSH     |    22  |
| ELK      | Yes                 | home IP address      |   HTTP    |  5601  | 


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it reduces the potential for human errors and simplifies the process of configuring potentially thousands of machines all at once.

The install-elk.yml playbook implements the following tasks:
- Installs the docker.io, python3-pip and docker module
- Increases the virtual memory
- Downloads and launches the docker elk container

More on this in the Installing and configuring ELK using Ansible Playbook section below.

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

| Name         | Function  | IP Addresses |  Protocol  |  Port  |
|--------------|-----------|--------------|------------|--------|
| Web-1        | DVWA      | 10.0.0.5     |   HTTP     |  9200  |
| Web-2        | DVWA      | 10.0.0.6     |   HTTP     |  9200  |
| Redundant-VM | DVWA      | 10.0.0.7     |   HTTP     |  9200  |

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
---------------------------------------------------------------------------------------------------------------
          [webservers]
          10.0.0.5 ansible_python_interpreter=/usr/bin/python3
          10.0.0.6 ansible_python_interpreter=/usr/bin/python3
          10.0.0.7 ansible_python_interpreter=/usr/bin/python3
---------------------------------------------------------------------------------------------------------------
    
5. In the same file, search for [elk].   If it doesn't exist yet, add the [elk] header line.  Add the internal IP address of the ELK server and add the python line beside the IP address.  
----------------------------------------------------------------------------------------------------------------
          [elk]
          10.1.0.4 ansible_python_interpreter=/usr/bin/python3
----------------------------------------------------------------------------------------------------------------

   see updated /etc/ansible/hosts file:  ![hosts.txt](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/7ab1ff34f047c605a6d421448e2f109689ae4e62/Scripts/Ansible/Ansible%20config/hosts.txt)     

6. Next, update Ansible configuration file to use your administrator account for SSH connections.
   - Open the file with nano /etc/ansible/ansible.cfg 
   - Search for remote_user option.
   - Uncomment the remote_user line and replace root with your VM admin username 
----------------------------------------------------------------------------------------------------------------
          remote_user=azdmin
----------------------------------------------------------------------------------------------------------------    
   see updated /etc/ansible/ansible.cfg fie: ![ansible.cfg](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/7fce973fc1b1d53a8a43ff0a7df1f5ce647e4ab8/Scripts/Ansible/Ansible%20config/ansible.cfg)

7.  To test the Ansible connections to VMs, run the command:  ansible all -m ping.  A successful output is shown below:

![image](https://user-images.githubusercontent.com/84385348/119249560-c78c6c00-bbdc-11eb-9d8e-439648c5eb8e.png)

  
### Using the Playbook    

#### Installing and configuring ELK using Ansible Playbook:

1. Create a file called install-elk.yml in /etc/ansible folder inside the Ansible container by running command:  nano install-elk.yml

2. To specify which machine to install the ELK server on, specify the hosts as elk in the header of the install-elk.yml as shown below:
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
~~~
8.  Lastly, enable docker on boot by adding the following:
~~~
  - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes
~~~
9.  Save the file. The install-elk.yml should look like this:  ![install-elk.yml](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/e2e2ebe7071af22eeab2f2cc26707d795bc24c19/Scripts/Ansible/ELK/install-elk.yml)
    
10. Still inside the Ansible container, run the command: ansible-playbook install-elk.yml. Make sure you are in the /etc/ansible folder.  The output should be as shown below:

![image](https://user-images.githubusercontent.com/84385348/119249719-20a8cf80-bbde-11eb-8edc-b423b3d94c5b.png)

11.  After running the ansible-playbook to install ELK, SSH to the ELK VM from the Ansible container.   

13.  The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![image](https://user-images.githubusercontent.com/84385348/119248539-264de780-bbd5-11eb-8abb-ad20c994f77e.png)


#### Installing and configuring Filebeat on Web VMs using Ansible Playbook:      

1.  Inside the Ansible container, copy the Filebeat config file ![filebeat-config.yml](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/6b42247084b29c7c3c2c0459493d9000fcb2c1c8/Scripts/Ansible/Filebeat/filebeat-config.yml) to /etc/ansible folder.

2.  Update the filebeat-config.yml file:
    - Search for output.elasticsearch:
    - Replace the IP address with the IP address of the ELK VM, as shown below:
-------------------------------------------------------------------------------------------------
    output.elasticsearch:
    hosts: ["10.1.0.4:9200"]
    username: "elastic"
    password:  "changeme"
-------------------------------------------------------------------------------------------------
3. In the same file:
   - Search for setup.kibana:
   - Replace the IP address with the IP address of the ELK VM, as shown below:
-------------------------------------------------------------------------------------------------
    setup.kibana:
    hosts: "10.1.0.4:5601"
-------------------------------------------------------------------------------------------------
4. Create a file in /etc/ansible folder called filebeat-playbook.yml by running command: nano filebeat-playbook.yml

5. To specify which machine to install the Filebeat on, specify the hosts as webservers in the header of Ansible playbook as shown below:
~~~
  --
  - name: installing and launching filebeat
    hosts: webservers
    become: yes
    tasks:
~~~
6. Next, add the command to download .deb file from artifacts.elastic.co.
~~~
  - name: download filebeat deb
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.2-amd64.deb
~~~
7. Then, add the command to install filebeat:
~~~
  - name: install filebeat deb
    command: sudo dpkg -i filebeat-7.6.2-amd64.deb
~~~
8. Add a section to copy the filebeat-config.yml from the Ansible container to the Web VMs:
~~~  
  - name: drop in filebeat.yml
    copy:
      src: /etc/ansible/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml
~~~
9. Next, add the command to enable and configure filebeat:
~~~
  - name: enable and configure system module
    command: filebeat modules enable system
~~~
10. Then, add the command to setup filebeat:
~~~
  - name: setup filebeat
    command: filebeat setup
~~~
11. Next, add the command to start filebeat service:
~~~
  - name: start filebeat service
    command: service filebeat start
~~~
12. Lastly, add the command to enable filebeat service on boot:
~~~
  - name: enable service filebeat on boot
    systemd:
      name: filebeat
      enabled: yes
~~~
13. Save the file.   The filebeat-playbook.yml should look like this:  ![filebeat-playbook.yml](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/7a02b597a53a19ce6c2149713b7857669881780e/Scripts/Ansible/Filebeat/filebeat-playbook.yml)

14. Inside the Ansible container, run the command: ansible-playbook filebeat-playbook.yml.   Make sure you are in the /etc/ansible folder.   The output should be as shown below:

![image](https://user-images.githubusercontent.com/84385348/119261490-03462680-bc1b-11eb-92e9-34898d0b0f78.png)

15. To verify successful installation of Filebeat:
    - Navigate to ELK url:   http://52.184.196.183:5601/app/kibana
    - Click on Add log data under Logs
    - Click on System Logs.  
    - Scroll to Step 5: Module Data and click on Check Data, as shown below:
    ![image](https://user-images.githubusercontent.com/84385348/119261530-2a045d00-bc1b-11eb-86f6-28c701f03db0.png)

#### Installing and configuring Metricbeat on Web VMs using Ansible Playbook:

1.  Inside the Ansible container, copy the Metricbeat config file ![metricbeat-config.yml](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/dfb9ce83205ec87d59662e960607f3a99f620835/Scripts/Ansible/Metricbeat/metricbeat-config.yml) to /etc/ansible folder

2.  Update the metricbeat-config.yml file:
    - Search for output.elasticsearch:
    - Replace the IP address with the IP address of the ELK VM, as shown below:
-------------------------------------------------------------------------------------------------
    output.elasticsearch:
    hosts: ["10.1.0.4:9200"]
    username: "elastic"
    password:  "changeme"
-------------------------------------------------------------------------------------------------
3. In the same file:
   - Search for setup.kibana:
   - Replace the IP address with the IP address of the ELK VM, as shown below:
-------------------------------------------------------------------------------------------------
    setup.kibana:
    hosts: "10.1.0.4:5601"
-------------------------------------------------------------------------------------------------
4. Create a file in /etc/ansible folder called filebeat-playbook.yml by running command: nano metricbeat-playbook.yml

5. To specify which machine to install the Metricbeat on, specify the hosts as webservers in the header of Ansible playbook as shown below:
~~~
  ---
  - name: Install metric beat
    hosts: webservers
    become: true
    tasks:
~~~
6. Next, add the command to download metricbeat from artifacts.elastic.co.
~~~
  - name: Download metricbeat
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.1-amd64.deb
~~~
7. Then, add the command to install metricbeat:
~~~
  - name: install metricbeat
    command: dpkg -i metricbeat-7.6.1-amd64.deb
~~~
8. Add a section to copy the metricbeat-config.yml from the Ansible container to the Web VMs:
~~~  
   - name: drop in metricbeat config
     copy:
       src: /etc/ansible/metricbeat-config.yml
       dest: /etc/metricbeat/metricbeat.yml
~~~
9. Next, add the command to enable and configure metricbeat:
~~~
  - name: enable and configure system module
    command: metricbeat modules enable system
~~~
10. Then, add the command to setup metricbeat:
~~~
  - name: setup metricbeat
    command: metricbeat setup
~~~
11. Next, add the command to start metricbeat service:
~~~
  - name: start metricbeat service
    command: service metricbeat start
~~~
12. Lastly, add the command to enable metricbeat service on boot:
~~~
  - name: enable service metricbeat on boot
    systemd:
      name: metricbeat
      enabled: yes
~~~
13. Save the file.   The metricbeat-playbook.yml should look like this:  ![metricbeat-playbook.yml](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/98d1fea75619ffe05f7e13e8a8230215705cc13f/Scripts/Ansible/Metricbeat/metricbeat-playbook.yml)

14. Inside the Ansible container, run the command: ansible-playbook metricbeat-playbook.yml.   Make sure you are in the /etc/ansible folder.   The output should be as shown below:

![image](https://user-images.githubusercontent.com/84385348/119262240-d5161600-bc1d-11eb-8656-af76dec03eeb.png)

15. To verify successful installation of Metricbeat:
    - Navigate to ELK url:   http://52.184.196.183:5601/app/kibana
    - Click on Add metric data under Metrics
    - Click on System metrics.  
    - Scroll to Step 5: Module Data and click on Check Data, as shown below:
    ![image](https://user-images.githubusercontent.com/84385348/119261657-ba42a200-bc1b-11eb-813b-63d72c69cd1d.png)

 ### Navigating to ELK

1. The URL to navigate ELK is http://52.184.196.183:5601/app/kibana
2. In the left hand pane of landing page, select the Dashboard.
3. The Kibana dashboard will look like this:

![image](https://user-images.githubusercontent.com/84385348/119262315-232b1980-bc1e-11eb-8169-640abe45a40f.png)

4.  More on exploring Kibana in the link below:

    ![exploringkibana](https://github.com/ghialazaro/Week13-Homework-PROJECT/blob/52e6291c320cd3f565bc855679187cb63a001094/Exploring%20Kibana/exploringkibana.md)


