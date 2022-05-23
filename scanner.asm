[BITS 16]
[ORG 0x0400]

Main:

	mov ax, 0xD000
	mov ss, ax
	mov sp, 0x0000

	mov bl, [0x0000]
	mov bh, [0x0001]
	mov cx, 0
	mov dx, 10
	
	Scanning:
	
		
		cmp cx, bx
		jge ReturnWithError ; Abbiamo esaminato tutti i file.
		
		mov ax, cx
		;call PrintHex
		
		push cx
		
		mov cx, 10
		imul cx
		
		pop cx
		add ax, 2
		;call PrintHex
		
		mov si, 0x1000
		mov di, ax
		
		push ax
		
		call strcmp
		cmp ax, 0
		;call PrintHex
		je CommandFound
		
		push cx
		mov dx, 0x1000
		

	
	pop cx
		pop ax
		inc cx
		jmp Scanning
	
	
	ReturnWithError:
		mov ax, 0x1234
		
	jmp ReturnToShell
	jmp $
	
CommandFound:
	pop ax
	add ax, 9
	
	;call PrintHex
	mov bx, ax
	
	jmp LoadProgram
	
	
	
ReturnToShell:

	push ax
	
	mov ax, 0x8000
	mov ds, ax
	
	pop ax

	jmp 0x8000:0x0200
	
LoadProgram:
	mov ah, 2 
    mov al, 1
    mov ch, 0 
    mov cl, [bx]  
    mov dh, 0   
    mov dl, 0   
    mov bx, 0x8000
    mov es, bx      
    mov bx, 0x0600
.readsector:
	int 0x13        
	jc .readsector

	mov ax, 0x8000
	mov ds, ax

	jmp 0x8000:0x0600
	
%include "kernel/io/print_string.asm"
%include "kernel/io/print_hex_byte.asm"
%include "kernel/io/print_newline.asm"
%include "kernel/string/strcmp.asm"

Comando: times 9 db 0
Scan: db "Scanning...", 13, 10, 0
Sect: db 0
	
