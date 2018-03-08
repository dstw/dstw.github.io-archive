---
layout: post
title: "Convert Text to Pdf on Linux"
date: 2016-09-02 20:23:38 +0700
comments: true
categories: linux documentation text
---
Background: failed to build linux kernel documentation (still too lazy to solve
problems).  
Goal: generate pdf files of linux documentation, because I have reading problem
when using text files. Text files look ugly when I open using my reader
(Android).

Install needed packages.

{% highlight bash %}
$ sudo apt-get install enscript ps2pdf
{% endhighlight %}

Do this simple tricks.

{% highlight bash %}
$ cd Documentation/
$ for i in `ls -p | grep -v /` ; do ; enscript -p$i.ps $i ; done
$ for i in `ls *.ps` ; do ; ps2pdf $i ; done
{% endhighlight %}

Now I have pdf files of all the text files.  
It still have a problem, it just convert files on the same directory. So other
files under this directory must be processed separately, which mean I must move
to each directory.
