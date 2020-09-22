---
layout: post
title: "Linux Kernel Mentoring Project"
date: 2019-12-23 11:17:00 +0700
comments: true
categories: open-source programming collaboration linux-kernel
---

The year of 2019 will come to its end, and not even once post I create for this
blog along this period. So I decided to create at least one article to summarize
what makes my interest most. Lately, I do not contribute to Open Source
intensively because I moved for a new job, and I must focus on that first.
In the spare time of my research on the Open Source project, I found an
interesting program that shares the same spirit as GSoC Project [0]. I found it
on twitter,   through a tweet from The Linux Foundation official account [1].
The program is called Linux Kernel Mentoring Project.

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

### Story from Successful Mentees

The best resource to learn before applying a project like this by looking from
previous successful mentees. I take a look from successful mentees from the
early time of the project being held 2019 Summer period, Kelsey Skunberg and
Barath Vedartham.
The first mentee, Kelsey Skunberg chose to work on PCI Utilities and Linux PCI
with Bjorn Helgaas as her mentor. Her project has consisted of multiple tasks
that helped clean up code, and enhance existing PCI features. She enhanced lspci
so it can decode AIDA64 log files and decode early dump output which the work
has started by Bjorn Helgaas. She restructured and improved lspci and Linux PCI
code by finding and removing unused code (functions, API), moving functions to
better locations, and improved logic to improve the maintainability of Linux PCI
code paths.  From the mentorship program, she gets the opportunity to attend
Open Source  Summit 2019 in San Diego, where She has been able to learn,
network, and work on her public speaking.
Second, Barath Verdartham took the project titled "Predictive Memory
Reclamation" during the Linux Kernel Mentorship program. He got the opportunity
to work on the core kernel, and I began working with his mentor Khalid Aziz
where gave him a task regarding the identification of anonymous memory regions
for a process.  he worked to develop a predictive memory reclamation algorithm
in the Linux Kernel. The aim of the project was to reduce the amount of time the
Linux kernel spends in reclaiming memory to satisfy processes requests for
memory when there is memory pressure, i.e not enough to satisfy the memory
allocation of a process. He implemented a predictive algorithm that can forecast
memory pressure and proactively reclaim memory to ensure there is enough
available for processes. From his works, he achieved a reduction of up to 8% in
the amount of time the kernel spends in reclaiming memory. He also worked with
John Hubbard on his project to track get_user_pages(). He converted a couple of
drivers to use the new get_user_pages API as proposed by John.

### My Effort

* Participate in stable kernel release circle
  I've tests several stable kernel while they are available. From there, I know
how to compile the kernel and check whether any errors occurred. I report back
to the mailing list when my testing succeeds.
* Sending patch: documentation conversion
  I've sent one patch to Linux Kernel mentees mailing list of documentation
conversion. The job is to convert two documentation in txt to ReST format. This
is a relatively easy task, but I was quite late to send the patch, so there is
already a patch sents.

### Conclusion

The Linux Kernel Mentorship Program is a good program from aspiring Linux Kernel
developer to get their hands dirty for real-world experiences. Some benefits as
mentees such as get lesson learned from experienced Linux Kernel
developers/maintainers; have some experience to collaborate, communicate, and
work with the Linux Kernel community and opportunity to network with other open
source communities and prospective employers which are invaluable prizes.

Reference(s):  
[0] [https://www.didiksetiawan.com/blog/2018/03/07/gsoc-with-gnu-wget2-part-i/](https://www.didiksetiawan.com/blog/2018/03/07/gsoc-with-gnu-wget2-part-i/)  
[1] [https://twitter.com/linuxfoundation/status/1141012722794020865](https://twitter.com/linuxfoundation/status/1141012722794020865)
