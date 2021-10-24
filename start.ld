/* GROUP(-lgcc -lm -lc -liberty -lc ) */ /* libraries to link in */


MEMORY 
{
	/**
	 * To make this as small as possible we don't even have access to ram at
	 * this point. If it is necessary then I'll figure that out at that point
	 * in time
	 */
	rom (rx)  : ORIGIN = 0, l = 16k
}

/* Layout the different ELF sections into memory using the above described
 * memory spaces */ 
SECTIONS
{
	/* this is the text section */ 
	.text : 
	{ 

		*(.text) 	/* place the actual contents of the text section here */ 

		_etext = .; /* define a symbol named _etext and assign it to the
					   address following the end of the text section data */ 
	} >rom 
}

/* 
 * The goal of this shim is to just setup the minimum necessary to boot,
 * transfer the operating system to a fixed location in memory. The tables have
 * fixed addresses as well. 
 */
cs1 = -(system_address_table + prcb_ptr + start_ip) ; 
sxlibos_start = 0x4000 ;

