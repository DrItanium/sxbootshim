sxlibos is a tiny library "operating system" for the i960Sx hitagi
mainboard. It requires a megabyte of memory to hold it's program and ram. The
objective of this shim is to abstract the details about the platform from the
program in question. All of the code found in the hitagimon will be shoved in
to this new boot.sys. 

This image will be loaded off of the sdcard into ram by the microcontroller on
startup.
