_start:

  mov ax, 0
  mov ds, ax

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

  ; leitura do espaço
  mov AH, 0 ; limpando o acumulador
  int 16h ; interrupção para leitura de dados

  ; leitura tipo de figura
  mov AH, 0 ; limpando o acumulador
  int 16h ; interrupção para leitura de dados

  ; Salva a escolha do tipo
  push ax
  ; Salvando o valor da cor, pq para alterar o fundo precisa mudar BL
  push bx

  ; Modo para utilização de vídeo e VGA
  mov ah, 0
  mov al, 12h
  int 10h

  ; Modo para alterar o fundo da tela
  mov ah, 0xb
  mov bh, 0 ;paleta de cores
  mov bl, 0 ; preto
  int 10h

  pop bx

  pop ax

  ; Leitura da cor de entrada
  cmp AL, "t" ; Value read is in AL
  je printaTriangulo
  cmp AL, "q"
  je printaQuadrado
  cmp AL, "T"
  je printaTrapezio

quadrado:

  mov dx, 100
  mov cx, 100

coluna:

  mov cx, 100
  dec dx
  cmp dx, 0
  jne linha
  ret

linha:

  ; Imprimir um pixel na tela
  mov ah, 0ch ; imprimi um pixel na coordenada [dx, cx]
  mov bh, 0
  mov al, bl ; Passando a cor escolhida para o pixel
  ; mov al, 0ah ; cor do pixel, verde claro
  int 10h

  dec cx
  cmp cx, 0
  je coluna
  jne linha

triangulo:

    ;[DX, CX]
    mov cx, 100 ; x
    mov dx, 0 ; y

  colunaTriangulo:

    ; x = x + y
    mov cx, 100
    inc dx
    cmp dx, 100
    jne linhaTriangulo
    ret

  linhaTriangulo:

    ; Imprimir um pixel na tela
    mov ah, 0ch ; imprimi um pixel na coordenada [dx, cx]
    mov bh, 0
    mov al, bl ; Passando a cor escolhida para o pixel
    ; mov al, 0ah ; cor do pixel, verde claro
    int 10h

    xor ax, ax
    add ax, 100
    add ax, dx

    ; x = 100 + y ? - Imprimi um triangulo retangulo
    inc cx
    cmp cx, ax
    je colunaTriangulo
    jne linhaTriangulo

printaQuadrado:
  call quadrado
  jmp fim

printaTriangulo:
  call triangulo
  jmp fim

; A impressão do trapézio é feita utilizando de um quadrado e um triângulo
printaTrapezio:
  call quadrado
  call triangulo
  jmp fim

fim:
  jmp $


times 510 - ($-$$) db 0
dw 0xaa55
