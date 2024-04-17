Sysmon
https://learn.microsoft.com/en-us/sysinternals/downloads/sysmon

Install: sysmon64 -i [<configfile>]
Update configuration: sysmon64 -c [<configfile>]
Install event manifest: sysmon64 -m
Print schema: sysmon64 -s
Uninstall: sysmon64 -u [force]

Example:

Install
sysmon64 -accepteula -i c:\windows\config.xml

Uninstall
sysmon64 -u

Show the configuration schema
sysmon64 -s

Dump the current configuration
sysmon -c