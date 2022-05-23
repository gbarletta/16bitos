[BITS 16]
[ORG 0x0600]

Main:

	call PrintNewLine
	
	lea bx, [HelpMsg]
	call PrintString
	
	call PrintNewLine
	
	lea bx, [HelpMsg1]
	call PrintString
	
	lea bx, [HelpMsg2]
	call PrintString
	
	lea bx, [HelpMsg3]
	call PrintString
	
	lea bx, [HelpMsg4]
	call PrintString
	
	push ax
	
	mov ax, 0x8000
	mov ds, ax
	
	pop ax

	jmp 0x8000:0x0200
	
	jmp $

%include "kernel/io/print_string.asm"	
%include "kernel/io/print_newline.asm"

HelpMsg: db "16shell --- commands", 13, 10, 0
HelpMsg1: db "help - show this help", 13, 10, 0
HelpMsg2: db "halt - halt the machine", 13, 10, 0
HelpMsg3: db "list - list all the files of the filesystem", 13, 10, 0
HelpMsg4: db "boot.bin - reboot the kernel", 13, 10, 0
