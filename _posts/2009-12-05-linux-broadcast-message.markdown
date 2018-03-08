---
layout: post
title: "Linux Broadcast Message"
date: 2009-12-05 20:23:38 +0700
comments: true
categories: linux terminal
---
Sometimes, as linux user (especially as command line user), we need to send
message to another user. The message will appear on user terminal. To do this,
all we need is root access and simple one liner.

{% highlight bash %}
$ echo "Hello buddy!" | sudo wall -n
{% endhighlight %}

And if we want to use a file text as message source, we just need to omit the
redirection pipe and point commands to file directly.

{% highlight bash %}
$ sudo wall -n message.txt
{% endhighlight %}
