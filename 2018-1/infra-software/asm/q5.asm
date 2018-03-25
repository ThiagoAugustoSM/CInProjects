org 0x7c00
jmp 0x0000: main

INT_IMPRIMIR_CHAR_AH EQU 0X0E
INT_IMPRIMIR_CHAR EQU 0x10 ;codigo da interrupcao de print char
QNT_INTERACOES EQU 100 ;quantidade de interacoes
ASCII_BACKSPACE EQU 0X08
ASCII_FIM_DE_CARRO EQU 0X0A

main:
  mov cx, QNT_INTERACOES
  mov al, 49 ;valor de "1"em asc, representa as unidades
  mov dl, 48 ; valor de "0" em asc , representa os decimais
  l1:
    mov ah, INT_IMPRIMIR_CHAR_AH
    mov bh, 0
    mov bl, 4
    push ax
    push dx
    cmp cx, 1
    je imprimir100 ;Como temos apenas decimais e unidades, foi criado pra imprimir o Buzz na 100º interacao
    jmp checar3

apenasDigito:
    pop dx
    pop ax
    cmp dl, 48
    je imprimirUnidade
    push ax
    mov al, dl
    int INT_IMPRIMIR_CHAR
    pop ax
imprimirUnidade:
    int INT_IMPRIMIR_CHAR


imprimirEspacos:
    push ax
    mov al , ASCII_BACKSPACE ; Volta um Espaço
    int INT_IMPRIMIR_CHAR
    int INT_IMPRIMIR_CHAR
    int INT_IMPRIMIR_CHAR
    int INT_IMPRIMIR_CHAR
    int INT_IMPRIMIR_CHAR
    int INT_IMPRIMIR_CHAR
    int INT_IMPRIMIR_CHAR
    int INT_IMPRIMIR_CHAR
    ;voltou a quantidade de vezes do tamanho da maior palavra "FizzBuzz"
    mov al , ASCII_FIM_DE_CARRO ; Pula linha
    int INT_IMPRIMIR_CHAR
    pop ax
    inc al
    cmp al, 58
    je subtrair48
retorno:

    loop l1

    jmp fim

imprimir100:
    mov ah, INT_IMPRIMIR_CHAR_AH
    mov al, "B"
    int INT_IMPRIMIR_CHAR
    mov al, "u"
    int INT_IMPRIMIR_CHAR
    mov al, "z"
    int INT_IMPRIMIR_CHAR
    mov al, "z"
    int INT_IMPRIMIR_CHAR
    jmp fim

subtrair48: ;label responsavel por zerar as unidades e incrementar as dezenas
    mov al, 48
    inc dl
    jmp retorno

checar3:
    mov ah, 0
    mov dh, 10
    add al, -0

    add dl, -0
    push ax
    mov al, dl
    mul dh ; ax= al*op
    mov dx, ax
    pop ax
    add ax, dx

    push ax

    mov dh, 3
    div dh
    cmp ah, 0
    je divisivel3

checar5:

    ;mov ax, dx
    pop ax
    add ax, -3
    ;push dx
    mov dh, 5
    div dh ;ah= ax%op
    ;pop dx
    cmp ah, 0
    je divisivel5

    jmp apenasDigito


divisivel3:
    mov ah, INT_IMPRIMIR_CHAR_AH
    mov al, "F"
    int INT_IMPRIMIR_CHAR
    mov al, "i"
    int INT_IMPRIMIR_CHAR
    mov al, "z"
    int INT_IMPRIMIR_CHAR
    mov al, "z"
    int INT_IMPRIMIR_CHAR
    ;checar se é divisivel por 5 tb
    pop ax
    add ax, -3
    mov dh, 5
    div dh
    cmp ah, 0
    je divisivel5
    pop dx
    pop ax
    jmp imprimirEspacos

divisivel5:
    mov ah, INT_IMPRIMIR_CHAR_AH
    mov al, "B"
    int INT_IMPRIMIR_CHAR
    mov al, "u"
    int INT_IMPRIMIR_CHAR
    mov al, "z"
    int INT_IMPRIMIR_CHAR
    mov al, "z"
    int INT_IMPRIMIR_CHAR
    pop dx
    pop ax
    jmp imprimirEspacos


fim:
  jmp $

times 510 - ($ - $$) db 0
dw 0xAA55
num db 1
