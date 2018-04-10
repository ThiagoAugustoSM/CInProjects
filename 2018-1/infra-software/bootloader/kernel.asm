org 0x7e00
jmp 0x0000:start

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Diretivas para alocacao de strings que serao utilizadas no decorrer do programa
;; Os 0's ao final das string sao para saber qual o final
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
l8q1 db '                              JOGO DESENVOLVIDO POR', 0
l9q1 db '                              mbgj - Michael Barney', 0
l10q1 db '                             rjvw - Ramon Wanderley', 0
l11q1 db '                             tasm2 - Thiago Augusto', 0
l12q1 db '                              ---------------------', 0
l13q1 db '                       Projeto realizado na disciplina de', 0
l14q1 db '                       Infraestrutura de Software 2018.1', 0
l15q1 db '', 0
jmpLine db 10, 13, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Funcionamento da funcao:
;; Antes de chamar delay deve-se colocar algum valor em dx
;; Implementada utilizando espera ocupada
delay:
	mov bp, dx
	back:
	dec bp
	nop
	jnz back
	dec dx
	cmp dx,0
	jnz back
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Funcionamento da funcao:
;; Printa a string que esta em si
;; lodsb incrementa si e move o valor anterior de SI em AL
printString:

	lodsb
	cmp al, 0
	je exit

	; Imprimi na tela o valor
	mov ah, 0xe ; Input para imprimir char
  mov bl, 0xf ; Cor = Branco
	int 10h

	mov dx, 30 ; Tempo do delay
	call delay

	jmp printString
exit:
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Funcionamento da funcao:
;; Imprimi um quadrado nas posicoes iniciais CX e DX
;; O tamanho do quadrado eh 100 x 100
;; Modelo impresso pixel a pixel
;; Todas as funcoes do tipo qX e imprimirBack são do mesmo tipo so mudam a posicao do retangulo
;; as cores e seus respectivos tamanhos
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Funcionamento da funcao:
;; O objetivo eh piscar algum determinado quadrado
;; Modifica-se o valor de al para branco e depois para o valor natural do quadrado
;; Cores AL:
;; 15 - Branco
;; 1 - Azul
;; 14 - Amarelo
;; 2 - Verde
;; 4 - Vermelho
;; As funcoes do tipoe changeQX sao do mesmo escopo
changeQ1:
	mov al, 15
	call q1
	mov dx, 500
	call delay
	mov al, 1
	call q1

	; Move-se o valor final para saber qual foi o retangulo modificado
	; Ex: Ao termino de changeQ1 AL terá o valor 0
	; Ao termino de changeQ2 AL terá o valor 1, etc...
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Funcionamento da funcao:
;; O objetivo eh piscar algum determinado quadrado depois de ter a entrada do teclado do usuario
;; Modifica-se o valor de al para branco e depois para o valor natural do quadrado
;; O modelo de modificar as cores também são no modelo do tipo da funcao changeQX
;; As funcoes do tipoe changeQXentrada sao do mesmo escopo
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Funcionamento da funcao:
;; O objetivo da funcao eh gerar um numero randomico
;; Utiliza-se o tempo do sistema
random:
	mov ah, 00h  ; Interrupcao para pegar o tempo do sistema
	int 1ah      ; CX:DX tem os valores do clock desde a meia noite
	mov ax,dx ; AX eh o dividendo
	xor dx,dx
	mov cx, 4 ; Cx eh o divisor
	div cx ; O resto da divisao fica em dl
	add dl,'0' ; Soma-se '0' para termos valores de 0 a 3 como representacao

	push dx ;Salvando o valor de Dx na Pilha

	; Printar Mensagem, para sabermos qual valor salvo do resto
	; mov al, dl
	; mov ah, 0xe
	; mov bl, 0xf
	; int 10h

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

	; Imprimi os blocos de instrução
	mov al, 1
	call q1
	mov al, 14
	call q2
	mov al, 2
	call q3
	mov al, 4
	call q4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Funcionamento da funcao:
;; Modo para amostragem da ultima sequencia do Jogo para o usuario
;; O loop eh feito analisando os valores da Pilha
;; Olhar questao q3.asm da lista para analisar como analisar valores da pilha
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
		cmp si, di ; Se chegou ao final da pilha
		je execute
		sub si, 1

teclaLida:
		jmp loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Funcionamento da funcao:
;; Modo para analise dos inputs do usuario em relacao a pilha de dados
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

			; Mensagem de texto errado
			mov si, l7q1
			call printString
			mov si,jmpLine
			call printString

			mov ah, 0
			int 16h

			; y -> restart
			; qualquerOutra -> mostrar creditos
			cmp al, 'y'
			je restart
			jmp creditos

		correto:
			cmp si, di
			je addRandom
			sub si, 2
			jmp loop2

		restart:
			; Bloco para teste se esta entrando em restart
			; mov al, 'r'
			; mov ah, 0xe
			; mov bl, 0xf
			; int 10h
			jmp start

			creditos:

			mov ah, 0
			mov al, 12h
			int 10h

			mov si,jmpLine
			call printString
			mov si,jmpLine
			call printString
			mov si,jmpLine
			call printString

			mov si, l8q1
			call printString
			mov si,jmpLine
			call printString

			mov si,jmpLine
			call printString

			mov si, l9q1
			call printString
			mov si,jmpLine
			call printString

			mov si, l10q1
			call printString
			mov si,jmpLine
			call printString

			mov si, l11q1
			call printString
			mov si,jmpLine
			call printString

			mov si, l12q1
			call printString
			mov si,jmpLine
			call printString

			mov si, l13q1
			call printString
			mov si,jmpLine
			call printString

			mov si, l14q1
			call printString
			mov si,jmpLine
			call printString

done:
	jmp $
