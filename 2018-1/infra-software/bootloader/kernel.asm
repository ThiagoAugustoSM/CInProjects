org 0x7e00
jmp 0x0000:start

; story1 db 'Loading structures for the kernel', 0
; breakLine db '.', 10, 13, 0
l1q1 db '           ba', 0
l2q1 db '         bbbaaa', 0
l3q1 db '       bbbbbaaaaa', 0
l4q1 db '      bbbbbbaaaaaaa', 0
l5q1 db '    bbbbbbbbaaaaaaaaa', 0
l6q1 db '  bbbbbbbbbbbaaaaaaaaaaa', 0
l7q1 db 'bbbbbbbbbbbbbaaaaaaaaaaaaa', 0
l8q1 db 'cccccccccccccddddddddddddd', 0
l9q1 db '  cccccccccccddddddddddd', 0
l10q1 db '    cccccccccdddddddd', 0
l11q1 db '', 0
jmpLine db 'a', 10, 13, 0


delay: 
;; Função que aplica um delay(improvisado) baseado no valor de dx
	mov bp, dx
	back:
	dec bp
	nop
    nop
    nop
    nop
	jnz back
	dec dx
	cmp dx,0    
	jnz back
ret

printString: 
;; Printa a string que esta em si    
	
	lodsb
	cmp al, 0
	je exit

	mov ah, 0xe
    mov bl, 0xf
	int 10h	

	mov dx, 100;tempo do delay
	call delay 
	
	jmp printString
exit:
    ret

start:
	xor ax, ax
	mov ds, ax
	mov es, ax

	; Modo para utilização de vídeo e VGA
	mov ah, 0
	mov al, 12h
	int 10h

	mov si, l1q1
	call printString
	mov si, jmpLine
	call printString

	mov si, l2q1
	call printString
	mov si, jmpLine
	call printString

	mov si, l3q1
	call printString
	mov si, jmpLine
	call printString
	
	mov si, l4q1
	call printString
	mov si, jmpLine
	call printString

	mov si, l5q1
	call printString
	mov si, jmpLine
	call printString

	mov si, l6q1
	call printString
	mov si, jmpLine
	call printString

	mov si, l7q1
	call printString
	mov si, jmpLine
	call printString

done:
	jmp $