org 0x7c00
jmp 0x0000: main

main:

  mov cx, sp ; Salva a posição inicial da Pilha

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

terminoLeitura:
  ; Mode de imprimir
  mov AH, 0x0E

imprimir:
  pop DX ; Pegar ultimo valor da pilha
  mov AL, DL ; Imprimi o valor
  int 0x10

  cmp CX, SP ;Se a pilha voltou para o inicio esta terminada a operação
  je fim
  jmp imprimir

fim:
  jmp $ ; Loop infinito

times 510 - ($ - $$) db 0
dw 0xAA55
