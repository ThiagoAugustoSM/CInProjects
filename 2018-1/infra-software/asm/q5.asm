org 0x7c00
jmp 0x0000: main

INT_IMPRIMIR_CHAR_AL EQU 0X0E
INT_IMPRIMIR_CHAR EQU 0x10
QNT_INTERACOES EQU 100
ASCII_BACKSPACE EQU 0X08
ASCII_FIM_DE_CARRO EQU 0X0A

main:
  mov cx, QNT_INTERACOES

l1:
  ; Printando na tela valor lido
  mov AH, INT_IMPRIMIR_CHAR_AL
  mov BH, 0
  mov BL, 4

  push ax
  push cx
  ; jmp divisivel15

imprimirNumero:
  int INT_IMPRIMIR_CHAR
impresso:
  pop cx
imprimirEspacos:
  mov al , ASCII_BACKSPACE ; Volta um Espaço
  int INT_IMPRIMIR_CHAR
  mov al , ASCII_FIM_DE_CARRO ; Pula linha
  int INT_IMPRIMIR_CHAR

  pop ax
  inc al
  loop l1
  jmp fim

; The div instruction is used to perform a division.
; Always divides the 64 bits value accross EDX:EAX by a value.
; The result of the division is stored in EAX and the remainder in EDX.
; Before: ax/
divisivel15:
  mov dx, 0
  mov cx, 15
  div cx
  cmp dx, 0
  je imprimir15
  jne divisivel5
imprimir15:
  mov al, "f"
  int INT_IMPRIMIR_CHAR
  jmp impresso

divisivel5:
  mov dx, 0
  mov cx, 5
  div cx
  cmp dx, 0
  je imprimir5
  jne divisivel3
imprimir5:
  mov al, "5"
  int INT_IMPRIMIR_CHAR
  jmp impresso

divisivel3:
  mov dx, 0
  mov cx, 3
  div cx
  cmp dx, 0
  je imprimir3
  jne imprimirNumero
imprimir3:
  mov al, "3"
  int INT_IMPRIMIR_CHAR
  jmp impresso

fim:
  jmp $

times 510 - ($ - $$) db 0
dw 0xAA55
num db 1
