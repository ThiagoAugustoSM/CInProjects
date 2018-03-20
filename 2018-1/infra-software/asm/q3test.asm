org 0x7c00
jmp 0x0000: main

main:
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov cx, ax
  mov si, di
  mov dx, si

lerNovamente:

  ; Fazendo Leitura
  mov AH, 0
  int 0x16 ; Interrupção ler valor
  ; Valor em AL
  stosb ;Salva AL na posição de memoria apontada por DI, e DI é incrementado

  inc cx
  cmp AL, 0x0D ; Retorno de Carro, Enter!

  ; Printando na tela valor lido
  mov AH, 0x0E
  mov BH, 0
  mov BL, 4
  int 0x10 ;Interrupção Imprimir valor


  je terminoLeitura
  jne lerNovamente

terminoLeitura:

  ; CX = DI - SI
  ; xor cx, cx
  ; mov cx, di
  ; sub cx, si

  mov AH, 0x0E
  mov BH, 0
  mov BL, 4
  mov al, cl
  ; int 0x10 ;Interrupção Imprimir valor

  ; DX = SI
  dec dx
  dec di
  dec di

loopExterno:
  mov si, dx

  dec cx
  cmp cx, 0
  je terminoBubbleSort

loopContagem:

  cmp si, di
  je loopExterno

  mov ax, [si]
  inc si
  ; lodsb
  cmp ax, [si]
  jg troca
voltaTroca:
  cmp si, di
  je loopExterno
  jne loopContagem

troca:
  mov bx, [si]
  mov [si], ax
  dec si
  mov [si], bx
  inc si
  jmp voltaTroca

terminoBubbleSort:
  mov AH, 0x0E
  mov si, dx

imprimir:
  mov al, [si]
  inc si
  int 0x10

  cmp SI, DI ;Se a pilha voltou para o inicio esta terminada a operação
  je fim
  jmp imprimir

fim:
  jmp $ ; Loop infinito










times 510 - ($ - $$) db 0
dw 0xAA55
