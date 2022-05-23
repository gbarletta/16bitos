PrintString:
	pusha
	
	Loop:
		mov ax, [bx]
		or al, al
		jz End
	
		mov ah, 0x0E
		int 0x10
		
		inc bx
		jmp Loop
	
		End:
	popa
	ret

