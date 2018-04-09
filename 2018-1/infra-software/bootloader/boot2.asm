org 0x500; 
jmp 0x000: start

str1 db 'Loading structures for the kernel',0
str2 db 'Setting up protected mode', 0
str3 db 'Loading kernel in memory', 0
str4 db 'Running kernel', 0
dot db '.', 0
finalDot db '.', 10, 13, 0


printStrings:

delay: 
;; Função que aplica um delay(improvisado) baseado no valor de dx
	mov bp, dx
	back:
	dec bp
	nop
    nop
	jnz back
	dec dx
	cmp dx,0    
	jnz back
ret

start:

    xor ax, ax
    mov ds, ax
    mov es, ax

    mov ax, 0x7e0 ;0x50<<1 = 0x500 (início de boot2.asm)
    mov es, ax
    xor bx, bx   ;posição = es<<1+bx

load_kernel:
    mov ah, 02h ;lê um setor do disco
    mov al, 20   ;quantidade de setores ocupados pelo boot2
    mov ch, 0   ;track 0
    mov cl, 3   ;sector 2
    mov dh, 0   ;head 0
    mov dl, 0   ;drive 0
    int 13h

    jc load_kernel     ;se o acesso falhar, tenta novamente

    jmp 0x7e00   ;pula para o setor de endereco 0x500 (start do boot2)


times 510-($-$$) db 0		
dw 0xaa55	