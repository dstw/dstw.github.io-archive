---
layout: post
title: "Cacti for Monitoring Windows Host"
date: 2015-09-18 10:54:34 +0700
comments: true
categories: cacti snmp ubuntu windows 
---
To monitor windows based host, we need to install custom cacti template. I use windows template to monitor computer with Windows 7, Windows Server 2008 R2 and Windows Server 2012 R2 operating system installed. Template can be download, here:

https://github.com/didiksetiawan/cacti-templates

Extract and copy files from resource/snmp_queries to cacti directory

{% highlight bash %}
$ sudo cp snmp_informant_standard_*.xml /usr/share/cacti/site/resource/snmp_queries/
{% endhighlight %}
Then we need import that xml templates from folder "template" using cacti web interface.

Log in to cacti web interface and point to Import Templates

![cactiwinhost1](/images/cactiwinhost1.png)

Browse template folder that have been downloaded and search for cacti_host_template_windows_host_-_snmp_informant.xml file then click import. This template is ready to use.

Next, I need to activate SNMP service in Windows host as well as others add-on for SNMP. Login to Control Panel > Programs and Features > Windows Features. Check in Simple Network Management Protocol (SNMP).

![cactiwinhost2](/images/cactiwinhost2.png)

After SNMP feature success, configure SNMP service. Log in to menu Service.

![cactiwinhost3](/images/cactiwinhost3.png)

Change configuration for service "SNMP Service". Add appropriate parameter community, and allow SNMP so it can be accessed from anywhere host.
Additionally, we can add contact address in tab Agent (optional).
After SNMP installed and configured, install 3rd party software that is SNMP informant. This app can be download at [http://www.snmp-informant.com/downloads.htm#SNMP_Informant_-_Freeware_Products](http://www.snmp-informant.com/downloads.htm#SNMP_Informant_-_Freeware_Products). To install, we just use standard wizard procedure, no need custom configuration.

How to add device in cacti

![cactiwinhost4](/images/cactiwinhost4.png)

After the device creation success, next step is create graph for this device.
It can be done automatically with click "*Create Graph for this Host".
Then select appropriate item. Then edit the Graph Trees.
Add to tree in order to it can be accessed from Tree View mode.
Finish, we can access graph that we created in tab graphs.
Happy cactying.

![cactiwinhost5](/images/cactiwinhost5.png)

Reference:

[http://everythingshouldbevirtual.com/cacti-monitoring-for-windows-servers](http://everythingshouldbevirtual.com/cacti-monitoring-for-windows-servers)
