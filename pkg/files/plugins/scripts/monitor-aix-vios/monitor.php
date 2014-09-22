<?php

require('rcs_function.php');


$agent_hostname = getenv('UPTIME_HOSTNAME');
$agent_port     = getenv('UPTIME_PORT');
$agent_password = 'vios-aix';
$agent_cmd = '/opt/uptime-agent/scripts/vios-stubb.ksh';

$agent_output = uptime_remote_custom_monitor($agent_hostname, $agent_port, $agent_password, $agent_cmd, "");
print $agent_output;



?>
