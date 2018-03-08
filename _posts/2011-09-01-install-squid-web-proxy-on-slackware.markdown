---
layout: post
title: "Install Squid Web Proxy on Slackware"
date: 2011-09-01 18:16:38 +0700
comments: true
categories: linux networking squid
---
These article will discuss about how to install proxy server using Squid
(2.7STABLE9) in Linux Slackware 12.2.

First, check harddrive partition which will be used for Squid cache partition.

{% highlight bash %}
$ df -h

Filesystem      Size  Used Avail Use% Mounted on
udev            1.9G     0  1.9G   0% /dev
tmpfs           387M  6.2M  381M   2% /run
/dev/sda2        30G   19G  9.4G  67% /
tmpfs           1.9G   11M  1.9G   1% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           1.9G     0  1.9G   0% /sys/fs/cgroup
/dev/sda2        30G   19G  9.4G  67% /home
tmpfs           387M   52K  387M   1% /run/user/1000
/dev/sdb1        38G   57M   38G   1% /squid
{% endhighlight %}

Create some partition on that harddrive. For assumption, you will use harddrive
which have been mounted on /dev/sdb. That harddrive then divided to 4 section.
You need to format those partitions. Before do that, you must ensure those
partitions not in active state.

{% highlight bash %}
$ sudo umount /dev/sdb1
$ sudo umount /dev/sdb2
$ sudo umount /dev/sdb3
$ sudo umount /dev/sdb4
{% endhighlight %}

Then, format those partitions with partition tool on Linux, such as fdisk and
cfdisk. In this example, I will use cfdisk.

{% highlight bash %}
$ sudo cfdisk /dev/sdb
{% endhighlight %}

Change its partition filesystem to ReiserFS filesystem.

{% highlight bash %}
$ sudo mkreiserfs /dev/sdb1
{% endhighlight %}

Repeat that step for three other partition.

{% highlight bash %}
$ sudo mkreisfers /dev/sdb2
$ sudo mkreiserfs /dev/sdb3
$ sudo mkreiserfs /dev/sdb4
{% endhighlight %}

Make 4 directory in root called cache1, cache2, cache3 and cache4 respectively
which will be used for cache engine directory.

{% highlight bash %}
$ sudo mkdir /cache1
$ sudo mkdir /cache2
$ sudo mkdir /cache3
$ sudo mkdir /cache4
{% endhighlight %}

Edit filesystem table in /etc/fstab. This have purpose to save change which have
been done for cache partition so they can be used when computer boot. Add the
following lines:

{% highlight bash %}
/dev/sdb1       /cache1 reiserfs notail,noatime 1 2
/dev/sdb2       /cache2 reiserfs notail,noatime 1 2
/dev/sdb3       /cache3 reiserfs notail,noatime 1 2
/dev/sdb4       /cache4 reiserfs notail,noatime 1 2
{% endhighlight %}

Mount all of those partition.

{% highlight bash %}
$ sudo mount /dev/sdb1
$ sudo mount /dev/sdb2
$ sudo mount /dev/sdb3
$ sudo mount /dev/sdb4
{% endhighlight %}

then all of those partition will be mounted on /cache1, /cache2, /cache3 and
/cache4 directory.

Create new user and group which will be used by Squid daemon.

{% highlight bash %}
$ sudo groupadd squid
$ sudo useradd squid -g squid -s /no/login
{% endhighlight %}

This Squid user will be used for setting up permission on cache directories you
have been created before.

{% highlight bash %}
$ sudo  chown -R squid.squid /cache*
{% endhighlight %}

Change settings for file descriptor on Linux Slackware. Variable which will need
to be changed is on FD_SETSIZE in file /usr/include/linux/posix_types.h
(Slackware 12.2). Edit this file and search for following lines:

{% highlight c %}
/* Number of descriptors that can fit in an `fd_set’. */
#define __FD_SETSIZE 1024[/sourcecode]
{% endhighlight %}

change to:

{% highlight c %}
/* Number of descriptors that can fit in an `fd_set’. */
#define __FD_SETSIZE 16384
{% endhighlight %}

Then use following commands:

{% highlight bash %}
$ sudo  chown -R squid.squid /cache1
$ sudo ulimit -HSn 16384
{% endhighlight %}

After all prerequisites have been fullfiled, then it is time to download Squid
source code. You will compile and install from its source code.
It source code can be obtained from its official website in
http://www.squid-cache.org.
For assumption, I use version squid-2.7STABLE7.

{% highlight bash %}
$ sudo  chown -R squid.squid /cache1
$ wget http://www.squid-cache.org/Versions/v2/2.7/squid-2.7.STABLE9.tar.gz
$ tar zxf squid-2.7STABLE9.tar.gz
$ cd squid-2.7STABLE9.tar.gz
{% endhighlight %}

