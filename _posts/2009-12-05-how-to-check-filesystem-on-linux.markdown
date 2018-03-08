---
layout: post
title: "How to Check Filesystem on Linux"
date: 2009-12-05 18:23:38 +0700
comments: true
categories: linux
---
Here I will explain about simple way to check filesystem type which installed on
our running linux system.

The fastest way is via reading filesystem table in /etc/fstab:

{% highlight bash %}
$ cat /etc/fstab
/dev/hda1        swap             swap        defaults         0   0
/dev/hda3        /                ext3        defaults         1   1
/dev/hda2        /home            ext3        defaults         1   2
/dev/hda4        /usr             ext3        defaults         1   2
#/dev/cdrom      /mnt/cdrom       auto        noauto,owner,ro  0   0
/dev/fd0         /mnt/floppy      auto        noauto,owner     0   0
devpts           /dev/pts         devpts      gid=5,mode=620   0   0
proc             /proc            proc        defaults         0   0
tmpfs            /dev/shm         tmpfs       defaults         0   0
{% endhighlight %}

Or using mount command:

{% highlight bash %}
$ mount
/dev/root on / type ext3 (rw,errors=continue,data=ordered)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/hda2 on /home type ext3 (rw)
/dev/hda4 on /usr type ext3 (rw)
tmpfs on /dev/shm type tmpfs (rw)
{% endhighlight %}

Or with looking system directory in file /proc/mounts: 

{% highlight bash %}
$ less /proc/mounts
{% endhighlight %}

That will show the following output:

{% highlight bash %}
rootfs / rootfs rw 0 0
/dev/root / ext3 rw,errors=continue,data=ordered 0 0
proc /proc proc rw 0 0
sysfs /sys sysfs rw 0 0
tmpfs /dev tmpfs rw,mode=755 0 0
devpts /dev/pts devpts rw,gid=5,mode=620 0 0
usbfs /proc/bus/usb usbfs rw 0 0
/dev/hda2 /home ext3 rw,errors=continue,data=ordered 0 0
/dev/hda4 /usr ext3 rw,errors=continue,data=ordered 0 0
tmpfs /dev/shm tmpfs rw 0 0
/proc/mounts lines 1-10/10 (END)
{% endhighlight %}

To make tidier, check with "df" command:

{% highlight bash %}
$ df -T
Filesystem    Type   1K-blocks      Used Available Use% Mounted on
/dev/root     ext3     4806936    696400   3866348  16% /
/dev/hda2     ext3     3850320    226940   3427792   7% /home
/dev/hda4     ext3     9621880   3866924   5266180  43% /usr
tmpfs        tmpfs      254680         0    254680   0% /dev/shm
{% endhighlight %}

The "-T" option will show the filesystem type. In order to read the disk
capacity easier, you can use "-h" option.

{% highlight bash %}
$ df -Th
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/root     ext3    4.6G  681M  3.7G  16% /
/dev/hda2     ext3    3.7G  222M  3.3G   7% /home
/dev/hda4     ext3    9.2G  3.7G  5.1G  43% /usr
tmpfs        tmpfs    249M     0  249M   0% /dev/shm
{% endhighlight %}
