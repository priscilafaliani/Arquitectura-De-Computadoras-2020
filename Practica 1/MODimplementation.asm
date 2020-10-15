org 1000h
num dw 231
divisor dw 9
result db 0

; subrutina que calcula la division entre dos numeros positivos.
; los numeros se reciben en la pila, en un mismo bloque de 16 bits.
; el de la dir mas alta (H) es el dividendo, el otro divisor (L)
; se envia el resultado por la pila por valor.
org 3000h
MOD: push bx
push dx
push ax
mov bx, sp
; recupero los numeros
add bx, 12
mov ax, [bx]
sub bx, 2
mov dx, [bx]
; resultado
sub bx, 2
mov word ptr [bx], 00h
; loop de restas
loop: cmp ax, dx
js restoOtro
jz resto0
sub ax, dx
jmp loop
restoOtro: mov word ptr [bx], ax
jmp finreal
resto0: mov byte ptr [bx], 0
finreal: pop ax
pop dx
pop bx
ret

org 2000h
mov ax, num
push ax
mov ax, divisor
push ax
push ax ; para el resultado
call MOD
pop ax ; tengo el resultado
mov result, ax
pop ax 

int 0
end