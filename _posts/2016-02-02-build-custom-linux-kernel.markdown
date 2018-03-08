---
layout: post
title: "Build Custom Linux Kernel"
date: 2016-02-02 10:35:18 +0700
comments: true
categories: linux kernel
---
## Install Custom Linux Kernel

To build this custom Linux Kernel, I use Ubuntu 14.04 64 bit operating system.
At first, ensure all the required utilities installed correctly.

{% highlight bash %}
$ sudo apt-get install gcc make git libssl-dev libncurses5-dev
{% endhighlight %}

Download source from Linux Kernel Archives, for example, I use version 4.4.  
[https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz](https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz)

Extract the tarball file.

{% highlight bash %}
$ tar xJf linux-4.4.tar.xz
$ cd linux-4.4
{% endhighlight %}

We need to change configuration parameters to determine which settings and modules we need to build.
Use make *config command as follow. 
Choose one that match to your favor.
I usually use number 2.

#### 1. Use default kernel configuration.  
This settings comes from the kernel maintainer.

{% highlight bash %}
$ make defconfig 
{% endhighlight %}

#### 2. Use our existing configuration.  
Just press "Enter" when asked for configuration options.

{% highlight bash %}
$ make localmodconfig
{% endhighlight %}

#### 3. Manual selection with graphical menu.

{% highlight bash %}
$ make menuconfig
{% endhighlight %}

#### 4.  Duplicate our current config.

{% highlight bash %}
$ sudo cp /boot/config-`uname -r`* .config
{% endhighlight %}

Then, compile source, this process can take a while.

{% highlight bash %}
$ make -j4 
{% endhighlight %}

The parameter "4" is based on processor specification.
Set this at your own favor.  
Install modules.

{% highlight bash %}
$ sudo make modules_install 
{% endhighlight %}

Bootloader setup.

{% highlight bash %}
$ sudo make install 
{% endhighlight %}

Double check bootloader setup.

{% highlight bash %}
$ sudo update-grub2 
{% endhighlight %}

Reboot the system.
We can check our new installed kernel with this command.

{% highlight bash %}
$ uname -a
{% endhighlight %}

## Uninstall Custom Linux Kernel

Find out the version of custom kernel.  
Update filesystem search index.

{% highlight bash %}
$ sudo updatedb
{% endhighlight %}

In this example, I want to remove kernel version 3.16.0-30-generic.

{% highlight bash %}
$ CUSTOM_KERNEL_VERSION="3.16.0-30-generic"
$ locate $CUSTOM_KERNEL_VERSION
{% endhighlight %}

Ensure our system has other kernel installed beside $CUSTOM_KERNEL_VERSION.  
Then, delete all files & folders which contain $CUSTOM_KERNEL_VERSION name.

{% highlight bash %}
$ sudo rm /boot/vmlinuz-$CUSTOM_KERNEL_VERSION
$ sudo rm /boot/initrd.img-$CUSTOM_KERNEL_VERSION
$ sudo rm /boot/System.map-$CUSTOM_KERNEL_VERSION
$ sudo rm /boot/config-$CUSTOM_KERNEL_VERSION
$ sudo rm -rf /lib/modules/$CUSTOM_KERNEL_VERSION/
$ sudo rm /var/lib/initramfs-tools/$CUSTOM_KERNEL_VERSION
{% endhighlight %}

Do some cleaning.

{% highlight bash %}
$ sudo update-initramfs -k all -u
$ sudo update-grub2
{% endhighlight %}

Finish. Our custom kernel has been uninstalled from our system.
