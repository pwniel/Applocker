# Applocker

## Description

This script uses Windows Management Instrumentation (WMI) to monitor newly created processes. It reads a list of hashes from a file and stores them in a variable. It then uses the ManagementEventWatcher class to monitor newly created processes and the Get-FileHash cmdlet to compare the hash of each newly created process against the list of hashes stored in the file. If a match is found, the process is killed, a log is created and a notification is displayed.
For the Notfication i used the Windows.UI.Notifications.
For the Logfile you can use what you want. There are many useful funcions in github :-)

You can also send the Messages to a syslog server - i will update this repo when i finished the Project.


## Authors

Daniel Bergers
https://www.linkedin.com/in/daniel-bergers-1565171b9/

## Version History

* 0.1
    * Initial Release
