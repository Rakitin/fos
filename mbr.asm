use16
org 0x7C00
	jmp boot

reboot_msg db "Press any key...", 13, 10, 0
boot_msg db "Booting FOS...", 13, 10, 0

disk_id db 0


; print string on screen
; | in:
; si - string
print_str:
	push ax
	push bx
	push si
	mov ah, 0x0E
	mov bh, 0x00
	cld
.loop:
	lodsb
	test al, al
	jz .exit
	int 0x10
	jmp .loop
.exit:
	pop si
	pop bx
	pop ax
	ret

reboot:
	xor ah, ah
	int 0x16
	jmp 0xFFFF:0


boot:
	mov ax, cs
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, $$

	sti
	mov [disk_id], dl

	mov si, boot_msg
	call print_str

	mov si, reboot_msg
	call print_str

	jmp reboot

times 510-($-$$) db 0
db 0x55, 0xAA 