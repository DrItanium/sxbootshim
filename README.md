sxbootshim is a tiny program meant to be installed into the flash of an
atmega1284p. It is supposed to provide the initial bootstrap of the system
which is responsible for opening boot.sys off of the sdcard and installing that
into memory. Ideally, the boot.sys.program would be completely unaware of 
the boot shim. It would just have a different base offset. 
