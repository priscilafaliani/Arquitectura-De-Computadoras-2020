org 1000h
num db 3
divisor db 3
result db 0

; subrutina que calcula la division entre dos numeros positivos.
; los numeros se reciben en la pila, en un mismo bloque de 16 bits.
; el de la dir mas alta (H) es el dividendo, el otro divisor (L)
; se envia el resultado por la pila por valor.
org 3000h
DIV: push bx
push ax
mov bx, sp
; recupero los numeros
add bx, 8 
mov ax, [bx]
; resultado
sub bx, 2
mov word ptr [bx], 00h
; loop de restas
loop: cmp ah, al
js fin
sub ah, al
inc word ptr [bx]
jmp loop
fin: pop ax
pop bx
ret

org 2000h
mov ah, num
mov al, divisor
push ax
push ax ; para el resultado
call DIV
pop ax ; tengo el resultado
mov result, ax
pop ax 

int 0
end