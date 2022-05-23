cd bootloader
nasm -f bin -o ../boot.bin BootMain.asm
cd ..

cd kernel
nasm -f bin -o ../kern.bin KernelMain.asm
cd ..

nasm -f bin -o shel.bin shell.asm
nasm -f bin -o scan.bin scanner.asm
nasm -f bin -o help help.asm
nasm -f bin -o halt halt.asm
nasm -f bin -o list list.asm

./floppy_writer
./floppy_writer boot.bin 1
./floppy_writer kern.bin 2
./floppy_writer shel.bin 4
./floppy_writer scan.bin 5
./floppy_writer help 6
./floppy_writer halt 7
./floppy_writer list 8
./floppy_writer serial 9
