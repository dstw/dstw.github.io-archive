---
layout: post
title: "Insert USB Module in Linux Kernel"
date: 2016-05-03 21:13:21 +0700
comments: true
categories: linux kernel 
---
After I re-compile my kernel using a vanilla one, I found that my usb flashdrive 
can not be detected by my operating system. I check on dmesg, there are entry
about my usb flashdrive on the log:

{% highlight bash %}
didik@thinkpad:~$ dmesg
--- output omitted ---
[  123.616624] usb 1-1.2: new high-speed USB device number 3 using ehci-pci
[  123.710606] usb 1-1.2: New USB device found, idVendor=0951, idProduct=1666
[  123.710617] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  123.710631] usb 1-1.2: Product: DataTraveler 3.0
[  123.710634] usb 1-1.2: Manufacturer: Kingston
[  123.710637] usb 1-1.2: SerialNumber: 60A44C3FACDBBDB1796E36C9
--- output omitted ---
{% endhighlight %}

But, after a moment I wait, there is no notification about new flashdrive
inserted. I check using blkid, still there is no sign of the thing.

{% highlight bash %}
didik@thinkpad:~$ sudo blkid
[sudo] password for didik: 
/dev/sda1: LABEL="SYSTEM" UUID="70E80099E8005FA8" TYPE="ntfs" PARTUUID="ba6ded71-01"
/dev/sda2: UUID="92521783-0211-4b1d-8f66-b9a62c16fc89" UUID_SUB="fdb1cb3e-1a44-4e53-864e-b29f6fdfb153" TYPE="btrfs" PARTUUID="ba6ded71-02"
/dev/sda3: UUID="4723c4f7-9624-4b8d-9b41-3079442641b4" TYPE="swap" PARTUUID="ba6ded71-03"
/dev/sda5: LABEL="DATA" UUID="01CD0094E26EBB80" TYPE="ntfs" PARTUUID="ba6ded71-05"
{% endhighlight %}

Apparently, I forget to insert usb-storage module in my kernel, after I
recompile it. So, I try to modprobe the needed module.

{% highlight bash %}
didik@thinkpad:~$ modprobe usb-storage
modprobe: FATAL: Module usb-storage not found in directory /lib/modules/4.6.2
{% endhighlight %}

Okay, it seems that the file I need is not available from the kernel tree. So, I
need to insert the module manually.  
Time to go to kernel tree.

{% highlight bash %}
didik@thinkpad:~$ cd linux-4.6.2/
didik@thinkpad:~/linux-4.6.2$ make menuconfig
{% endhighlight %}

From this menu, I will include the module that I need for usb-storage. Press /
to search module name. It is called USB_STORAGE.

![usb-module0.png](/images/usb-module0.png)

After I found its location, I insert it with "M" become my choice between the
tri-state mode. 

![usb-module1.png](/images/usb-module1.png)

I exit and save this configuration.  
Then I make it.

{% highlight bash %}
didik@thinkpad:~/linux-4.6.2$ make -j4
{% endhighlight %}

Note that the "4" value is changeable depends on processor specs.  
I use "4" because my processor 
Install old and new compiled module, as root of course.

{% highlight bash %}
didik@thinkpad:~/linux-4.6.2$ sudo make modules_install
{% endhighlight %}

My new module finally installed. Now I can plug the usb drive on my computer.  
Just in case you are curious about system message of the inserted device, you 
can use dmesg.

{% highlight bash %}
didik@thinkpad:~$ dmesg
--- output omitted ---
[ 3231.314581] usb 1-1.2: USB disconnect, device number 3
[ 3233.198257] usb 1-1.2: new high-speed USB device number 4 using ehci-pci
[ 3233.292379] usb 1-1.2: New USB device found, idVendor=0951, idProduct=1666
[ 3233.292390] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 3233.292395] usb 1-1.2: Product: DataTraveler 3.0
[ 3233.292399] usb 1-1.2: Manufacturer: Kingston
[ 3233.292403] usb 1-1.2: SerialNumber: 60A44C3FACDBBDB1796E36C9
[ 3233.990697] usb-storage 1-1.2:1.0: USB Mass Storage device detected
[ 3233.990994] scsi host6: usb-storage 1-1.2:1.0
[ 3233.991196] usbcore: registered new interface driver usb-storage
[ 3234.995392] scsi 6:0:0:0: Direct-Access     Kingston DataTraveler 3.0 PMAP PQ: 0 ANSI: 6
[ 3234.996242] sd 6:0:0:0: Attached scsi generic sg2 type 0
[ 3234.996655] sd 6:0:0:0: [sdb] 31293440 512-byte logical blocks: (16.0 GB/14.9 GiB)
[ 3234.998693] sd 6:0:0:0: [sdb] Write Protect is off
[ 3234.998705] sd 6:0:0:0: [sdb] Mode Sense: 2b 80 00 08
[ 3235.000537] sd 6:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 3236.101997]  sdb: sdb1
[ 3236.108153] sd 6:0:0:0: [sdb] Attached SCSI removable disk
--- output omitted ---
{% endhighlight %}

And modinfo to view module details.

{% highlight bash %}
didik@thinkpad:~$ modinfo usb-storage
filename:       /lib/modules/4.6.2/kernel/drivers/usb/storage/usb-storage.ko
license:        GPL
description:    USB Mass Storage driver for Linux
author:         Matthew Dharm <mdharm-usb@one-eyed-alien.net>
srcversion:     D0235102D9160CC35A9A1C4
alias:          usb:v*p*d*dc*dsc*dp*ic08isc06ip50in*
alias:          usb:v*p*d*dc*dsc*dp*ic08isc05ip50in*
--- output omitted ---
alias:          usb:v03EEp6906d0003dc*dsc*dp*ic*isc*ip*in*
alias:          usb:v03EBp2002d0100dc*dsc*dp*ic*isc*ip*in*
depends:        
intree:         Y
vermagic:       4.6.2 SMP mod_unload modversions 
parm:           option_zero_cd:ZeroCD mode (1=Force Modem (default), 2=Allow CD-Rom (uint)
parm:           swi_tru_install:TRU-Install mode (1=Full Logic (def), 2=Force CD-Rom, 3=Force Modem) (uint)
parm:           delay_use:seconds to delay before using a new device (uint)
parm:           quirks:supplemental list of device IDs and their quirks (string)
{% endhighlight %}

Until next time.
