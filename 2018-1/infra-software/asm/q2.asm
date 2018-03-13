org 0x7c00
jmp 0x0000: main

main:

mov AH, 0xE
mov AL, 'A'
mov BH, 0
mov BL, 4
int 0x10

mov cx, sp

mov AH, 0 ;Número da chamada.
xor cx, cx
lerNovamente:
  ; Fazendo Leitura
  inc cx
  mov AH, 0
  int 0x16
  ; AL
  push AX
  cmp AL, "s" ; "\n"
  ; je teste
  ; Printando na tela
  mov AH, 0x0E
  mov BH, 0
  mov BL, 4
  int 0x10

  inc cx
  je terminoLeitura
  jne lerNovamente

teste:
; Printando na tela
  mov AH, 0x0E
  mov AL, 'B'
  mov BH, 0
  mov BL, 4
  int 0x10
  jmp fim

terminoLeitura:
  dec cx
  mov ah, 0x0E

imprimir:
  pop dx
  mov al, dl
  int 0x10      ; otherwise, print out the character!
  dec cx

  cmp cx, 0
  je fim
  jmp imprimir

fim:
  jmp $

times 510 - ($ - $$) db 0
dw 0xAA55
