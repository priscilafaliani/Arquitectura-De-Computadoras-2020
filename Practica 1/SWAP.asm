org 1000h
dato1 dw 222
dato2 dw 111

; subrutina que intercamba dos datos en memoria
; se envian por referencia por la pila
org 3000h
SWAP: push bx
push ax
mov bx, sp
; dato2
add bx, 6
mov bx, [bx]
mov bx, [bx]
push bx
; dato1
mov bx, sp
add bx, 10
mov bx, [bx]
mov ax, [bx]
; lo guarda en la posicion de dato2
mov bx, sp
add bx, 8
mov bx, [bx]
mov word ptr [bx], ax
; guarda dato2 en la posicion de dato1
pop ax
mov bx, sp
add bx, 8
mov bx, [bx]
mov word ptr [bx], ax
; fin
pop ax
pop bx
ret


org 2000h
mov ax, offset dato1
push ax
mov ax, offset dato2
push ax
call SWAP
pop ax
pop ax

int 0
end