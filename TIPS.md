
# Rotating Logs

Log files can become very large. 
Use `logrotate` and `crontab` to rotate logs.
Useful crontab tool: [Cronitor](https://crontab.guru/#0_0_*_*_0)

Edit Crontab with `crontab -e`:

```bash
# Crontab: "At 00:00 on Sunday."
0 0 * * 0 /usr/sbin/logrotate /etc/logrotate.conf
```

Add file to logrotate config. Remember to change your log file path.
```
# /etc/logrotate.conf

/mnt/blockstorage/telos-mainnet/logs/*.log {
  weekly
  missingok
  rotate 4
  compress
  delaycompress
  notifempty
  size 100M
  copytruncate
}
```
