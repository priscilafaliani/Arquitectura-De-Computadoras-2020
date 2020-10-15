; sin usar subrutinas
org 1000h
num1H dw 1
num1L dw 256
num2H dw 1
num2L dw 257
resH dw 0
resL dw 0

org 2000h

mov ax, num1L
mov bx, num1H
add ax, num2L
adc bx, num2H

mov resH, bx
mov resL, ax


int 0
end

; creando una subrutina que
; recibe dos números por valor por la pila
; y retorna por referencia por la pila
org 1000h
num1H dw 0FFFFh
num1L dw 0FFFFh
num2H dw 0FFFFh
num2L dw 0FFFFh
resH dw 0
resL dw 0


org 3000h

SUM32: push bx
push ax
push dx
mov bx, sp
; sumo la parte baja
add bx, 10
mov ax, [bx]
add bx, 4
add ax, [bx]
; guardo el carry
adc dx, 0
; sumo la parte alta
add bx, 2
add dx, [bx]
sub bx, 4
add dx, [bx]
add dx, 0
; guardo el resultado
sub bx, 4
mov bx, [bx]
mov word ptr [bx], ax
add bx, 2
mov word ptr [bx], dx
pop dx
pop ax
pop bx
ret

org 2000h
mov ax, num1H
push ax
mov ax, num1L
push ax
mov ax, num2H
push ax
mov ax, num2L
push ax
mov ax, offset resH
push ax
call SUM32
pop ax
pop ax
pop ax
pop ax
pop ax

int 0 
end