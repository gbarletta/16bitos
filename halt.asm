[BITS 16]
[ORG 0x0600]

Main:

	lea bx, [Halting]
	call PrintString
	
	cli
	hlt
	
%include "kernel/io/print_string.asm"

Halting: db " ****** You can now shutdown the machine ****** ", 0
