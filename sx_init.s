/*
 * i960SxChipset
 * Copyright (c) 2020-2021, Joshua Scoggins
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


# NOTE: this code is taken from the initialization code found in the i960Sx manual

/**
 * Below is the system initialization code and tables.
 * The code builds the PRCB (PRocessor Control Block) in memory, sets up the stack frame, the interrupt,
 * fault, and system procedure tables, and then vectors to a user defined routine. *main*
 */

# declare ahead of time

.global system_address_table
.global prcb_ptr
.global start_ip
.global cs1

# Core Initialization Block (located at address 0)
# 8 words

.text

system_address_table:
    .word system_address_table # SAT pointer
    .word prcb_ptr # prcb pointer
    .word 0
    .word start_ip # pointer to first ip
    .word cs1 # calculated at link time (bind ?cs1 (- (+ ?SAT ?PRCB ?startIP)))
    .word 0
    .word 0
    .word -1

    # now reserve 88 more bytes
    .space 88

    .word sys_proc_table        # initialization words
    .word 0x304000fb
    .space 8

    .word system_address_table
    .word 0x00fc00fb            # initialization words
    .space 8

    .word sys_proc_table
    .word 0x304000fb            # initialization words
    .space 8

    .word fault_proc_table
    .word 0x304000fb            # initialization words


# phony prcb

prcb_ptr:
    .word 0x0 # 0 - reserved
    .word 0xc # 4 - initialize to 0xc
    .word 0x0 # 8 - reserved
    .word 0x0 # 12 - reserved
    .word 0x0 # 16 - reserved
    .word 0x0 # 20 - interrupt table address
    .word 0x0 # 24 - interrupt stack pointer
    .word 0x0 # 28 - reserved
    .word 0x000001ff  # 32 - pointer to offset zero
    .word 0x0000027f  # 36 - system procedure table pointer
    .word 0 # 40 - fault table
    .word 0x0 # 44 - reserved
    .space 32 # 48 - reserved
    .space 92 # 80 - scratch space

# the system procedure table will _only_ be used if the user make a supervisor procedure call
    .align 6

.global sys_proc_table
sys_proc_table:
    .word 0 # Reserved
    .word 0 # Reserved
    .word 0 # Reserved
    .word (0x0 + 0x1) # Supervisor stack pointer
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
# up to 260 entries!
    # example entry
	#.word	(_console_io + 0x2)	# Calls 0 - console I/O routines
	.word	0 	# Calls 0 - ??
	.word	0 	# Calls 1 - ??
	.word	0 # Calls 2 - ??
    .word   0 # Calls 3 - ??
	.word   0 # Calls 4 - ??
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
	.word   0 
# up to a total of 260 entries

# below is the fault table for calls to the fault handler.
# this table is provided because the above table (supervisor table) will allow
# tracing of trace-fault events (creating an endless loop), whereas this table will
# not allow tracing of trace-fault events.

    .align 6
fault_proc_table:
    .word 0 # Reserved
    .word 0 # Reserved
    .word 0 # Reserved
    .word 0 # Supervisor stack pointer
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word 0 # Preserved
    .word (_user_reserved_core + 0x2)    # entry 0
    .word (_user_trace_core + 0x2)    # entry 1
    .word (_user_operation_core + 0x2)    # entry 2
    .word (_user_arithmetic_core + 0x2)    # entry 3
    .word (_user_real_arithmetic_core + 0x2)    # entry 4
    .word (_user_constraint_core + 0x2)    # entry 5
    .word (_user_protection_core + 0x2)    # entry 6
    .word (_user_machine_core + 0x2)    # entry 7
    .word (_user_type_core + 0x2)    # entry 8
