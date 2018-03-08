---
layout: post
title: "Built PC Router Using FreeBSD"
date: 2009-02-05 20:23:38 +0700
comments: true
categories: freebsd networking
---
To build a PC router with FreeBSD, first collect informations about networking
scheme. For example, we assume our network to have scheme as follow:

Public IP = 210.100.12.130  
Local IP = 192.168.12.65  
Network address of Local = 192.168.12.64/26  

We build router along with firewall using pf on FreeBSD. If you want to use
iptables as on Linux, you might use iptables which could be installed from
source.

Step by step of the making process:

Prepare computer with 2 network card which have FreeBSD operating system
installed.
Next, because in the default kernel FreeBSD that we have installed is not
have additional option of router functionality, then we need to recompile
kernel. The purpose of recompile process is to include the options we need,
beside that it useful to slenderize kernel so we can accelerate the loading
time and decrease memory.

Compilation steps:

Copy file GENERIC on a file with new name (for example: ROUTER) and edit
using text editor.

{% highlight bash %}
# cd /usr/src/sys/i386/conf
# cp GENERIC ROUTER
# ee ROUTER
{% endhighlight %}

When edit file ROUTER, change "indent" row with the new kernel name (set
to the file name). Remove options that not needed, but be careful if you
still doubt about options that you remove. Then add option:

{% highlight bash %}
options ALTQ
options ALTQ_CBQ
options ALTQ_RED
options ALTQ_RIO
options ALTQ_PRIQ
options ALTQ_HFSC
options ALTQ_NOPCC

device pf
device pflog
device pfsync
{% endhighlight %}

Then save that configuration.

Do the compile process of new kernel.

{% highlight bash %}
# config ROUTER
{% endhighlight %}

It will show directory to process of compilation. If there is a syntax
error, we could repair on the ROUTER file.

{% highlight bash %}
# cd ../compile/ROUTER
# make depend && make && make install
{% endhighlight %}

If the compilation fail, before we check ROUTER file, we should run command:

{% highlight bash %}
# make cleandepend
{% endhighlight %}

if the compilation process success, we could use the new kernel after
rebooting computer, after the configuration process finished.

Configure IP Forwarding. Edit file sysctl.conf

{% highlight bash %}
# ee /etc/sysctl.conf
{% endhighlight %}

add row:

{% highlight bash %}
net.inet.ip.forwarding=1
{% endhighlight %}

save the configuration.

For networking configuration, NAT and pf options to system, edit file
/etc/rc.conf.

{% highlight bash %}
# ee /etc/rc.conf
{% endhighlight %}

edit and add row:

{% highlight bash %}
router_enable=”YES”
pf_enable=”YES” # Enable PF (load module if required)
pf_rules=”/etc/pf.conf” # rules definition file for pf
pf_flags=”-q” # additional flags for pfctl startup
{% endhighlight %}

NAT configuration and pf, on file /etc/pf.conf.

{% highlight bash %}
# ee /etc/pf.conf
{% endhighlight %}

enable interface and NAT:

{% highlight bash %}
ext_if="rl0" # public network
int_if="rl1" # local network
internal_net="192.168.12.64/26"
external_addr="210.100.12.130"
nat on $ext_if from $internal_net to any -> $external_addr
pass on $int_if from any to any
{% endhighlight %}

after finish, save the configuration. Run command:

{% highlight bash %}
# /etc/netstart
{% endhighlight %}

Configuration for FreeBSD PC Router has finished, in order the computer can
recognized new configuration, reboot it first. Then to check the connection to
outside network, we can check with ping command. Then we can add DHCP server on
the router.

# DHCP Server using FreeBSD

DHCP is a protocol which use by computers in the network to determine
parameters like default gateway, subnet mask, IP address and DNS from a DHCP
server. The general purpose of a DHCP server is to make IP address allocation
easier and IP setting more dynamic. It help computer user so not need to set IP
when there is an addition of new user or after reformat a computer.  
More information about DHCP can be read on:

