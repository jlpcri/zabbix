Zabbix
=====================

Ansible Playbooks, Configuration and Template files for Zabbix

Templates
---------------------

The West default OS templates for Linux and Windows can be found in the Monitoring_Templates directory. Additional DB and software approved templates will also be stored here.

Linux Playbook
--------------------- 
Confluence link for more information on the playbook.

[Agent Install Linux](https://wiki.west.com/display/IPEA/Agent+Install+Linux "Linux Agent Confluence")

Sample usage for kicking off the ansible agent playbook: 

`$ ansible-playbook -K zabbix_agent.yml -i staging.yml --limit=linux5838`

### Playbook Files & Setup

This playbook is built using the same format at the setup_monitoring role from the ETS-prep playbook, without all the other roles and variable files (eg. West defaults, datacenter and subnet files). Instead of the variable files in the ETS-prep playbook it uses: 

- defaults.yml, to set the default Zabbix server and user
- properties.yml, has all environments Zabbix servers and users
- set_properties.yml, is called to set the correct Zabbix server and user by subnet

To install using only the default Zabbix server you have set in defaults.yml comment out these two lines in zabbix_agent.yml.

```
  - name: Set Zabbix Property Variables
    include: set_properties.yml
```

The staging.yml file is an example inventory. Update with your own servers or create your own with the following group to not have to edit the playbook.

```
  ---
  linux:
    hosts:
      linux5838:
```

The templated files for /etc/zabbix/zabbix_agentd.conf and /etc/logrotate.d/zabbix-agent can be found here:
- roles/setup_monitoring/templates/etc/zabbix/zabbix_agentd.conf.j2
- roles/setup_monitoring/templates/etc/logrotate.d/zabbix-agent.j2

The zabbix_agent.yml file is the start script, to see all the tasks being performed in the install look at:
- roles/setup_monitoring/tasks/main.yml

Windows Playbook
---------------------
Confluence links for more information on the playbooks.

[Agent Install Windows](https://wiki.west.com/display/IPEA/Agent+Install+Windows "Windows Agent Install Confluence")

[Agent Uninstall Windows](https://wiki.west.com/display/IPEA/Agent+Uninstall+Windows "Windows Agent Removal Confluence")

Sample usage for the windows agent installer playbook.

`$ ansible-playbook zabbix_winagent.yml -i staging.yml --limit=windows`

Sample usage for the windows agent removal playbook.

`$ ansible-playbook zabbix_winrm.yml -i staging.yml --limit=windows`
