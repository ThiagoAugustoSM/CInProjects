org 0x500; 
jmp 0x000: start

str1 db 'Loading structures for the kernel', 0
str2 db 'Setting up protected mode', 0
str3 db 'Loading kernel in memory', 0
str4 db 'Running kernel', 0
str5 db 'Wait a minute', 0
str6 db 'We are setting everything up for you', 0
str7 db 'We are ready for....Genius', 0
dot db '.', 0
dotBreakLine db '.', 10, 13, 0


delay: 
;; Função que aplica um delay(improvisado) baseado no valor de dx
	mov bp, dx
	back:
	dec bp
	nop
	jnz back
	dec dx
	cmp dx,0    
	jnz back
ret

printString: 
;; Printa a string que esta em si    
	lodsb
	cmp al, 0
	je exit

	mov ah, 0xe
    mov bl, 2
	int 10h	

	mov dx, 100;tempo do delay
	call delay 
	
	jmp printString
exit:
    ret

print3Dots:
    mov dx, 300;tempo do delay
    call delay
    mov si, dot
    call printString

    mov dx, 300;tempo do delay
    call delay
    mov si, dot
    call printString
    
    mov dx, 300;tempo do delay
    call delay
    mov si, dotBreakLine
    call printString
ret

; ;;;;;;;;;;;;;;;;;;;
; quadrado:

;   mov cx, 600 ;;;;;X

; coluna:

;   mov dx, 150 ;;Y
;   dec cx
;   cmp cx, 50
;   jne linha
;   ret

; linha:

;   ; Imprimir um pixel na tela
;   mov ah, 0ch ; imprimi um pixel na coordenada [dx, cx]
;   mov bh, 0
;   mov al, bl ; Passando a cor escolhida para o pixel
;   ; mov al, 0ah ; cor do pixel, verde claro
;   int 10h

;   dec dx
;   cmp dx, 100
;   je coluna
;   jne linha
; ;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;
quadrado:

  mov cx, ax ;;;;;X inicia em 50
  add ax, 75
coluna:

  mov dx, 400 ;;Y
  inc cx
  cmp cx, ax ;;;aumentar até 100 e aumenta até 100
  jne linha
  ;;;;;atualizar o ax
  dec ax
  ret

linha:

  ; Imprimir um pixel na tela
  push ax
  mov ah, 0ch ; imprimi um pixel na coordenada [dx, cx]
  mov bh, 0
  mov al, bl ; Passando a cor escolhida para o pixel
  int 10h
  pop ax

  dec dx
  cmp dx, 350 ;;fim do Y
  je coluna
  jne linha
;;;;;;;;;;;;;;;;



start:

    xor ax, ax
    mov ds, ax
    mov es, ax

    mov ax, 0x7e0 ;0x50<<1 = 0x500 (início de boot2.asm)
    mov es, ax
    xor bx, bx   ;posição = es<<1+bx

    ; Modo para utilização de vídeo e VGA
	; mov ah, 0
	; mov al, 12h
	; int 10h

    ; Entrando no modo para utilização de vídeo e VGA
	mov ah, 0
	mov al, 12h
	int 10h


;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;DEFINIR A COR
    mov bl, 2
    push bx

    ; Modo para alterar o fundo da tela
    mov ah, 0xb
    mov bh, 0 ;paleta de cores
    mov bl, 0 ; preto
    int 10h

    pop bx

    push ax ;;usar ax para guardar a posição atual do carregamento
    mov ax, 50 ;; posição inicial é 50
    call quadrado
;;;;;;;;;;;;;;;;;;;;;;;;;;;



    ;Printando Strings
    push ax
    mov si, str1
    call printString
    call print3Dots
    pop ax
    call quadrado

    push ax
    mov si, str2
    call printString
    call print3Dots
    pop ax
    call quadrado


    push ax   
    mov si, str3
    call printString
    call print3Dots
    pop ax
    call quadrado

    push ax
    mov si, str4
    call printString
    call print3Dots
    pop ax
    call quadrado

    push ax
    mov si, str4
    call printString
    call print3Dots
    pop ax
    call quadrado

    push ax
    mov si, str4
    call printString
    call print3Dots

    ; mov si, str4
    ; call printString
    ; call print3Dots


    mov si, str5
    call printString
    call print3Dots
    call print3Dots
    call print3Dots

    ; mov si, str6
    ; call printString
    ; call print3Dots

    call print3Dots
    call print3Dots
    pop ax
    call quadrado

    mov si, str7
    call printString
    call print3Dots
    call print3Dots
    call print3Dots
    call print3Dots

    pop ax ;;deixar AX onde tava antes
    
;Carrega na memoria o kernel
	mov ax, 0x7e0
    mov es, ax
    xor bx, bx

;Resetando o disco floppy, forçando também a setar todas as trilhas para 0
reset:
	mov ah,0		
	mov dl,0		
	int 13h			
	jc reset		;em caso de erro, tenta de novo, 


load_kernel:

    mov ah, 02h ;lê um setor do disco
    mov al, 20   ;quantidade de setores ocupados pelo boot2
    mov ch, 0   ;track 0
    mov cl, 3   ;sector 2
    mov dh, 0   ;head 0
    mov dl, 0   ;drive 0
    int 13h

    jc load_kernel     ;se o acesso falhar, tenta novamente

    jmp 0x7e00   ;pula para o setor de endereco 0x500 (start do boot2)


times 510-($-$$) db 0		
dw 0xaa55	