.global configuration_space__sdcard_file_begin_addr
.global configuration_space__sdcard_ctl_addr
 # processor starts execution at this spot upon power-up after self-test.
 start_ip:
	# g0 - sdctl base address
 	# g1 - sd file 0 base address
 	# g2 - file path base address
 	# g3 - count
 	# g4 - temporary / open port base address
	# g5 - zero temporary
	# g6 - computation offset
 	# g7 - end address
 	lda configuration_space__sdcard_ctl_addr, g0		# get the address in config space for sdcard ctl
	ld 0(g0), g0											# overwrite the contents of the register
	lda configuration_space__sdcard_file_begin_addr, g1 # get the base address of each file
	ld 0(g1), g1											# load the specific address
	ldconst file_path, g2
	ldconst 0, g3
	ldconst 0, g5
	# get the path to load from the sd card
load_the_path:
	ldob (g2)[g3*1], g4 # load a byte from the file_path
	stob g4, (g0)[g3*1] # store that byte to path + offset
	addi g3, 1, g3     # increment g3 by 1
	cmpibne g4, g5, load_the_path # keep walking until you hit zero and stop
open_the_file:
	ldconst 0xFFFF, g3 # we want to mark it as readonly as true
	stos g5, 106(g0) # clear out permissions
	stos g5, 108(g0) # not write only
	stos g3, 110(g0) # mark readonly
	stos g5, 112(g0) # not read & write
	stos g5, 114(g0) # do not create if missing
	stos g5, 116(g0) # do not truncate
	ldos 80(g0), g5 # get handle to sd card by reading from target port (g5)
	cmpo g5, g3
	bne successful_load
	b print_no_boot_sys_message # this will just halt

successful_load:
	# so we have a successful open file at this point
	# lets compute the proper offset
	ldconst 0x100, g3
	muli g5, g3, g6  # compute the offset
	addi g6, g1, g1  # overwrite the file base
	ldconst 0, g3    # get the count
	lda sxlibos_program_space_start, g6
	ld 20(g1), g7 	 # get the size of the file
	addo g6, g7, g7  # add the base address and size together to make the end address
					 # we want to do this so that we can test out different aspects of the design
copy_file_contents_into_ram:
	# we have to copy the contents of the file byte by byte into memory starting at sxlibos_program_space_start
	ldos 0(g1), g4 # load the contents of the ioport into a register
	stob g4, 0(g6) # store the lower half into memory regardless of contents
	addi g6, 1, g6 # advance the address
	cmpibge g6, g7, copy_file_contents_into_ram
close_the_file:
	ldconst 1, g3 # load one
	stos g3, 30(g1) # close the file
done_with_bootstrap:
 /*
  * -- At this point, sxlibos has been copied into memory, 
  * -- The IAC message, found in the 4 words located at the beginning of the
  *    copied program is used to make sure that 
  *    to the current System Address Table, the new RAM based PRCB, and to the Instruction Pointer
  *    labeled start_again_ip
 */
    lda 0xff000010, g5
    lda sxlibos_iac_reboot_message_start, g6
    synmovq g5, g6

print_no_boot_sys_message:
	ldconst no_boot_sys_message, r3
	bal print_message
	bal halt_system

print_message:
	# broke ass calling conventions
	# r3 - pointer to message
	# r4 - serial console address (derived internally)
	# r5 - terminator compare
	# r6 - temporary
	lda configuration_space__serial0_base, r4
	ld 0(r4), r4
	ldconst 0, r5
print_message_loop:
	ldob 0(r3), r6 # load the byte
	stob r6, 0(r4) # transfer it to the output port
	addi r3, 1, r3 # increment r3
	cmpibne r5, r6, print_message_loop
	bx (g14)
halt_system:
	ldconst 0, g14
	b halt_system

file_path:
	.asciz "boot.sys"
no_boot_sys_message:
	.asciz "no boot.sys!\n"
	
# stub all fault handlers
_user_trace_core:
_user_operation_core:
_user_arithmetic_core:
_user_real_arithmetic_core:
_user_constraint_core:
_user_protection_core:
_user_machine_core:
_user_type_core:
_user_reserved_core:
	flushreg
	ret
