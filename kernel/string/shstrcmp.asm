shstrcmp:                 
scloop:
    mov al, [si]       
    mov bl, [di]       
    sub al, bl         
    jne scdone         
    cmp bl, ' '         
    jz scdone        
    inc si            
    inc di             
    jmp scloop
scdone:
    cbw
    cwd                     
	
	ret            

