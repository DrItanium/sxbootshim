/* GROUP(-lgcc -lm -lc -liberty -lc ) */ /* libraries to link in */


MEMORY 
{
	/**
	 * To make this as small as possible we don't even have access to ram at
	 * this point. If it is necessary then I'll figure that out at that point
	 * in time
	 */
	rom (rx)  : ORIGIN = 0, l = 1k
}

/* Layout the different ELF sections into memory using the above described
 * memory spaces */ 
SECTIONS
{
	/* this is the text section */ 
	.text : 
	{ 
		*(.text) 	/* place the actual contents of the text section here */ 
	} >rom 
}

/* 
 * The goal of this shim is to just setup the minimum necessary to boot,
 * transfer the operating system to a fixed location in memory. The tables have
 * fixed addresses as well. 
 */
cs1 = -(system_address_table + prcb_ptr + start_ip) ; 
configuration_space_base = 0xFE000000 ;
configuration_space_page0 = configuration_space_base + 0x00 ;
configuration_space__serial0_base = configuration_space_page0 + 0;
configuration_space__sdcard_ctl_addr = configuration_space_page0 + 4;
configuration_space__sdcard_file_begin_addr = configuration_space_page0 + 8;

/*
 *
 * Using hitagimon as a base, I am going to denote fixed addresses for the
 * important processor structures. These are aligned correctly within the
 * program itself so it should all work out
 */
sxlibos_space_start = 0x400;
sxlibos_iac_reboot_message_start = sxlibos_space_start;
sxlibos_program_space_start = sxlibos_space_start + 16;
sxlibos_program_space_end = sxlibos_space_start + 0x40000;