[http://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol#Introduction](http://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol#Introduction)

After you understand the function and how to DHCP Server work, let we try to
install a DHCP Server.

First, login as root on your server, then go to dhcp server ports directory. If
not connected to internet, we can solve with copy dhcp file to directory
/usr/ports/distfiles/.  
Commands to install:

{% highlight bash %}
# cd /usr/ports/net/isc-dhcp3-server/
# make install clean
{% endhighlight %}

After installation finished, configure it.

{% highlight bash %}
# ee /usr/local/etc/dhcpd.conf
{% endhighlight %}

Below is example of dhcp.conf contents:

{% highlight bash %}
ddns-update-style none;
log-facility local7;

subnet 192.168.12.64 netmask 255.255.255.192 { 
range 192.168.12.66 192.168.12.76;
option routers 192.168.12.65;
option subnet-mask 255.255.255.192; 
option domain-name-servers 210.100.12.129;
option domain-name example.com;
default-lease-time 3600;
max-lease-time 86400;
}
{% endhighlight %}

Don't forget to save file.  
Configure rc.conf to determine DHCP Server running process and which interface
to listening on this DHCP Server.

{% highlight bash %}
# ee /etc/rc.conf
{% endhighlight %}

Add following lines:

{% highlight bash %}
dhcpd_enable="YES"
dhcpd_flags="-q"
dhcpd_conf="/usr/local/etc/dhcpd.conf"
dhcpd_withumask="022"
dhcpd_withuser="dhcpd"
dhcpd_withgroup="dhcpd"
dhcpd_iface="rl1"
{% endhighlight %}

then save changes.

Run the DHCP Server.

{% highlight bash %}
# /usr/local/etc/rc.d/isc-dhcpd.sh start
{% endhighlight %}

Starting dhcpd.

Until this step, the installation process is finished and you could run the DHCP
Server. To use other features, you could try on your own.

Then you could try the new DHCP server with configure on client computers to
obtain IP address automatically on Windows, Linux and FreeBSD PC.  
Watch the DHCP Server leasing activity with:

{% highlight bash %}
# tail -f /var/db/dhcpd.leases

lease 192.168.12.66 {
starts 2 2007/01/30 23:25:05;
ends 3 2007/01/31 00:25:05;
tstp 3 2007/01/31 00:25:05;
binding state active;
next binding state free;
hardware ethernet 00:01:6c:b0:d0:44;
uid 010001l260320D;
client-hostname underiez;
}
{% endhighlight %}

If we prefer to install without port (using source) below are the steps:

First, download isc-dhcp3-server 3.0.5_2.tbz package.
Choose the right FreeBSD version that is for AMD or Intel, then upload it from
other PC using FTP or other methods. Because I use file isc-dhcp3-server
3.0.5_2.tbz and FreeBSD release 7.0, so the command I use.

{% highlight bash %}
# pkg_add isc-dhcp3-server 3.0.5_2.tbz
{% endhighlight %}

Then add the following lines in /etc/rc.conf.

{% highlight bash %}
# ee /etc/rc.conf

dhcpd_enable="YES"
dhcpd_flags="-q"
dhcpd_conf="/usr/local/etc/dhcpd.conf"
dhcpd_withumask="022"
dhcpd_withuser="dhcpd"
dhcpd_withgroup="dhcpd"
dhcpd_iface="rl1"
{% endhighlight %}

then change configuration in /usr/local/etc/dhcpd.conf

{% highlight bash %}
# cp /usr/local/etc/dhcpd.conf.sample /usr/local/etc/dhcpd.conf
# ee /usr/local/etc/dhcpd.conf

ddns-update-style none;
log-facility local7;

subnet 192.168.12.64 netmask 255.255.255.192 {
range 192.168.12.66 192.168.12.76;
option routers 192.168.12.65;
option subnet-mask 255.255.255.192;
option domain-name-servers 210.100.12.129;
option domain-name example.com;
default-lease-time 3600;
max-lease-time 86400;
}
{% endhighlight %}

save the file. Then run commands.

{% highlight bash %}
# /usr/local/etc/rc.d/isc-dhcpd start
{% endhighlight %}

So those are my explanations about DHCP Server on FreeBSD.
