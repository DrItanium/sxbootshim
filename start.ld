GROUP(-lgcc -lm -lc -liberty -lc ) /* libraries to link in */

MEMORY 
{
	/**
	 * This is evolving from a bootshim into a tiny library operating system.
	 * Thus we provide 256k of program code and 768k of ram.
	 */
	rom (rx)  : ORIGIN = 0, l = 256k
	/**
	 * We should allocate a small amount of stack to be on the safe side.
	 * With this design, it is possible to use a special on board sram chip
	 * or something like that for this purpose.
	 */ 
	ram (!rx) : o = 0x00020000, l = 768K
} 

/* Layout the different ELF sections into memory using the above described
 * memory spaces */ 
SECTIONS
{
	/* this is the text section */ 
	.text : 
	{ 
		CREATE_OBJECT_SYMBOLS /* C++ needs this */ 

		*(.text) 	/* place the actual contents of the text section here */ 

		_etext = .; /* define a symbol named _etext and assign it to the
					   address following the end of the text section data */ 

		___CTOR_LIST__ = .; /* put a symbol __CTOR_LIST__ at this point */ 

		LONG((___CTOR_END__ - ___CTOR_LIST__) / 4 - 2) /* reserve a block of
														  memory and save the
														  result of end minus
														  list start. This will
														  show up in the final
														  executable */ 

		*(.ctors)		/* Take the contents of the .ctors elf section and
						   place it here, this is how you can request custom
						   sections to placed in specific locations */ 

		LONG(0) /* allocate a long's worth of space (4 bytes in this case) and
				   assign it zero (padding) */ 

		___CTOR_END__ = .; /* define the symbol __CTOR_END__ to be the point
							  after the previous padding */ 


		/* do the same thing again but for the destructors section */ 
		___DTOR_LIST__ = .;  
		LONG((___DTOR_END__ - ___DTOR_LIST__) / 4 - 2) 
		*(.dtors) 
		LONG(0) 
		___DTOR_END__ = .; 

	} >rom 
	.bss : 
	{ 
		__bss_start__ = .; 
		*(.bss) 
		*(COMMON) /* can't find much documentation on this but it is a good idea to have this here */ 
		__bss_end__ = .; 
	} >ram 
	.data :
	{
		__data_start__ = .; 
		KEEP(*(.data)) 
		CONSTRUCTORS  /* we want to place the constructors data here */
		__data_end__ = .; 
		_edata = .; 
	} >ram 
	.heap : { 
		/* this section is synthetic, I do not actually copy the contents of the heap
		 * section over on boot, instead I just want the location of where it should
		 * start.In this case, the heap will start _after_ the .bss and .data sections
		 * in ram. It is placed linearly in order so there is no mystery to this. 
		 */
		__heap_start__ = .; 
		end = __heap_start__; 
		_end = end; 
		__end = end; 
		KEEP(*(.heap)) 
		__heap_end__ = .; 
		/* __HeapLimit = __heap_end__; */ 
	
	} >ram 
}

/* these two locations are _very_ important for getting the program to startup correctly
 * The first is the checksum value cs1. The second is where main will start
 * from when we jump to the program. We need to be careful with the second
 * location because it is a fixed address. In this case, it will be at address
 * 0x40000. The bootshim needs to not only contain the ipl but a place to stash
 * the basic library routines as well. 
 */


cs1 = -(system_address_table + prcb_ptr + start_ip) ; 
/* 
 * start the application itself at 1 megabyte. 
 * give the bootshim/os space to expand and work in.
 */
application_start = 0x100000 ;

/* Currently, I am manually decomposing the elf binary into ROM (.text) and DAT
 * (.data) files from the ELF using objcopy.  

 I have the chipset map the data section to 0x2000'0000 so we need to
 reflect that in the linker script (start_ip in the sx_init.s uses this). 

 I also compute the data section's length ahead of time to save instructions.  



 It is the responsibility of the i960 to copy the contents of the mapped data
 section into ram starting at address 0x8000'0000 on startup. Failure to do so
 leads to the inability to properly allocate memory (no malloc) and other
 various oddities. 



 The variable cs1 is specific to the i960 and is used in it's boot process.
 The processor on startup loads the first eight words (32 bytes) and performs
 a check sum with them. The processor will refuse to boot if the checksum
 algorithm does not yield a zero from combining these eight words together.
 Thus cs1 is used to make sure that 0 is the final result. The i960 SA/SB
 reference manual is where I got the cs1 line 



 The BSS Section length is used on startup to "copy" the bss into ram like the
 data section (although BSS copy happens first because it comes before data)..
 In reality this just zeroing out ram on the SDCard (ram.bin) to prevent bad
 things from happening during program execution 

 */ 



/*

How to dump the actual boot code: 


i960-elf-objcopy --only-section=.text -O binary hitagimon hitagimon.bin 


You have to make sure that you don't dump out the data section because that can
get very large! This is because, objcopy is turning the dynamic elf into a
statically mapped binary blob. Since ram starts at 0x8000'0000 the blob must
have ram mapped at that exact location for bss and data. Thus the blob becomes
over 2 gigabytes in size! This returns the baffling error "not enough space on
device" from i960-elf-objcopy.  

 */ 
