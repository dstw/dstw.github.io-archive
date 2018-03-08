---
layout: post
title: "Linux Passwordless Login"
date: 2015-02-26 20:23:38 +0700
comments: true
categories: linux ssh
---
Generate key on the client side:

{% highlight bash %}
$ ssh-keygen
{% endhighlight %}

That command will generate key with rsa encryption. To choose dsa encryption,
add parameter "-t dsa".

{% highlight bash %}
$ ssh-keygen -t dsa
{% endhighlight %}

Then, just click "Enter" if you are asked for passphrase. It is like you use an
empty passphrase.

Copy that generated public key to host side, computer which will be used for remote.

{% highlight bash %}
$ scp user@10.10.10.10:/home/didik/.ssh/id_dsa.pub .
$ cat id_dsa.pub >> .ssh/authorized_keys
{% endhighlight %}

That's all. Now you can login to client computer without worrying to be asked 
for a password. It is useful for deploying automatic scripts or programs.
