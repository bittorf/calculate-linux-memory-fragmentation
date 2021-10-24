calculate linux memory fragmentation
====================================

using a formula suggested in 2015   
by Mel Gorman and Patrick Healy in     
"Measuring the Impact of the Linux Memory Manager"   

example output
==============

```
user@host:$ cat /proc/buddyinfo 
Node 0, zone      DMA      0      0      0      1      2      1      1      0      1      1      3 
Node 0, zone    DMA32  27752  17929  10411   7229   4201   1321    670    220     40     10      0 
Node 0, zone   Normal  20299  14691   5434   1073    139     35      6      4      2      0      0 

user@host:$ show_frag.sh 
DMA=4%
DMA32=56%
Normal=77%

```

inspired by
===========

* Pintu Kumar - Linux_Memory_Fragmentation.pdf
* https://github.com/dsanders11/scripts/blob/master/Linux_Memory_Fragmentation.pdf
* https://raw.githubusercontent.com/dsanders11/scripts/master/fraglevelinfo.py
* https://savvinov.com/2019/10/14/memory-fragmentation-the-silent-performance-killer/

