SRC=mbr.asm
OUTFILE=mbr.bin
IMAGE=disk.img

all:
	nasm -f bin -o $(OUTFILE) $(SRC)

disk:
	dd if=/dev/zero of=$(IMAGE) bs=1024 count=1440
	dd if=$(OUTFILE) of=$(IMAGE) conv=notrunc

clean:
	rm -f $(OUTFILE) $(IMAGE) 