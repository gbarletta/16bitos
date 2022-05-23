shstrlen:
	
	mov ax, 0
	
	loop:
		cmp byte [bx], ' '
		je end
		
		inc ax
		inc bx
		jmp loop
		
	end:
	
	ret
