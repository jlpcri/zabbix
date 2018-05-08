#!/bin/sh
#
# description: control zabbix agent on aix
# processname: zabbix_agentd
# config: /etc/zabbix/conf/zabbix_agentd.conf
#
# Arguments: Start and stop Zabbix agent


if [ -x /etc/zabbix/sbin/zabbix_agentd ]; then
    exec=/etc/zabbix/sbin/zabbix_agentd
else
    exit 5
fi

prog=${exec##*/}
conf=/etc/zabbix/conf/zabbix_agentd.conf
timeout=10


start()
{
    echo  $"Starting Zabbix agent: "
    $exec -c $conf
    rv=$?
    return $rv
}
xstop()
{
    echo  $"Shutting down Zabbix agent: "
    pidfile=`cat $(grep "^PidFile=" $conf | cut -d= -f2 | tr -d '\r')`
    kill $pidfile 
    rv=$?
    return $rv
}
restart()
{
    xstop
    start
}

case "$1" in
    start|xstop|restart)
        $1
        ;;
    status)
        ps -ef | grep zabbix
        ;;
    *)
        echo $"Usage: $0 {start|xstop|status}"
        exit 2
esac

