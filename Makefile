BUILD_DIR=build
BOOT_SRC=boot.asm
BOOT_OUTFILE=$(BUILD_DIR)/boot.bin
IMAGE=$(BUILD_DIR)/disk.img

all: disk

boot:
	nasm -f bin -o $(BOOT_OUTFILE) $(BOOT_SRC)

disk: boot 
	dd if=/dev/zero of=$(IMAGE) bs=1024 count=1440
	dd if=$(BOOT_OUTFILE) of=$(IMAGE) conv=notrunc

rundeb: disk
	qemu-system-i386 -fda $(BUILD_DIR)/disk.img -boot a -S -s

clean:
	rm -f $(BOOT_OUTFILE) $(IMAGE) 