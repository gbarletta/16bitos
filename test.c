void putc()
{
    asm "mov ah, #0x0e";
    asm "mov al, #65";
    asm "int 0x10";
}

void main()
{
	int i = 0;
	
	for(i = 0; i < 20; i++)
		putc();
}
