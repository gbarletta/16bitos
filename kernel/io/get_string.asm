%define INVIO 0x0D

get_string:
	.ReadChar:
		mov ah, 0x00
		int 0x16
		
		cmp al, INVIO
		je .End
		
		stosb
		
		mov ah, 0x0E
		int 0x10
		
		jmp .ReadChar

	.End:
	
	mov al, 0
	stosb
	
	mov di, 0
	ret
