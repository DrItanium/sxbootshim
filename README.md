sxbootshim is a tiny program meant to load boot.sys from the onboard sdcard and
transfer it into main memory. This is a proof of concept that does work quite
nicely. However, it is extremely slow! 

This shim is a tiny bootstrapping program which exists in the first 1k of
system memory. It copies the contents of sxlibos.rom from sd card into the
memory following this first 1k. The processor is then sent an IAC message to
restart with the first 16 bytes of the sxlibos.rom image containing the
contents of the reset IAC message. This allows for maximum flexibility. 

The tables defined in this shim are bogus and only meant to get the system
booted. If one is bringing up a new i960 based system then this shim could be
modified as a test program to make sure that checksums are passing as are other
simple features. 

NOTE that the interrupt tables are not defined in here! You must handle them
separately

