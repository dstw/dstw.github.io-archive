---
layout: post
title: "My Vim Configuration"
date: 2016-06-03 15:08:57 +0700
comments: true
categories: text_editor vim
---
This is my Vim configuration a.k.a .vimrc. You can download the file from
[here](https://github.com/dstw/dotfiles/raw/master/.vimrc).
Feel free to use and customize.

Below are some description of its contents:

*Use vim settings instead of vi*
{% highlight vim %}
set nocompatible 
{% endhighlight %}

*No backup or swap*
{% highlight vim %}
set nobackup nowritebackup noswapfile autoread          
{% endhighlight %}

*Enable per-directory .vimrc files*
{% highlight vim %}
set exrc                                                
{% endhighlight %}

*Don't unload buffer when switching away*
{% highlight vim %}
set hidden                                              
{% endhighlight %}

*Allow per-file settings via modeline*
{% highlight vim %}
set modeline                                            
{% endhighlight %}

*Disable unsafe commands in local .vimrc files*
{% highlight vim %}
set secure                                              
{% endhighlight %}

*Saving and encoding*
{% highlight vim %}
set encoding=utf-8 fileencoding=utf-8 termencoding=utf-8
{% endhighlight %}

*Command completion*
{% highlight vim %}
set wildmenu                                            
{% endhighlight %}

*Allow backspacing over everything in insert mode*
{% highlight vim %}
set backspace=indent,eol,start                          
{% endhighlight %}

*Display status line which contains current mode, file name, file status,
ruler, etc.*
{% highlight vim %}
set laststatus=2                                        
{% endhighlight %}

*Always set autoindenting on*
{% highlight vim %}
set autoindent                                          
{% endhighlight %}

*Display incomplete commands*
{% highlight vim %}
set showcmd                                             
{% endhighlight %}

*Keep upto 50 lines of command line history*
{% highlight vim %}
set history=50                                          
{% endhighlight %}

*Show a vertical line at the 79th character*
{% highlight vim %}
set textwidth=80                                        
{% endhighlight %}

*Highlight column after 'textwidth'*
{% highlight vim %}
set colorcolumn=+1                                      
{% endhighlight %}

*Switch syntax highlighting on*
{% highlight vim %}
syntax on                                               
{% endhighlight %}

*Switch highlighting on the last used search pattern*
{% highlight vim %}
set hlsearch incsearch ignorecase smartcase             
{% endhighlight %}

*Don't hide the mouse cursor while typing*
{% highlight vim %}
set nomousehide                                         
{% endhighlight %}

*Right-click pops up contect menu*
{% highlight vim %}
set mousemodel=popup                                    
{% endhighlight %}

*Show cursor position in status bar*
{% highlight vim %}
set ruler                                               
{% endhighlight %}

*Show line numbers on left*
{% highlight vim %}
set number                                              
{% endhighlight %}

*Disable code folding*
{% highlight vim %}
set nofoldenable                                        
{% endhighlight %}

*Scroll the window so we can always see 10 lines around the cursor*
{% highlight vim %}
set scrolloff=10                                        
{% endhighlight %}

*Kernel coding style*
{% highlight vim %}
set tabstop=8                                           
set softtabstop=8                                       
set shiftwidth=8                                        
set noexpandtab                                         
{% endhighlight %}

*Enable file type detection*
{% highlight vim %}
filetype plugin indent on                               
{% endhighlight %}

*Shortcut to search visually selected text*
{% highlight vim %}
vnoremap // y/<C-R>"<CR>
{% endhighlight %}

*Check if running on gvim*
{% highlight vim %}
if has("gui_running")                                   
{% endhighlight %}

*Set terminal color to 256*
{% highlight vim %}
set t_Co=256                                          
{% endhighlight %}

*Check if using Windows*
{% highlight vim %}
if has("win32") || has("win16")                       
{% endhighlight %}

*Set Ubuntu Mono font with size 11*
{% highlight vim %}
set guifont=Ubuntu\ Mono:h11                        
{% endhighlight %}

*Use solarized colorscheme*
{% highlight vim %}
colorscheme solarized                                 
{% endhighlight %}

*Set the background to dark color*
{% highlight vim %}
set background=dark                                   
{% endhighlight %}

*Highlight the current line*
{% highlight vim %}
set cursorline                                        
{% endhighlight %}

*Use letter as the print output format*
{% highlight vim %}
set printoptions=paper:letter                         
{% endhighlight %}

I use Ubuntu font which can be download from
[font.ubuntu.com](http://font.ubuntu.com/).
To enable solarized colorscheme, download file solarized.vim from
https://github.com/altercation/vim-colors-solarized/.
If you want to look my personal vim configuration, you can find it
[here](https://github.com/dstw/dotfiles). 

I use this configuration in my Linux workstation and server.
I use exclusively for editing
linux kernel and other open source projects. For daily programming use, you can
change the value of tabstop, softtabstop and shiftwidth.  
Happy Vimming!
