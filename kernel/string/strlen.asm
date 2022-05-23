strlen:
	
	mov ax, 0
	
	loop:
		cmp byte [bx], 0
		je end
		
		inc ax
		inc bx
		jmp loop
		
	end:
	
	ret
