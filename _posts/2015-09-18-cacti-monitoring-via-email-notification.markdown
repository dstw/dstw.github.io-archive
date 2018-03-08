---
layout: post
title: "Cacti Monitoring via Email Notification"
date: 2015-09-18 10:54:34 +0700
comments: true
categories: cacti snmp ubuntu 
---
Cacti can be configured so it can send email notification if something has occured in our system. This is can be useful, especially for system administrator to monitor their server condition. It can be done with help from one of cacti plugin that is thold. I do this procedure to monitor computer harddrive capacity on Windows.

So, if there is a computer which harddrive capacity near the capacity limit, cacti will send notification via email. This is useful to avoid misinformation that can bring system stop working or failed periodic system backup.

The installation procedure itself is easy enough. Before this plugin thold installation, we need to install settings plugin [http://docs.cacti.net/plugin:settings](http://docs.cacti.net/plugin:settings). We can install those plugins concurently. Download files that are needed:

{% highlight bash %}
$ cd /tmp
$ wget http://docs.cacti.net/_media/plugin:settings-v0.71-1.tgz
$ wget http://docs.cacti.net/_media/plugin:thold-v0.5.0.tgz
{% endhighlight %}

Rename download files in order to avoid error at extract time.

{% highlight bash %}
$ mv plugin:settings-v0.71-1.tgz settings-v0.71-1.tgz
$ mv plugin:thold-v0.5.0.tgz thold-v0.5.0.tgz
{% endhighlight %}

Extract tarball files.

{% highlight bash %}
$ tar zxf settings-v0.71-1.tgz
$ tar zxf thold-v0.5.0.tgz
{% endhighlight %}

Move extrated files to folder cacti/plugins.

{% highlight bash %}
$ sudo mv settings thold /var/www/html/cacti/plugins/
{% endhighlight %}

Then we configure cacti via web interface.

![cactiemail1](/images/cactiemail1.png)

Install and activate plugin Setting and Thold. After success, we need to configure thos plugins. Set configuration for email. We will use gmail account for mail service configuration. Configure following parameters:

![cactiemail2](/images/cactiemail2.png)

We can test to send email to confirm email sending process running well.

![cactiemail3](/images/cactiemail3.png)

After test passed, we can save the configuration. In the notification lists menu, add our email address for thold plugin which need to be sent if some notification raised by system.

![cactiemail4](/images/cactiemail4.png)

Choose graph which need to monitor the threshold. In this example, I will monitor a Windows host, so I can use harddrive free space percentage to trigger the thold.

![cactiemail5](/images/cactiemail5.png)

Configure the following parameter:

* Threshold Name: Desired treshold name
* Re-Alert Cycle: Notification sending interval
* Warning Low Threshold: Minimum limit value for threshold warning
* Alert Low Threshold: Maximum limit valuefor threshold warning
* Warning Notification List: List of email address notification for warning
* Alert Notification List: List of email address notification for alert

![cactiemail6](/images/cactiemail6.png)

Thold has been done configured. We just need to monitor the result. Cacti will send notification contain email and graph concerned about monitored device. In the example above, cacti will check harddrive capacity of server within a day.
If something has found that harddrive capacity meet the condition of below 25%, then cacti will send email notification warning. And if harddrive capacity below 10% then cacti will send email notification alert.  
This is an example of email notification from cacti.

![cactiemail7](/images/cactiemail7.png)

Reference:  
[http://docs.cacti.net/plugin:thold](http://docs.cacti.net/plugin:thold)
