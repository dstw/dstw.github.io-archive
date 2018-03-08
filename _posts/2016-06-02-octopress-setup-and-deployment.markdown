---
layout: post
title: "Octopress Setup and Deployment"
date: 2016-06-02 15:06:57 +0700
comments: true
categories: web blog
---
I will explain how to setup a new blog using octopress, deploy it on github and
contribute from other place. Let's check this out.

### First Time Setup

Prerequisite:

* Install Git and Node.js

On debian system, use apt-get.

{% highlight bash %}
$ sudo apt-get install git
$ sudo apt-get install nodejs
{% endhighlight %}

* Install Ruby

We must use version 1.9.3 or higher. To ensure we fulfill this requirement, I
prefer to install ruby from source. Download from
[Ruby official site](https://www.ruby-lang.org/en/downloads/). The installation
process is quite common.

{% highlight bash %}
$ tar zxf ruby-2.3.1.tar.gz 
$ cd ruby-2.3.1/
$ ./configure
$ sudo make && make install 
{% endhighlight %}

* Install ExecJS

To run JavaScript code from Ruby.

{% highlight bash %}
$ sudo gem install execjs
{% endhighlight %}

* Configure bundle

Another octopress dependency.

{% highlight bash %}
$ sudo gem install bundler
{% endhighlight %}

After all needed requirements fulfilled, then grab the octopress source code.

{% highlight bash %}
$ git clone git://github.com/imathis/octopress.git octopress
$ cd octopress
{% endhighlight %}

One more dependency:

{% highlight bash %}
$ bundle install
{% endhighlight %}

Then install octopress default theme.

{% highlight bash %}
$ rake install
{% endhighlight %}

Setup process is finished. We can now start to blog using rake newpost["title"], 
customize _config.yml, add some pages, customize 404 not found page, using
custom domain name and so on.  

### Deploy on Github

There are some way to deploy octopress, either using rsync or git. In this
post, I will explain how to deploy octopress on Github.
Create a new Github repository and name the repository with the format
username.github.io, where username is your GitHub username or organization name.

Github Pages for users and organizations uses the master branch like the public 
directory on a web server, serving up the files at your Pages url 
http://username.github.io. As a result, we will to work on the source for 
our blog in the source branch and commit the generated content to the master 
branch. Octopress has a configuration task that helps us set all this up.

{% highlight bash %}
$ rake setup_github_pages
{% endhighlight %}

The rake task will ask for a URL of the Github repo. Copy the SSH or HTTPS URL 
from our newly created repository
(e.g. git@github.com:username/username.github.io.git)
and paste it in as a response.

This will:

* Ask for and store our Github Pages repository url
* Rename the remote pointing to imathis/octopress from 'origin' to 'octopress'
* Add our Github Pages repository as the default origin remote
* Switch the active branch from master to source
* Configure our blog's url according to your repository
* Setup a master branch in the _deploy directory for deployment

Next run:

{% highlight bash %}
$ rake generate
$ rake deploy
{% endhighlight %}

This will generate our blog, copy the generated files into _deploy/, add them 
to git, commit and push them up to the master branch. 

Don't forget to commit the source of our blog.

{% highlight bash %}
$ git add .
$ git commit -m 'our message'
$ git push origin source
{% endhighlight %}

With new repositories, Github sets the default branch based on the branch we 
push first, and it looks there for the generated site content. If we're having 
trouble getting Github to publish our site, go to the admin panel for our 
repository and make sure that the master branch is the default branch.

### Contribute from Other Place

Sometimes we need to develop our octopress site in other place than we currently
in. To do that, we will use the benefit of git.  
First, we need to get our site copy:

{% highlight bash %}
$ git clone git@github.com:username/username.github.io.git
$ cd username.github.io
{% endhighlight %}

Switch to source branch
{% highlight bash %}
$ git checkout source
{% endhighlight %}

Then do all change on our source, after that run "rake generate" or "rake
preview" to compile our source onto public directory. Everything seems to be
okay until we need to upload to github. 

{% highlight bash %}
$ rake deploy
## Deploying branch to Github Pages 
## Pulling any updates from Github Pages 
cd _deploy
rake aborted!
Errno::ENOENT: No such file or directory @ dir_chdir - _deploy
/home/didik/octopress/Rakefile:255:in `block in <top (required)>'
/home/didik/octopress/Rakefile:227:in `block in <top (required)>'
Tasks: TOP => deploy
(See full trace by running task with --trace)
{% endhighlight %}

Oops, it's look like we miss something. We have to make a new _deploy directory 
and add git initialization to it.

{% highlight bash %}
$ mkdir _deploy
$ cd _deploy
$ git init
$ git remote add origin git@github.com:username/username.github.io.git
$ git pull origin master
$ cd ..
{% endhighlight %}

That's all. Now, we can upload using rake deploy as usual.  
Until next time.