Before compile its source code, you need to find a variable (I called it xyz
variable) which will be used to compile it. These variable is obtained from
processor specification. You can check it with commands:

{% highlight bash %}
$ sudo  chown -R squid.squid /cache1
$ sudo cat /proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i5-2410M CPU @ 2.30GHz
stepping	: 7
microcode	: 0x29
cpu MHz		: 2699.804
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm epb tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs		:
bogomips	: 4589.51
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

--ommited--
{% endhighlight %}

From that output, the number you need to use is on the cpu MHz section. In that
example, the number is 2699 and I will be rounded to 2700.
The formula I use:

{% highlight text %}
xyz = ([cpu MHz] / 500) x 30
{% endhighlight %}

Then from the previous number, variable xyz you can get:

{% highlight text %}
xyz = (2700/500) x 30 = 5.4 x 30 = 162. 
{% endhighlight %}

Compile the Squid source code which following prefix and don't forget to change
variable xyz with previous number:

{% highlight bash %}
./configure\
--prefix=/usr\
--exec-prefix=/usr\
--libexecdir=/usr/lib/squid\
--localstatedir=/var\
--sysconfdir=/etc/squid\
--enable-delay-pools\
--enable-http-violations\
--enable-poll\
--disable-ident-lookups\
--enable-truncate\
--enable-removal-policies=lru,heap\
--enable-cachemgr-hostname=www\
--enable-linux-netfilter\
--enable-stacktraces\
--enable-unlinkd\
--enable-storeio=diskd,ufs,aufs,coss,null\
--enable-snmp\
--bindir=/usr/sbin\
--enable-arp-acl\
--enable-async-io=xyz\
--disable-icmp\
--enable-gnuregex\
--enable-large-cache-files\
--with-aufs-threads=xyz\
--with-maxfd=16384\
--enable-htcp\
--enable-coss-aio-ops\
--with-pthreads\
--with-large-files\
--CFLAGS=-O6 -s -DNUMTHREADS=xyz\
{% endhighlight %}

After compiling process success, then install with:

{% highlight bash %}
$ sudo make && make install
{% endhighlight %}

If there are not appear an error message, then Squid have been successfully
installed on your system.

Do some tune up on Squid configuration. Edit file /etc/squid/squid.conf. Make
some adaptation for network in access list options (acl).

{% highlight text %}
cache_mem ==> cache memori formula = (amount of ram / 4)
cache_dir ==> 80% from size of cache partition (for example: 16000 64 256)
{% endhighlight %}

For transparent proxy mode, you need to add the following line:

{% highlight text %}
http_port 3128 transparent
{% endhighlight %}

Make Squid log file and set this permission:

{% highlight bash %}
$ sudo mkdir -p /var/log/squid
$ sudo touch /var/log/squid/access.log
$ sudo touch /var/log/squid/cache.log
$ sudo chown -R squid.squid /var/log/squid
{% endhighlight %}

Afterall, run Squid commands:

{% highlight bash %}
$ sudo squid -z
$ sudo squid -s
{% endhighlight %}

Check whether Squid have been running with nmap command.

{% highlight bash %}
$ nmap localhost

Starting Nmap 7.01 ( https://nmap.org ) at 2016-11-28 01:27 WIB
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000062s latency).
Not shown: 998 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
53/tcp   open  domain
80/tcp   open  http
3128/tcp open  squid-http

Nmap done: 1 IP address (1 host up) scanned in 0.10 seconds
{% endhighlight %}

Or you can look on the cache.log file you have been created before.

{% highlight bash %}
$ sudo tail -f /var/log/squid/cache.log

2010/12/02 23:06:13| 0 Objects expired.
2010/12/02 23:06:13| 0 Objects cancelled.
2010/12/02 23:06:13| 0 Duplicate URLs purged.
2010/12/02 23:06:13| 0 Swapfile clashes avoided.
2010/12/02 23:06:13| Took 0.4 seconds (75149.7 objects/sec).
2010/12/02 23:06:13| Beginning Validation Procedure
2010/12/02 23:06:13| Completed Validation Procedure
2010/12/02 23:06:13| Validated 26825 Entries
2010/12/02 23:06:13| store_swap_size = 1327892k
2010/12/02 23:06:14| storeLateRelease: released 0 objects[/sourcecode]
{% endhighlight %}

If the results is same as the following example, the Squid Proxy ready to serve.

Add the following commands in order to run Squid whenever the Linux machine
reboot. Edit file /etc/rc.d/rc.local.

{% highlight bash %}
# run squid cache daemon
ulimit -HSn 16384
squid &
{% endhighlight %}
