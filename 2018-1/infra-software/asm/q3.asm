org 0x7c00
jmp 0x0000: main

main:

  mov cx, sp ; Salva a posição inicial da Pilha
  mov dx, cx
lerNovamente:

  ; Fazendo Leitura
  mov AH, 0
  int 0x16 ; Interrupção ler valor
  ; Valor em AL
  push AX ; Colocar valor lido na pilha
  cmp AL, 0x0D ; Retorno de Carro, Enter!

  ; Printando na tela valor lido
  mov AH, 0x0E
  mov BH, 0
  mov BL, 4
  int 0x10 ;Interrupção Imprimir valor

  je terminoLeitura
  jne lerNovamente

incrementarCx:
  add cx, 2
terminoLeitura:
  mov bx, cx

  ; Passar valor de cx para ax
  ; mov si, cx ; Valor inicial do ponteiro salvo em cx
  mov ax, [bx]; Passar valor salvo no endereco de si para ax
  mov si, ax
terminoLeitura2:
  ; Incrementar si
  add bx, 2

  ; Comparar valor de ax com o próximo de si
  cmp ax, [bx]
  jle trocar

trocado:

  ; Fim BubbleSort - SI chegou ao final da pilha
  cmp cx, sp
  je imprimir

  cmp bx, sp
  je incrementarCx
  jmp terminoLeitura2


trocar:
  ; Troca o valor do conteúdo entre os dois registradores
  xchg si, [bx]
  jmp trocado

imprimir:
  mov cx, dx
imprimir2:
  pop DX ; Pegar ultimo valor da pilha
  mov AL, DL ; Imprimi o valor
  int 0x10

  cmp CX, SP ;Se a pilha voltou para o inicio está terminada a operação
  je fim
  jmp imprimir2

fim:
  jmp $

times 510 - ($ - $$) db 0
dw 0xAA55
