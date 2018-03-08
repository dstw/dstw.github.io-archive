---
layout: post
title: "Vim Quick Reference"
date: 2016-06-02 20:23:38 +0700
comments: true
categories: text_editor vim
---
For unfimiliar user, vim is a little bit confusing at first. But,
after you try it several times and configure properly, you will found this text
editor is very powerful.  
Here I will note several subject how to use vim, because sometimes navigate to
vim help is quite difficult.

Vim is modal editor which means you use different mode to edit text. Some
important mode you will use very often are:

* Normal Mode

You can enter any command using <code>:</code> or search using <code>/</code>
and <code>?</code>. Press <code>Esc</code> to enter this mode.

* Insert Mode

Text you type is inserted into the buffer. Press <code>i</code> to enter this
mode.

* Visual Mode

In this mode, you can select the text we want in order to copy, cut or delete.
Press <code>v</code> to enter this mode. The cursor position will be starting
point to your selection.  

### Navigation

You can move through the buffer with the following key:

Move left <code>h</code>   
Move right <code>l</code>   
Move up <code>k</code>   
Move down <code>j</code>   

Using this key will make your navigation faster than using arrow keys or mouse.

Move one word <code>w</code>  
Move one word backwards <code>b</code>  
Move to end of line <code>$</code>  
Move to beginning of line <code>0</code>  
Insert text <code>i</code>  
Insert text at the end of line <code>A</code>  
Insert text at the beginning of line <code>I</code>  
Insert text above line <code>O</code>  
Insert text below line <code>o</code>  
Replace one character <code>r</code>  
Replace character consecutively <code>R</code> (enter "replace mode")

Page navigation:

Move page down <code>ctrl + f</code>  
Move page up <code>ctrl + b</code>  
Move page half down <code>ctrl + d</code>  
Move page half up <code>ctrl + u</code>  
Move top <code>gg</code>  
Move bottom <code>G</code>  

Navigate through command history <code>q:</code>
Navigate through search history <code>q/</code>
Then you can select command or search result with navigation key. To execute
command, press <code>Enter</code>.

### Open and Save File

Open file <code>:e filename</code>  
Save file <code>:w</code>  
Saveas file <code>:w filename</code>  
Quit <code>:q</code>  
Quit without save<code>:q!</code>  
Save file and quit<code>:wq</code>  

### Undo and Redo

Undo <code>u</code>  
Redo <code>ctrl + r</code>  

### Visual Selection

Use <code>v</code> on text you want to select. You will enter visual mode.
Navigate using <code>hjkl</code> key. Then we can do other action such as copy,
cut or delete.

### Copy and Paste Text

After you select a text, you can do following action:

Copy <code>y</code>  
Cut/Delete <code>d</code> or <code>x</code>  
Copy entire line <code>yy</code>  
Cut entire line <code>dd</code>  
Paste <code>p</code>  

### Search and Replace Text

Find text <code>/query</code>  
Find text upwards <code>?query</code>  
Navigate between search results <code>n</code> to move forward and
<code>N</code> to move backwards   

Find text using visually selected text, firstly add this line to vimrc file

	vnoremap // y/<C-R>"<CR>

then select text in visual mode and press <code>//</code>  

Replace text <code>:%s/old/new/g</code>  
Replace all <code>:%s/old/new/gc</code>  

### Word Completion

You can autocomplete text with several method to get different result:

Search text before cursor <code>ctrl + p</code>  
Search text after cursor <code>ctrl + n</code>  
Search for filename complete with its path <code>ctrl + x</code>
<code>ctrl + f</code>  

### Multi Window Editing

Open new window <code>:new</code>  
Open new vertical window <code>:vnew</code>  
Move through window <code>ctrl + w</code><code>w</code>  
Swap window position <code>ctrl + w</code><code>r</code>  

### Compare Buffer

If you have two split windows containing buffers that you want to compare, then
you can diff them by running <code>:windo diffthis</code>  
You can turn diff mode off just as easily, by running <code>:windo diffoff
</code>

That's how I use vim in daily life.
For my personal preference, I have modified my vimrc which you can find 
[here](/blog/2016/06/03/my-vim-configuration).
Thanks for reading.
