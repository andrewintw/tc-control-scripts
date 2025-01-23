# tc-control-scripts
A simple script to manage traffic control settings (tc) on eth0, including setting rate limits, deleting configurations, and showing current settings.

```shell
# ./tc_ctl.sh

Usage: ./tc_ctl.sh <{rate} | del | show>
  rate : Apply a rate limit (in kbit) to eth0. Example: ./tc_ctl.sh 20 (for 20kbit)
  del  : Delete the traffic control settings on eth0
  show : Show the current traffic control settings on eth0
```
