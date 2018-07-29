---
layout: post
title: "Build Linux Kernel from Source"
date: 2016-02-02 10:35:18 +0700
comments: true
categories: linux kernel
---

In order to doing some research in operating system, I need to build Linux
kernel from source. Although my GNU/Linux distro provide Linux kernel package
which ready to use, I can not use it for Linux Kernel development. It is
recommended to be able build my own Linux kernel in order to customize my build.

## Build & Install

To build the Linux kernel from source, I need several tools: `make`, `gcc`,
`libssl-dev`, `git` and (optionally) `ctags`, `cscope`, and/or `ncurses-dev`.
`make` & `gcc` is essential tools to build binaries from source. `libssl-dev` is
for cryptography purpose. `git` is used for control the revision of the source
code, it is recommended if I want to submit patch regarding Linux Kernel. The
`ncurses-dev` tools are used if I `make menuconfig` or `make nconfig`. The tool
packages may be called something else in some Linux distribution, so I may need
to determine the package first.

I use Ubuntu, so I can get these tools by running:

{% highlight bash %}
sudo apt install make gcc libssl-dev bc git exuberant-ctags libncurses5-dev
{% endhighlight %}

If you using different Linux distro, on Red Hat based systems like Fedora,
CentOS you can run:

{% highlight bash %}
sudo yum install gcc make git ctags ncurses-devel openssl-devel
{% endhighlight %}

And on SUSE based systems (like SLES, Leap or Tumbleweed), you can run:

{% highlight bash %}
sudo zypper in git gcc ncurses-devel libopenssl-devel ctags cscope
{% endhighlight %}

If you develop using git, there are different development tree of Linux Kernel
available. Different tree serve different purpose. Some of them I often use:

* rc: The latest version out from Linus Torvald tree. It serves main purpose to
  include some new feature or fix which ready for testing. Not recommended for
  production use.
* stable: Kernel marked stable are come from the stable maintainer which
  currently done by Greg-Kroah Hartman. This version good for production use.
* staging: The staging tree is collection of new driver which not yet ready to
  be included in Linus rc tree. This one highly recommended for new and aspiring
  Linux Kernel developer who want to contribute.

I need to change configuration parameters to determine which settings and
modules which need to build. Several options available:

#### 1. Use default kernel configuration.
This settings comes from the kernel maintainer. Remember, a default config may
not have the options you are currently using.

{% highlight bash %}
$ make defconfig
{% endhighlight %}

#### 2. Use existing configuration.  
Just press "Enter" when asked for configuration options.

{% highlight bash %}
$ make localmodconfig
{% endhighlight %}

#### 3. Manual selection with graphical menu.

{% highlight bash %}
$ make menuconfig
{% endhighlight %}

Compiling a kernel from scratch from a distribution configuration can take
"forever" because the distros turn on every hardware configuration possible. For
people wanting to do kernel development fast, you want to make a minimal
configuration. Steve Rostedt uses ktest.pl make_min_config to get a truely
minimum config, but it will take a day or two to build. Warning: make sure you
have all your USB devices plugged into the system, or you won't get the drivers
for them!

#### 4.  Duplicate current config.

When I want to see if a bug is fixed, I can duplicate the configuration on my
running kernel. That config file is stored somewhere in /boot/. There might be
several files that start with config, so I can use the one associated with your
running kernel. I can find it by running `uname -a` and finding the config file
that ends with my kernel version number. I copy that file into the source
directory as .config. Or just run this command:

{% highlight bash %}
$ sudo cp /boot/config-`uname -r`* .config
{% endhighlight %}

Among these options, I tend to use latest option because it use config from
distro developer and cause it recognizes most of my hardware.

Then, compile source, this process can take a while.

{% highlight bash %}
$ make -jX
{% endhighlight %}

Where X is a number like 2 or 4. If you have a dual core, 2 or 3 might be good.
Quad core, 4 or 6. Do not run with really big numbers unless you want your
machine to be slow. You can check the number with:

{% highlight bash %}
$ cat /proc/cpuinfo
{% endhighlight %}

On my machine, there are 0-3 processor available. I want to use all of these
resources to perform the compiling process. So I can use `make -j4`.  
This compiling process can take a lot of time. So you can make the time to do
some other interesting tasks such as read books of Linux Kernel development,
read LWN, lurking on LKML, etc.

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
I can check my new installed kernel with this command.

{% highlight bash %}
$ uname -a
{% endhighlight %}

Enjoy the new kernel.

## Remove

When there is such as installation process, then there should be the
unintallation process too.  
Fist I need to find out the version of custom kernel. I can look at `/boot`
directory.

{% highlight bash %}
$ ls /boot/
{% endhighlight %}

There are several files. I can refer to the vmlinuz files to determine which
version I need to process.

{% highlight bash %}
/boot/vmlinuz-4.15.0-23-generic
/boot/vmlinuz-4.15.0-29-generic
/boot/vmlinuz-4.18.0-rc5
/boot/vmlinuz-4.18.0-rc6
{% endhighlight %}

In this example, I want to remove kernel version 4.18.0-rc5.  
But, before doing this, I must ensure that my system has other kernel installed
beside $CUSTOM_KERNEL_VERSION. Also I must ensure that I not removing kernel
which I currently running on, because it can lead to unexpected behaviour of my
system. When everything is okay, I can delete all files and folders which
contain $CUSTOM_KERNEL_VERSION name.

{% highlight bash %}
$ CUSTOM_KERNEL_VERSION="4.18.0-rc5"
$ sudo rm /boot/vmlinuz-$CUSTOM_KERNEL_VERSION
$ sudo rm /boot/initrd.img-$CUSTOM_KERNEL_VERSION
$ sudo rm /boot/System.map-$CUSTOM_KERNEL_VERSION
$ sudo rm /boot/config-$CUSTOM_KERNEL_VERSION
$ sudo rm -rf /lib/modules/$CUSTOM_KERNEL_VERSION/
$ sudo rm /var/lib/initramfs-tools/$CUSTOM_KERNEL_VERSION
{% endhighlight %}

Lastly, I do some cleaning.

{% highlight bash %}
$ sudo update-initramfs -k all -u
$ sudo update-grub2
{% endhighlight %}

Finish. My kernel has been successfully uninstalled.
