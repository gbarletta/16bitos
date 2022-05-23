[BITS 16]
[ORG 0x0600]

Main:

	mov ax, 0xD000
	mov ss, ax
	mov sp, 0x0000

	mov bl, [0x0000]
	mov bh, [0x0001]
	mov cx, 0
	mov dx, 10
	
	List:
	
		
		cmp cx, bx
		jge ReturnToShell
		
		mov ax, cx
		;call PrintHex
		
		push cx
		
		mov cx, 10
		imul cx
		
		pop cx
		add ax, 2
		;call PrintHex
		
		push bx
		mov bx, ax
		call PrintString
		call PrintNewLine
		pop bx
		
		push cx
		mov dx, 0x1000
		

	
		pop cx
		inc cx
		jmp List
	
	
	
	jmp ReturnToShell
	jmp $

	
ReturnToShell:

	push ax
	
	mov ax, 0x8000
	mov ds, ax
	
	pop ax

	jmp 0x8000:0x0200
	
%include "kernel/io/print_string.asm"
%include "kernel/io/print_hex_byte.asm"
%include "kernel/io/print_newline.asm"

Comando: times 9 db 0
	
