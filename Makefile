SRC=boot.asm
OUTFILE=boot.bin
IMAGE=disk.img

all: disk

boot:
	nasm -f bin -o $(OUTFILE) $(SRC)

disk: boot 
	dd if=/dev/zero of=$(IMAGE) bs=1024 count=1440
	dd if=$(OUTFILE) of=$(IMAGE) conv=notrunc

rundeb: disk
	qemu-system-i386 -fda disk.img -boot a -S -s

clean:
	rm -f $(OUTFILE) $(IMAGE) 