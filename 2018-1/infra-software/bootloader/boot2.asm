org 0x500; 
jmp 0x000: start

str1 db 'Loading structures for the kernel',0
str2 db 'Setting up protected mode', 0
str3 db 'Loading kernel in memory', 0
str4 db 'Running kernel', 0
dot db '.', 0
finalDot db '.', 10, 13, 0


printStrings:

delay: 
;; Função que aplica um delay(improvisado) baseado no valor de dx
	mov bp, dx
	back:
	dec bp
	nop
    nop
	jnz back
	dec dx
	cmp dx,0    
	jnz back
ret


times 510-($-$$) db 0		
dw 0xaa55	