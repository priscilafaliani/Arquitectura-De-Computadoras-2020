org 1000h
mensaje db "Voy a imprimir minusculas y mayusculas intercaladas!"
fin_mensaje db ?
longitud db fin_mensaje - mensaje
a db "a"
A db "A"

org 2000h
; imprime un mensaje guardado en memoria
mov bx, offset mensaje
mov al, longitud
int 7

; imprime de a dos caracteres a la vez
mov al, 2
mov bx, offset a
imprimir: cmp byte ptr [bx], 123 ; si llego al ultimo caracter
jz fin
; imprime mayus y minus
int 7
; incrementa las variables para los siguientes caracteres
inc a
inc A
jmp imprimir

fin: int 0
end
