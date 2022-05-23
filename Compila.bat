@set path=C:\Users\PC\AppData\Local\nasm;%path%
nasm BootMain.asm -f bin -o bootsect.bin

partcopy bootsect.bin 0 200 16bitos.flp 0
@pause