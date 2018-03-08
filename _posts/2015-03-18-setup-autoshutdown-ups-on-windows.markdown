---
layout: post
title: "Setup Autoshutdown UPS on Windows"
date: 2015-03-18 21:04:31 +0700
comments: true
categories: batch cmd ups win_server_2008 win_server_2008_r2
---
Thus principally, to run computer autoshutdown using UPS software, is with link a batch script to perform shutdown. So, if there is a condition where the power is off, then that UPS software trigger the shutdown script to perform execution.
In this example, I will use two kinds of UPS that are Prolink PRO 1200 SFCU and Eaton AVR 625.

### Prolink PRO 1200 SFCU

In this example I use UPS on the computer with Windows Server 2008 R2 Operating System. The steps is explained below:
Login into computer with UPS installed
Install driver and UPS software. The insttaler can be download at:

[http://www.power-software-download.com/viewpower/installViewPower_Windows.zip](http://www.power-software-download.com/viewpower/installViewPower_Windows.zip)

To install the software, we just click next as well as almost installation process on Windows. After installed successfully, there will appear UPS icon on Windows system tray and there is a notification message about this system is starting.
After installed, open control panel from that UPS software on browser with this address:

[http://127.0.0.1:15178/ViewPower/#](http://127.0.0.1:15178/ViewPower/#)

Login as admin, the default password for Prolink PRO 1200 SFCU is "administrator"

![ups1](/images/ups1.png)

![ups2](/images/ups2.png)

Change this default password immediately on configuration menu ViewPower > Change Password

![ups3](/images/ups3.png)

Check in to UPS Settings > Local Shutdown

![ups4](/images/ups4.png)

Set the check box up on menu "When the UPS is running from the battery" and fill the section "Shut down the local system after" with value 6 (in minutes).  
In the section "Time to wait before shutting down the local system" fill with value 5 (in minutes).  
In the section "Maximum file execution time", fill with value 1 (in minutes).   
In the section "File to execute when shutting down" fill with value of path to shutdown script.   
In the following example, I created script on C:\rshutdown.bat.

![ups5](/images/ups5.png)

Then make a new file with notepad, give it name rshutdown.bat, save on disk C. The contents:

{% highlight batch%}
C:\Windows\System32\shutdown.exe /s /t 20
{% endhighlight %}

That command is being used to shutdown the computer.

### Eaton AVR 625

Same as previous UPS configuration, the following setup I do with OS Windows Server 2008. The steps to setup are:
Install UPS Eaton AVR software that delivered with the CD. The installation process once again is almost same as the Windows application installation, we just click next and next.
After installation successful, set the UPS to run the shutdown process if a failure power source has occured.
Click icon on Windows system tray, check in to menu Settings.

![ups6](/images/ups6.png)

Fill with command line parameter where we save the batch file for shutdown. 
In the following example, I use file on "C:\User\edp11\Desktop\putty\shutdown.bat"

![ups7](/images/ups7.png)

The script contents is same as previous script we write:

{% highlight batch%}
C:\Windows\System32\shutdown.exe /s /t 20
{% endhighlight %}

Testing

This step is important. The purpose is to verify setup process we have done so far. The checking process can be done with, cut off the UPS power source so it can simulate a power shutdown condition.
After 5 minutes from the time the power source off, we can check if the autoshutdown process is success or not.
If the computer softly turned off (warm shutdown) the the UPS software setup is success.

Shutdown another Host on the Network

In the script above, the shutdown command is used to shutdown computer that connected directly to UPS via USB data cable.
In other way, for another computer with still on the same power source domain, the shutdown proccess can be applied via network with additional script and custom tools.
The detail is explained below.

Windows Host Shutdown

We will shutdown the computer with Windows OS use psshutdown tools. Download the tool on:

[https://download.sysinternals.com/files/PSTools.zip](https://download.sysinternals.com/files/PSTools.zip)

Extract the psshutdown file, we only need this file to run the shutdown process.
Save following file in anywhere, in this example in C:\psshutdown.exe.
Then add the following file as file shutdown.bat:

{% highlight batch%}
C:\psshutdown.exe -u foo -p bar \172.16.10.245
{% endhighlight %}

In that example I use username foo and password bar and with IP 172.16.10.245. Set this with our need.
It is recommended to test the script with manually typing on the command prompt, to avoid notification from psshutdown application stop the shutdown process.
Because, on the first time, we will asked for confirmation about end user license agreement from this application.

Linux Host Shutdown 

In order to shutdown Linux based host, we use another application from putty that is plink.exe. Download from:

[http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip](http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip)

Confirm that we can automatic login to Linux. To do this, we need to generate public and private key for Windows host where the autoshutdown trigger is run.

![ups8](/images/ups8.png)

Click button Generate. While wait the key making process, we could moving the mouse in order to accelerate the process.

![ups9](/images/ups9.png)

After generating process, save the public and private key.
Save with easy name to find, for example for the public key we could named it key-server.pub and for the private key key-server.ppl.
If the following notification appear, then click Yes, just ignore it, because weneed automatic login without passpharase which same as password.

![ups10](/images/ups10.png)

For the next step, we need add public key that we have been created into host which want we access without password.
Login in to that host with putty and user root. Then type this commands.

{% highlight bash %}
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOPrv4jtzSdRbaRY16miDNOnAYDnha0A+V92+ul88xCjLmLOYL78KyGKc1u47ZtCSpV590sLdSmXULvaSC6Fs8mVg+DdgumoBRZg1unwYGwUp9DKVjI+6DxAJIjwsarCS78TxtuGb+55ujnaJh4rSwLHnuqvDB3q6JtR/yET28Fq6RJ4Czjpv06X0EohfLVqwXdMKsZXbde/9vyFB9G1CrsnA6KXg1bsYDKW7xp4ayS4Q2yA1P7itX4zBNyRVQjdR5K/PTuNBzItbYiM7cyL6P6kfB3pnpZJQtK+IV0RhSPOQaaAJch+DwFcElamuENsDeE77PcYTLrqIxaIOYVPhh root@server" >> .ssh/authorized_keys
{% endhighlight %}

Change the parameter in the quotation mark (" ") above using contents from key-server.pub public key file that exist.
Then add this script in to file shutdown.bat.

{% highlight batch %}
C:\plink.exe -i C:\key-server.ppk root@172.16.10.250 /sbin/poweroff
{% endhighlight %}

Extract plink.exe file from putty package we have been downloaded and save in C:, as well as the key-server.ppk private key.
Edit the IP Server above to your needs.

As well as the script to shutdown the Windows host, it is recommended to test the script with manually typing on the command prompt, to avoid notification from psshutdown application stop the shutdown process.
