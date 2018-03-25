org 0x7c00
jmp 0x0000: main

main:
  xor ax, ax
  mov ds, ax
  mov es, ax
  mov cx, ax

  push "b"
  mov si, sp
  mov dx, si

lerNovamente:

  ; Fazendo Leitura
  mov AH, 0
  int 0x16 ; Interrupção ler valor
  ; Valor em AL
  push ax ;Salva AL na posição de memoria apontada por DI, e DI é incrementado

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

  ; Adianta uma posição para que dx possa realmente apontar para o primeiro valor da stack
  sub dx, 2
  mov si, dx

  ; Volta uma posição de di para que possamos analisar último dado inputado
  mov di, sp
  add di, 2

loopExterno:
  ; Reinicia o ponteiro si para o começo da pilha
  mov si, dx

  ; Cx é o contador de quantos char foram inputados
  dec cx
  cmp cx, 0
  je terminoBubbleSort

loopContagem:

  ; SI Chegou em DI
  cmp si, di
  je loopExterno

  mov ax, [si]
  sub si, 2

  mov bx, [si]
  ; Compara so as partes baixas
  ; Antes comparando todo o Registrador estava dando erro
  cmp al, bl
  jae troca
voltaTroca:
  jmp loopContagem

troca:

  ; Add significa voltar uma posicao
  ; Sub significa avançar
  ; Isso por causa da formatação da pilha no x86
  mov bx, [si]
  mov [si], ax
  add si, 2
  mov [si], bx
  sub si, 2

  jmp voltaTroca

terminoBubbleSort:
  mov AH, 0x0E
  mov si, dx

imprimir:

  mov al, [si]
  sub si, 2
  int 0x10

  cmp SI, DI ;Se a pilha voltou para o inicio esta terminada a operação
  je fim
  jmp imprimir

fim:
  ; Imprimi ultimo valor
  mov al, [si]
  sub si, 2
  int 0x10
  jmp $ ; Loop infinito


times 510 - ($ - $$) db 0
dw 0xAA55
