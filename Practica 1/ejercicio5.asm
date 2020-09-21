; escribir un programa que realice A + B - C y guarde el resultado en D
; sin subrutina
org 1000h
  A DB ?
  B DB ?
  C DB ?
  D DB ?
org 2000h
  mov ah, A
  add ah, B
  sub ah, C
  mov D, ah
hlt
end

; con una subrutina que usa variables globales
org 1000h
  A DB ?
  B DB ?
  C DB ?
  D DB ?
org 3000h
addSub: mov ah, A
  add ah, B
  sub ah, C
  mov D, ah
 ret
org 2000h
  call addSub
hlt
end

; con una subrutina con parametros por valor a traves de registros
org 1000h
  A DB ?
  B DB ?
  C DB ?
  D DB ?
org 3000h

; ax, bx y cx, son parametros de entrada
; realiza a + b - c
; dx es el parametro de salida
addSub: mov dx, ax
  add dx, bx
  sub dx, cx
 ret

org 2000h
  mov ax, A
  mov bx, B
  mov cx, C
  call addSub
  mov D, dx
hlt
end
