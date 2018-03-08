---
layout: post
title: "Check Hardware Specification in Ubuntu"
date: 2014-12-04 15:30:42 +0700
comments: true
categories: linux ubuntu
---
The following are some commands in Ubuntu which can be use to get information
about the operating system and the hardware. It is a kind of "show" command in
Cisco IOS or "dxdiag" in Windows.

*Show Ubuntu version/release information.*
{% highlight bash %} 
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04 LTS
Release:	16.04
Codename:	xenial
{% endhighlight %}

*Show CPU information.*
{% highlight bash %} 
$ less /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 42
model name      : Intel(R) Core(TM) i5-2410M CPU @ 2.30GHz
stepping        : 7
microcode       : 0x29
cpu MHz         : 1586.163
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm epb tpr_shadow vnmi flexpriority ept vpid xsaveopt dtherm ida arat pln pts
bugs            :
bogomips        : 4589.51
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

— output omitted —
{% endhighlight %}

*Show memory information*
{% highlight bash %} 
$ free -m
              total        used        free      shared  buff/cache   available
Mem:           3862        1104        1433         259        1324        2229
Swap:          1199          44        1155
{% endhighlight %}
*) in megabytes

*Show information about motherboard*
{% highlight bash %} 
$ sudo dmidecode | less
# dmidecode 3.0
Getting SMBIOS data from sysfs.
SMBIOS 2.6 present.
59 structures occupying 2229 bytes.
Table at 0xBAE89000.

Handle 0x0000, DMI type 4, 42 bytes
Processor Information
        Socket Designation: CPU
        Type: Central Processor
        Family: Core i5
        Manufacturer: Intel(R) Corporation
        ID: A7 06 02 00 FF FB EB BF
        Signature: Type 0, Family 6, Model 42, Stepping 7
        Flags:
                FPU (Floating-point unit on-chip)
                VME (Virtual mode extension)
                DE (Debugging extension)
                PSE (Page size extension)
                TSC (Time stamp counter)
                MSR (Model specific registers)
                PAE (Physical address extension)
                MCE (Machine check exception)
                CX8 (CMPXCHG8 instruction supported)
                APIC (On-chip APIC hardware supported)
                SEP (Fast system call)
                MTRR (Memory type range registers)
                PGE (Page global enable)
                MCA (Machine check architecture)
                CMOV (Conditional move instruction supported)
                PAT (Page attribute table)
                PSE-36 (36-bit page size extension)
                CLFSH (CLFLUSH instruction supported)
                DS (Debug store)
                ACPI (ACPI supported)
                MMX (MMX technology supported)
                FXSR (FXSAVE and FXSTOR instructions supported)
                SSE (Streaming SIMD extensions)
                SSE2 (Streaming SIMD extensions 2)
                SS (Self-snoop)
                HTT (Multi-threading)
                TM (Thermal monitor supported)
                PBE (Pending break enabled)
        Version: Intel(R) Core(TM) i5-2410M CPU @ 2.30GHz
        Voltage: 1.2 V
        External Clock: 100 MHz
        Max Speed: 2300 MHz
        Current Speed: 2300 MHz
        Status: Populated, Enabled
        Upgrade: ZIF Socket
        L1 Cache Handle: 0x0001
        L2 Cache Handle: 0x0002
        L3 Cache Handle: 0x0003
        Serial Number: Not Supported by CPU
        Asset Tag: None
        Part Number: None
        Core Count: 2
        Core Enabled: 2
        Thread Count: 4
        Characteristics:
                64-bit capable

Handle 0x0001, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L1-Cache
        Configuration: Enabled, Not Socketed, Level 1
        Operational Mode: Write Through
        Location: Internal
        Installed Size: 64 kB
        Maximum Size: 64 kB
        Supported SRAM Types:
                Synchronous
        Installed SRAM Type: Synchronous
        Speed: Unknown
        Error Correction Type: Single-bit ECC
        System Type: Data
        Associativity: 8-way Set-associative

Handle 0x0002, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L2-Cache
        Configuration: Enabled, Not Socketed, Level 2
        Operational Mode: Write Through
        Location: Internal
        Installed Size: 256 kB
        Maximum Size: 256 kB
        Supported SRAM Types:
                Synchronous
        Installed SRAM Type: Synchronous
        Speed: Unknown
        Error Correction Type: Single-bit ECC
        System Type: Data
        Associativity: 8-way Set-associative

— output omitted —
{% endhighlight %}

*Show Harddisk Information*
{% highlight bash %} 
$ sudo lshw -class disk
  *-disk                  
       description: ATA Disk
       product: HITACHI HTS72323
       vendor: Hitachi
       physical id: 0.0.0
       bus info: scsi@0:0.0.0
       logical name: /dev/sda
       version: B70B
       serial: E3834263GB50GD
       size: 298GiB (320GB)
       capabilities: partitioned partitioned:dos
       configuration: ansiversion=5 logicalsectorsize=512 sectorsize=512 signature=ba6ded71
  *-cdrom
       description: DVD-RAM writer
       product: DVDRAM GS30N
       vendor: HL-DT-ST
       physical id: 0.0.0
       bus info: scsi@2:0.0.0
       logical name: /dev/cdrom
       logical name: /dev/cdrw
       logical name: /dev/dvd
       logical name: /dev/dvdrw
       logical name: /dev/sr0
       version: VX20
       capabilities: removable audio cd-r cd-rw dvd dvd-r dvd-ram
       configuration: ansiversion=5 status=open
{% endhighlight %}

More information about particular harddisk:

{% highlight bash %} 
$ sudo fdisk -l /dev/sda
Disk /dev/sda: 298.1 GiB, 320072933376 bytes, 625142448 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xba6ded71

Device     Boot     Start       End   Sectors   Size Id Type
/dev/sda1        63662080 207192063 143529984  68.5G  7 HPFS/NTFS/exFAT
/dev/sda2  *      2459648  63662079  61202432  29.2G 83 Linux
/dev/sda3            2048   2459647   2457600   1.2G 82 Linux swap / Solaris
/dev/sda4       207270691 625142447 417871757 199.3G  f W95 Ext'd (LBA)
/dev/sda5       207270693 625141759 417871067 199.3G  7 HPFS/NTFS/exFAT

Partition table entries are not in disk order.
{% endhighlight %}
