---
layout: post
title: "Linux Kernel Mentoring Project"
date: 2019-12-23 11:17:00 +0700
comments: true
categories: open-source programming collaboration linux_kernel
---

The year of 2019 will come to its end, and not even once post I create for this
blog along this period. So I decide to create at least one article to summarize
what make my interest most. Lately, I do not contribute to Open Source
intensively because I moved for a new job, and I must focus on that first.  
In my spare time of my research on Open Source project, I found an interesting
program that share the same spirit as GSoC Project [0]. I found it on twitter,
through a tweet from The Linux Foundation official account [1]. The program is
called Linux Kernel Mentoring Project.

### Program Definitions

The Linux Kernel Mentorship Program offers a structured remote learning
opportunity to aspiring Linux Kernel developers. Experienced Linux Kernel
developers and maintainers mentor volunteer mentees and help them become
contributors to the Linux Kernel. This is a remote opportunity and there is no
need to relocate or move to participate.

### Purpose

The program serves as a vehicle to reach out to students and developers to
inject new talent into the Linux Kernel community. It aims to increase diversity
in the Linux Kernel community and work towards making the kernel more secure and
sustainable. They strongly encourage applicants who are from traditionally
underrepresented or marginalized groups in the technology and open source
communities, including, but not limited to: persons identifying as LGBTQ, women,
persons of color, and/or persons with disabilities. 

### Schedule

The Linux Kernel Mentorship Program includes three 12-week, full-time volunteer
mentee positions, and also two 24-week part-time volunteer mentee positions each
year. The full-time mentee positions are offered in the Spring, Summer, and
Fall. The part-time mentee position is offered in the Summer and Spring. The
mentee positions are designed to give program participants exposure to at least
two Kernel releases. The Kernel release cycle is 7-8 weeks. 

### My Effort

* Participate in kernel release circle
* Sending patch: documentation convertion

### Story from Successful Mentee

The best resource to learn before applying project like this is track back from
previous successful mentee. I take a look on one of successful mentee from the
2019 Summer period, Kelsey Skunberg.  
She chose to work on PCI Utilities and Linux PCI with Bjorn Helgaas as her
mentor. Her project has consisted of multiple tasks that helped clean up code,
and enhance existing PCI features.  
She enhanced lspci to:

* Decode AIDA64 log files (Started by Bjorn Helgaas)
* Decode earlydump output (Started by Bjorn Helgaas)

She restructured and improved lspci and Linux PCI code by:

* Finding and removing unused code (functions, API)
* Moving functions to better locations
* Improved logic to improve maintainability of Linux PCI code paths

* Fix checkpatch warning: Staging: sm750fb: Change \*array into \*const array
* Update verbose help and show_range()


### Conclusion

The Linux Kernel Mentorship Program is

Reference(s):  
[0] [https://www.didiksetiawan.com/blog/2018/03/07/gsoc-with-gnu-wget2-part-i/](https://www.didiksetiawan.com/blog/2018/03/07/gsoc-with-gnu-wget2-part-i/)  
[1] [https://twitter.com/linuxfoundation/status/1141012722794020865](https://twitter.com/linuxfoundation/status/1141012722794020865)
