org 0x7e00
jmp 0x0000:start

; story1 db 'Loading structures for the kernel', 0
; breakLine db '.', 10, 13, 0
c1 db 'b', 0
c2 db 'a', 0
c3 db 'y', 0
l1q1 db '            ba', 0
l2q1 db '          bbbaaa', 0
l3q1 db '        bbbbbaaaaa', 0
l4q1 db '      bbbbbbbaaaaaaa', 0
l5q1 db '    bbbbbbbbbaaaaaaaaa', 0
l6q1 db '  bbbbbbbbbbbaaaaaaaaaaa', 0
l7q1 db 'bbbbbbbbbbbbbaaaaaaaaaaaaa', 0
l8q1 db 'cccccccccccccddddddddddddd', 0
l9q1 db '  cccccccccccddddddddddd', 0
l10q1 db '   cccccccccddddddddd', 0
l11q1 db '     cccccccddddddd', 0
l12q1 db '       cccccddddd', 0
l13q1 db '         cccddd', 0
l14q1 db '           cd', 0
l15q1 db '', 0
jmpLine db 10, 13, 0


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

corVerde:
	mov bl, 2
	jmp corDecidida

corAmarelo:
	mov bl, 14
	jmp corDecidida

corVermelho:
	mov bl, 4
	jmp corDecidida

corAzul:
	mov bl, 1
	jmp corDecidida

corNada:
	mov bl, 0
	jmp corDecidida

printString: 
;; Printa a string que esta em si    
	
	lodsb

	cmp al, 'a'
	je corVerde
	cmp al, 'b'
	je corAmarelo
	cmp al, 'c'
	je corAzul
	cmp al, 'd'
	je corVermelho
	cmp al, ' '
	je corNada

	cmp al, 0
	je exit
corDecidida:

	mov al, 1  
	call q1
	mov al, 14
	call q2
	mov al, 2
	call q3
	mov al, 4
	call q4 
	
	jmp printString
exit:
    ret

q1:
	mov dx, 200
	mov cx, 200
	coluna1:

	mov cx, 200
	inc dx
	cmp dx, 300
	jne linha1
	ret

	linha1:
	
	; Imprimir um pixel na tela
	mov ah, 0ch ; imprimi um pixel na coordenada [dx, cx]
	mov bh, 0
	; mov al, bl ; Passando a cor escolhida para o pixel
	; mov al, 0ah ; cor do pixel, verde claro
	int 10h

	inc cx
	cmp cx, 300
	je coluna1
	jne linha1

q2:
	mov dx, 200
	mov cx, 300
	coluna2:

	mov cx, 300
	inc dx
	cmp dx, 300
	jne linha2
	ret

	linha2:
	
	; Imprimir um pixel na tela
	mov ah, 0ch ; imprimi um pixel na coordenada [dx, cx]
	mov bh, 0
	; mov al, bl ; Passando a cor escolhida para o pixel
	; mov al, 0ah ; cor do pixel, verde claro
	int 10h

	inc cx
	cmp cx, 400
	je coluna2
	jne linha2

q3:
	mov dx, 300
	mov cx, 200
	coluna3:

	mov cx, 200
	inc dx
	cmp dx, 400
	jne linha3
	ret

	linha3:
	
	; Imprimir um pixel na tela
	mov ah, 0ch ; imprimi um pixel na coordenada [dx, cx]
	mov bh, 0
	; mov al, bl ; Passando a cor escolhida para o pixel
	; mov al, 0ah ; cor do pixel, verde claro
	int 10h

	inc cx
	cmp cx, 300
	je coluna3
	jne linha3

q4:
	mov dx, 300
	mov cx, 300
	coluna4:

	mov cx, 300
	inc dx
	cmp dx, 400
	jne linha4
	ret

	linha4:
	
	; Imprimir um pixel na tela
	mov ah, 0ch ; imprimi um pixel na coordenada [dx, cx]
	mov bh, 0
	; mov al, bl ; Passando a cor escolhida para o pixel
	; mov al, 0ah ; cor do pixel, verde claro
	int 10h

	inc cx
	cmp cx, 400
	je coluna4
	jne linha4



start:
	xor ax, ax
	mov ds, ax
	mov es, ax

	; Modo para utilização de vídeo e VGA
	mov ah, 0
	mov al, 12h
	int 10h

	
imprimirGenius:	

	mov al, 1  
	call q1
	mov al, 14
	call q2
	mov al, 2
	call q3
	mov al, 4
	call q4 

	jmp done

done:
	jmp $