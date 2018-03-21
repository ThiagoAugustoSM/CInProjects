org 0x7c00
jmp 0x0000:start

; DW ALOCATE 2 BYTES
quadrado DW 0, 0, 0, 255, 255, 0, 255, 255
start:
  xor ax, ax
  mov ds, ax
  mov es, ax

  ; leitura tipo de cor
  mov AH, 0 ; limpando o acumulador
  int 16h ; interrupção para leitura de dados

  ; Leitura da cor de entrada
  cmp AL, "r" ; Value read is in AL
  je red
  cmp AL, "g"
  je green
  cmp AL, "b"
  je blue
  cmp AL, "c"
  je cian
  cmp AL, "y"
  je yellow
  cmp AL, "m"
  je cian

; Salvando o tipo de cor baseada na BIOS Color Attributes no reg BX parte Low
red:
  mov bl, 4
  jmp leituraFigura
green:
  mov bl, 2
  jmp leituraFigura
blue:
  mov bl, 1
  jmp leituraFigura
cian:
  mov bl, 3
  jmp leituraFigura
yellow:
  mov bl, 14
  jmp leituraFigura
magenta:
  mov bl, 5

leituraFigura:
  ; Primeira leitura feita para retirar o espaço
  ; mov AH, 0 ; limpando o acumulador
  ; int 16h ; interrupção para leitura de dados
  ; mov AH, 0 ; limpando o acumulador
  ; int 16h ; interrupção para leitura de dados

  ; INT 10H 0cH: Write Graphics Pixel
  ;  Compatibility: All
  ;  Expects: AH    0cH
  ;           AL    color number (+80H means XOR with current value)
  ;           BH    video page (0-based)
  ;           CX    graphics column
  ;           DX    graphics row


colorir:
  mov AH, 0ch
  mov BH, 0
  mov AL, BL
  mov cx, 200
  mov dx, 200
  int 10h
  ; je colorir

; Mudar cor
; quadrado:
;   mov AH, 0xb
;   mov BH, 0
;   mov BL, cl
;   int 10h ;This initializes the video hardware to display in the specified video mode.
;   jmp fim
; triangulo:
;   mov AH, 0xb
;   mov BH, 0
;   mov BL, 6
;   int 10h ;This initializes the video hardware to display in the specified video mode.
;   jmp fim
fim:
  jmp $

times 510 - ($ - $$) db 0
dw 0xaa55       ;assinatura de boot
