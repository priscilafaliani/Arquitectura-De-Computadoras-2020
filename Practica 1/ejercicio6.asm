; Multiplicar dos numeros desde el programa principal

org 1000h

num1 dw 2
num2 dw 2
res dw 0

org 2000h

mov ax, 0
mov bx, num2

mul: cmp bx, 0
jz store
add ax, num1
dec bx
jmp mul

store: mov res, ax

hlt
end

; multiplicar utilizando una subrutina y parámetros por registro/valor
org 1000h
  num1 dw 2
  num2 dw 2
  res dw 0
org 3000h
; recibe num1 por ax
; recibe num2 por cx
; retorna por dx
mul: mov dx, 0
suma: cmp cx, 0 ; verifica si tiene que sumar
jz fin
add dx, ax
dec cx
jmp suma ; vuelve a ver si tiene que sumar
fin: ret ; si no, retorna al pp

org 2000h
mov ax, num1
mov cx, num2
call mul
mov res, dx
hlt
end

; multiplicar utilizando una subrutina y parámetros por registro/referencia
org 1000h
  num1 dw 2
  num2 dw 2
  res dw 0

org 3000h
; recibe la direccion de num1 por ax
; recibe la direccion de num2 por cx
; retorna por dx
mul: mov dx, bx ; salva bx
mov bx, ax
mov ax, [bx] ; obtiene los parametros
mov bx, cx
mov cx, [bx]
mov bx, dx
mov dx, 0 ; pone el resultado en 0
suma: cmp cx, 0 ; verifica si tiene que sumar
jz fin
add dx, ax ; suma num1 a dx
dec cx
jmp suma ; vuelve a ver si tiene que sumar
fin: ret ; si no, retorna al pp

org 2000h
mov bx, 22
mov ax, offset num1
mov cx, offset num2
call mul
mov res, dx
hlt
end
