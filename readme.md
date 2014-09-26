#monitor-aix-vios

Agent Side Script Setup Steps
-----------------------------

 1. Download the [Agent Side Scripts](dist/monitor-aix-vios-agent-files.zip?raw=true)
 2. Extract the contents of the zip into /opt/uptime-agent/scripts on the target AIX server
 3. If needed chown & chmod the files to be owned by the uptime:staff user and has execute permissions:
 ```
 cd /opt/uptime-agent/scripts
 chmod +x uptime_nmon_ioadapt.ksh
 chown uptime:staff uptime_nmon_ioadapt.ksh
      
 chmod +x nmon_ioadapt.pl
 chown uptime:staff nmon_ioadapt.pl
 ```
 4. Update the uptime agent's /opt/uptime-agent/bin/.uptmpasswd file and add the following line:

 ```
     aix-vios /opt/uptime-agent/scripts/uptime_nmon_ioadapt.ksh
 ```
 5. Provide aix-vios as the Agent Password when configuring the Service Monitor


 
