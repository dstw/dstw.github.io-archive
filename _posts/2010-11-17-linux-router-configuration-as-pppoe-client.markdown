---
layout: post
title: "Linux Router Configuration as PPPoE Client"
date: 2010-11-17 10:33:38 +0700
comments: true
categories: linux networking
---
Prepare all information needed: username, password and server IP Address (public)
up to existing PPPoE configuration.

Configuration sample:

{% highlight text %}
User : aaa@package.isp.net
Password : bbb
Service : packageservice
IP Address : yyy.yyy.yyy.yyy
Local IP Address:
eth1 -> local, for example: 192.168.0.254/24
eth0 -> wan, for example: yyy.yyy.yyy.yyy, not need to configure, because it
will update automatically using PPPoE
{% endhighlight %}

Commands for PPPoE Setup:

{% highlight bash %}
$ sudo pppoe-setup
{% endhighlight %}

It will prompt you about configuration of PPPoE client that you want to use.

{% highlight bash %}
USERNAME
>>> Enter your PPPoE user name (default username): aaa@package.isp.net
{% endhighlight %}

Fill with username and password that already prepared.

{% highlight bash %}
INTERFACE
>>> Enter the Ethernet interface connected to the DSL modem
For Solaris, this is likely to be something like /dev/hme0.
For Linux, it will be ethn, where ‘n’ is a number.
(default eth0): eth0
{% endhighlight %}

Fill with interface where PPPoE will dial to its server (toward WAN).

{% highlight bash %}
>>> enter the demand value (default no): (tekan enter)
{% endhighlight %}

For dedicated connection, at option "demand value" choose "no"

{% highlight bash %}
Please enter the IP address of your ISP’s primary DNS server.
If your ISP claims that ‘the server will provide DNS addresses’,
enter ‘server’ (all lower-case) here.
If you just press enter, I will assume you know what you are
doing and not modify your DNS setup.
>>> Enter the DNS information here: XXX.XXX.XXX.XXX
>>> Enter the secondary DNS server address here: XXX.XXX.XXX.XXX
{% endhighlight %}

Fill with IP address of DNS 1 and DNS 2.

{% highlight bash %}
PASSWORD
>>> Please enter your PPPoE password: yyyy
{% endhighlight %}

Enter password which will be used (twice with confirmation).

{% highlight bash %}
FIREWALLING
Please choose the firewall rules to use. Note that these rules are very basic. 
You are strongly encouraged to use a more sophisticated firewall setup; however, 
these will provide basic security. If you are running any servers on your 
machine, you must choose ‘NONE’ and set up firewalling yourself. Otherwise, the 
firewall rules will deny access to all standard servers like Web, e-mail, ftp, 
etc. If you are using SSH, the rules will block outgoing SSH connections which 
allocate a privileged source port. The firewall choices are: 

0 – NONE: This script will not set any firewall rules. You are responsible for 
ensuring the security of your machine. You are STRONGLY recommended to use some 
kind of firewall rules. 
1 – STANDALONE: Appropriate for a basic stand-alone web-surfing workstation 
2 – MASQUERADE: Appropriate for a machine acting as an Internet gateway for a LAN

>>> Choose a type of firewall (0-2): 0
{% endhighlight %}

With assumption that this firewall configuration (iptables) will use default
configuration then choose 0.

{% highlight bash %}
>>> Accept these settings and adjust configuration files (y/n)? y
{% endhighlight %}

On last prompt, confirm that previous choices is right.

Then, you need to set up service name on pppoe.conf

{% highlight bash %}
# vim /etc/ppp/pppoe.conf
{% endhighlight %}

Search for line with "SERVICENAME", then add it. Enter without quotes.

{% highlight bash %}
SERVICENAME=internetservice
{% endhighlight %}

Run PPPoE client.

{% highlight bash %}
# pppoe-start
{% endhighlight %}

If there is no problem found, then there will such information like:

{% highlight bash %}
.connected!
{% endhighlight %}

Finally, your Linux PPPoE client setup is succeeded.

# Restart PPPoE Client on Linux

Below is a simple script which can be used to restart PPPoE client on Linux.
FYI, Linux not shipped with built-in command to restart its PPPoE client.

{% highlight bash %}
#!/bin/bash

if [ -r /var/run/ppp0.pid ]; then
/usr/sbin/pppoe-stop && /usr/sbin/pppoe-start
else
echo "$0: No PPPoE connection appears to be running"
echo "Trying to start PPPoE Connection"
/usr/sbin/pppoe-start
fi

exit 0
{% endhighlight %}

The purpose of code above is to help administrator to restart PPPoE client
without open new connection to remote host.

Thanks for reading.
