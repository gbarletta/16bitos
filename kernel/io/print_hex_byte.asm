PrintHex: 
	pusha
	
	mov [.temp], al
	shr al, 4
	cmp al, 10
	sbb al, 0x69
	das
	 
	mov ah, 0x0E
	int 0x10
	 
	mov al, [.temp]
	ror al, 4
	shr al, 4
	cmp al, 10
	sbb al, 0x69
	das
	 
	mov ah, 0x0E
	int 0x10
	   
	mov al, 13
	mov ah, 0x0E
	int 0x10
	   
	mov al, 10
	mov ah, 0x0E
	int 0x10
	 
	popa
	ret
	 
.temp db 0
