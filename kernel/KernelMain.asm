[BITS 16]

KernelMain:

	lea bx, [kloaded]
	call PrintString
	
	lea bx, [fsloading]
	call PrintString
	
	lea bx, [scloading]
	call PrintString
	
	lea bx, [shloading]
	call PrintString
	
	lea bx, [shloaded]
	call PrintString
	
	lea bx, [ShellLoadedMsg]
	call PrintString
	
	call LoadFilesystem
	call LoadScanner
	call LoadShell
	
	jmp $
		
LoadFilesystem:
	mov ah, 2 
    mov al, 1
    mov ch, 0   
    mov cl, 3  
    mov dh, 0   
    mov dl, 0   
    mov bx, 0x8000 
    mov es, bx      
    mov bx, 0x0000 
.readsector:
	int 0x13        
	jc .readsector

	;mov ax, 0x8000 
	;mov ds, ax
	ret
	
LoadScanner:
	mov ah, 2 
    mov al, 1
    mov ch, 0   
    mov cl, 5 
    mov dh, 0   
    mov dl, 0   
    mov bx, 0x8000
    mov es, bx      
    mov bx, 0x0400
.readsector:
	int 0x13        
	jc .readsector
	ret

LoadShell:
	mov ah, 2 
    mov al, 1
    mov ch, 0   
    mov cl, 4  
    mov dh, 0   
    mov dl, 0   
    mov bx, 0x8000
    mov es, bx      
    mov bx, 0x0200
.readsector:
	int 0x13        
	jc .readsector

	mov ax, 0x8000
	mov ds, ax

	jmp 0x8000:0x0200
		
%include "io/print_string.asm"
%include "io/print_hex_byte.asm"

ShellLoadedMsg: db 13, 10, "16shell v0.01 Giuseppe Barletta, type 'help' for a command list", 13, 10, 13, 10, 0
kloaded: db " * Kernel loaded", 13, 10, 0
shloaded: db " * Starting the shell [shel.bin]", 13, 10, 0
fsloading: db " * Loading filesystem at address 0x8000:0x0000", 13, 10, 0
scloading: db " * Loading file scanner [scan.bin] at address 0x8000:0x0400", 13, 10, 0
shloading: db " * Loading shell at address 0x8000:0x0200", 13, 10, 0

