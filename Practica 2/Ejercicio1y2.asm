org 1000h
mensaje db "Voy a mostrar todos los caracteres disponibles!"
fin_mensaje db ?
longitud db fin_mensaje - mensaje
primero db 21h
ultimo db 127


org 2000h
; imprime un mensaje guardado en memoria
mov bx, offset mensaje
mov al, longitud
int 7

; imprime desde el caracter 21h hasta el 7fHh
mov bx, offset primero
mov al, 1
; pregunta: ¿es este el último caracter? (127 no se debe imprimir)
imprimir: cmp byte ptr [bx], 127
jz fin
; sino, imprime el caracter en la posicion [bx]
int 7
; guarda el siguiente caracter en [bx]
inc [bx]
jmp imprimir

fin: int 0
end
