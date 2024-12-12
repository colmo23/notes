# Chapter 6 How user space starts

1. init
2. essential low level services
3. network
4. mid& high services like cron, printing, 
5. Login prompts, high applications, gui, etc,

Systemd - /usr/lib/systemd, /etc/systemd directories


# check for core dumps
coredumpctl


# systemctl 
##directories

/lib/systemd/system
  Package-installed units
/etc/systemd/system
  System admin–configured units
/run/systemd/system
  Nonpersistent runtime modifications


Example of installed service: /etc/systemd/system/k3s.service
