---
layout: post
title: "Qemu Quick Reference"
date: 2009-02-12 20:37:38 +0700
comments: true
categories: virtualization 
---
Qemu is a software to virtualize an operating system. With this software, we can 
try an operating system without have to do installation on that computer, just 
like VMWare. In this article, I will share my experience of running operating 
system linux Parted Magic on Debian linux. The version of Qemu which I use is 
version 0.8.2. If you use linux, most of distro has been provide Qemu package on 
the default installation. Qemu is not only provided for linux operating system, 
but also available for other operating system like MS Windows and Mac OS. You 
can obtain Qemu from its official site.

To run Qemu, we must run command line from console:

{% highlight bash %}
$ qemu -cdrom /dev/hdc
{% endhighlight %}

Explanations from those command line is the -cdrom option for boot from cdrom 
drive and the “/dev/hdc” parameter is path for image we use (“/dev/hdc” is path 
for cdrom). Because Parted Magic is a kind of live cd, then we don’t need to do 
harddisk configuration.  
Error message which often appear for first running of Qemu like:

> You do not have enough space in ‘/dev/shm’ for the 128 MB of QEMU virtual RAM. 
> To have more space available provided you have enough RAM and swap, do as root: 
> umount /dev/shm

Those message indicates that the amount of virtual memory which will be used 
Qemu is less than generic size (default). To solve this problem, use this command:

{% highlight bash %}
$ sudo umount /dev/shm
$ sudo mount -t tmpfs -o size=144m none /dev/shm
{% endhighlight %}

After repaired, run Qemu once again. Then there is an xwindow with title Qemu and 
the operating system we run. If you need a full screen output, you can press key 
Ctrl + Alt + F or with adding fullscreen option, so the command we need to type 
become:

{% highlight bash %}
$ qemu -full-screen -cdrom /dev/hdc
{% endhighlight %}

To get cursor exit from the virtual machine screen, we can press Ctrl + Alt key 
combination. You can find details about another options on manual page. With 
those options, Qemu can be running for more complex implementation.

## Using Qemu for Installation Operating System to Harddisk

First, install Qemu on your existing operating system and if you need more 
performance tweaking, you can add additional module "kqemu". To install new 
operating system, we need to make virtual harddisk. Virtual harddisk that we 
will make is being used for save virtual files that needed for new operating 
system. The capacity is about 4 GB (or more value is better) based on computer 
specs we use. The commands:

{% highlight bash %}
$ qemu-img create debian.img 4G
{% endhighlight %}

The purpose of that commands is to create an image file named debian.img with 4 
GB capacity which will used by qemu. This image file act as virtual harddisk so 
while we setup the new operating system we can create harddisk partition to be 
more efficient.

The next step is, we setup the new operating system. For example, we will use 
Debian operating system. As requirement, we need the installation CD of Debian. 
Insert the Debian CD to CD bay, then run qemu with additional options in order 
to boot from CD drive.

{% highlight bash %}
$ qemu -hda debian.img -cdrom /dev/cdrom -boot d
{% endhighlight %}

The purpose of that commands is to use debian.img file as virtual harddisk for 
the guest operating system. Then options "-cdrom /dev/cdrom/ -boot d" added in 
order qemu can boot from CD drive first.

{% highlight bash %}
$ qemu -hda image.img /path/to/image.iso
{% endhighlight %}

The image.img is the name of virtual file and /path/to/image.iso is path to the 
guest operating system iso file. Then we can continue the installation process 
like as we do installation on real computer.
