org 0x7e00
jmp 0x0000:start

; story1 db 'Loading structures for the kernel', 0
; breakLine db '.', 10, 13, 0
c1 db 'b', 0
c2 db 'a', 0
c3 db 'y', 0
l1q1 db '', 0
l2q1 db '', 0
l3q1 db '                              ----------------', 0
l4q1 db '                               THE SIMON GAME', 0
l5q1 db '                              ----------------', 0
l6q1 db '  ', 0
l7q1 db 'Voce perdeu, deseja jogar novamente?[y/n]', 0
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


	printString:
	;; Printa a string que esta em si

		lodsb
		cmp al, 0
		je exit

		mov ah, 0xe
	    mov bl, 0xf
		int 10h

		mov dx, 30;tempo do delay
		call delay

		jmp printString
	exit:
	    ret

q1:
	mov dx, 190
	mov cx, 190
	coluna1:

	mov cx, 190
	inc dx
	cmp dx, 290
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
	cmp cx, 290
	je coluna1
	jne linha1




q2:
	mov dx, 190
	mov cx, 310
	coluna2:

	mov cx, 310
	inc dx
	cmp dx, 290
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
	cmp cx, 410
	je coluna2
	jne linha2

q3:
	mov dx, 310
	mov cx, 190
	coluna3:

	mov cx, 190
	inc dx
	cmp dx, 410
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
	cmp cx, 290
	je coluna3
	jne linha3

q4:
	mov dx, 310
	mov cx, 310
	coluna4:

	mov cx, 310
	inc dx
	cmp dx, 410
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
	cmp cx, 410
	je coluna4
	jne linha4


imprimirBack:
	mov bl, 8
  mov dx, 175
  mov cx, 175

	colunaBack:
  mov cx, 175
  inc dx
  cmp dx, 425
  jne linhaBack
  ret

  linhaBack:

; Imprimir um pixel na tela
  mov ah, 0ch ; imprimi um pixel na coordenada [dx, cx]
  mov bh, 0
  mov al, bl ; Passando a cor escolhida para o pixel
; mov al, 0ah ; cor do pixel, verde claro
  int 10h

  inc cx
  cmp cx, 425
  je colunaBack
  jne linhaBack

	changeQ1:
		mov al, 15
		call q1
		mov dx, 500
		call delay
		mov al, 1
		call q1

		mov al, 0
		jmp  changed

	changeQ2:
		mov al, 15
		call q2
		mov dx, 500
		call delay
		mov al, 14
		call q2

		mov al, 1
		jmp  changed

	 changeQ3:
		mov al, 15
		call q3
		mov dx, 500
		call delay
		mov al, 2
		call q3

		mov al, 2
		jmp  changed

	 changeQ4:
		mov al, 15
		call q4
		mov dx, 500
		call delay
		mov al, 4
		call q4

		mov al, 3
		jmp  changed

	changeQ1entrada:
		mov al, 15
		call q1
		mov dx, 500
		call delay
		mov al, 1
		call q1

		mov al, 0
		jmp  correto

	changeQ2entrada:
		mov al, 15
		call q2
		mov dx, 500
		call delay
		mov al, 14
		call q2

		mov al, 1
		jmp  correto

	 changeQ3entrada:
		mov al, 15
		call q3
		mov dx, 500
		call delay
		mov al, 2
		call q3

		mov al, 2
		jmp  correto

	 changeQ4entrada:
		mov al, 15
		call q4
		mov dx, 500
		call delay
		mov al, 4
		call q4

		mov al, 3
		jmp  correto

; generate a rand no using the system time
random:
	mov ah, 00h  ; interrupts to get system time
	int 1ah      ; CX:DX now hold number of clock ticks since midnight  ; lets just take the lower bits of DL for a start..
	mov ax,dx
	xor dx,dx
	mov cx,4
	div cx
	add dl,'0'

	; pop cx
	push dx ;Salvando o valor de Dx na Pilha

	mov al, dl
	mov ah, 0xe
	mov bl, 0xf
	int 10h

	mov dx, cx

jmp imprimirGenius

start:
	xor ax, ax
	mov ds, ax
	mov es, ax

	; Modo para utilização de vídeo e VGA
	mov ah, 0
	mov al, 12h
	int 10h

	;cabecalho
	mov si, l1q1
	call printString
	mov si,jmpLine
	call printString

	mov si, l2q1
	call printString
	mov si,jmpLine
	call printString

	mov si, l3q1
	call printString
	mov si,jmpLine
	call printString

	mov si, l4q1
	call printString
	mov si,jmpLine
	call printString

	mov si, l5q1
	call printString
	mov si,jmpLine
	call printString

	mov bl, 8
	call  imprimirBack

	push "2"
	; mov dx, sp
	; mov si, sp
	; push "3"
comecoSalvarRandom:
	; Adianta uma posição para que dx possa realmente apontar para o primeiro valor da stack
	; sub dx, 2
	mov dx, sp
	mov si, sp

	jmp random

addRandom:
	pop si
	jmp random

imprimirGenius:

	mov al, 1
	call q1
	mov al, 14
	call q2
	mov al, 2
	call q3
	mov al, 4
	call q4

play:
	; Adianta uma posição para que dx possa realmente apontar para o primeiro valor da stack
	mov dx, si
	; sub dx, 2
	mov si, dx

	push dx ; Salvar o valor de SI para ser utilizado na parte de execucao

	; Volta uma posição de di para que possamos analisar último dado inputado
	mov di, sp
	; add di, 2
	loop:

		mov ax, [si]

		cmp al, '0'
		je changeQ1
		cmp al, '1'
		je changeQ2
		cmp al, '2'
		je changeQ3
		cmp al, '3'
		je changeQ4

changed:
		cmp si, di
		je execute
		sub si, 1
		; jmp analisePilha
teclaLida:
		jmp loop

execute:
analisePilha:
	pop si ; Recuperando o valor de SI
	mov di, sp

	push si ; Salvar o valor de SI novamente na pilha

	loop2:

		mov bx, [si]

		; Fazendo leitura da tecla
		mov ah, 0
		int 16h

		cmp al, bl;Comparando diretamente com o valor salvo
		jne errado
		cmp al, '0'
		je changeQ1entrada
		cmp al, '1'
		je changeQ2entrada
		cmp al, '2'
		je changeQ3entrada
		cmp al, '3'
		je changeQ4entrada

		errado:
			mov al, 'k'
			mov ah, 0xe
			mov bl, 0xf
			int 10h

			mov si, l7q1
			call printString
			mov si,jmpLine
			call printString

			mov ah, 0
			int 16h

			cmp al, 'y'
			je restart
			jmp done

		correto:
			cmp si, di
			je addRandom
			sub si, 2
			jmp loop2

		restart:
			; mov al, 'r'
			; mov ah, 0xe
			; mov bl, 0xf
			; int 10h
			mov ah, 0
			mov al, 12h
			int 10h
			jmp start



done:
	jmp $
