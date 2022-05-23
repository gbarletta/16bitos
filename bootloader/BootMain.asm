[BITS 16]
[ORG 0x7C00]

BootMain:
	mov ax, 3
	int 0x10
	
	lea ax, [kloading]
	call PrintString
	
	lea ax, [booting]
	call PrintString
	
	call LoadKernel
	
	cli
	hlt
	
PrintString:
	pusha
	
	mov si, ax
	
	Loop:
	
		lodsb
		or al, al
		jz End
	
		call PrintCharacter
		jmp Loop
	
		End:
		
	
	popa
	ret
	
PrintCharacter:
	pusha
	
	mov bl, 1
	
	mov ah, 0x0E
	int 0x10
	
	popa
	ret
	


LoadKernel:
	mov ah, 2 
    mov al, 1
    mov ch, 0   
    mov cl, 2  
    mov dh, 0   
    mov dl, 0   
    mov bx, 0x2000  
    mov es, bx      
    mov bx, 0x0000
    
	.readsector:
		int 0x13        
		jc .readsector

		mov ax, 0x2000 
		mov ds, ax

		jmp 0x2000:0x0000 
    


; Padding per completare i 512 byte del bootsect, e magic word
kloading: db " - Loading kernel at address 0x2000:0x0000", 13, 10, 0
booting: db " - Starting the kernel [kern.bin]", 13, 10, 0
times 510 -( $ - $$ ) db 0
dw 0xAA55
