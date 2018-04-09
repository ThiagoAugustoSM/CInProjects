org 0x7e00
jmp 0x0000:start

start:
	xor ax, ax
	mov ds, ax
	mov es, ax

	; Modo para utilização de vídeo e VGA
	mov ah, 0
	mov al, 12h
	int 10h


done:
	jmp $