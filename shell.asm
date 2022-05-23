[BITS 16]
[ORG 0x0200]

%define FS_SEGMENT 0x8000
%define FS_OFFSET  0x0000

ShellMain:
	
	ShellWait:
	
	cmp ax, 0x1234
	je Command_Not_Found
	
	call PrintNewLine
	
	mov al, ">"
	mov ah, 0x0E
	int 0x10
	
	mov al, ' '
	int 0x10
	
	lea di, [Comando]
	
	mov ax, 0x8000
	mov es, ax
	
	mov di, 0x1000
	
	call get_string ; mette la stringa in 0x8000:0x1000 per renderla raggiungibile dallo scanner
	
	mov ax, 0x8000
	mov ds, ax
	
	mov di, 0
	
	call PrintNewLine
	
	
	jmp StartScanner
	
	jmp ShellWait
	
	Command_Not_Found:
		mov ax, 0
		lea bx, [ComandoNonTrovato]
		call PrintString
		jmp ShellWait
	
	cli 
	hlt
	
	jmp $

StartScanner:
	mov ax, 0x8000
	mov ds, ax

	jmp 0x8000:0x0400


%include "kernel/io/print_string.asm"
%include "kernel/io/print_hex_byte.asm"
%include "kernel/io/print_newline.asm"
%include "kernel/io/get_string.asm"
%include "kernel/string/strcmp.asm"

Comando: times 9 db 0
HaltMsg: db " *** SYSTEM HALTED", 0
ComandoNonTrovato: db "Command not found", 13, 10, 0


	
