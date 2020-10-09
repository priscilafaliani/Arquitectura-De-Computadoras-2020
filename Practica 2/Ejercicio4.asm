org 1000h
msj db "Ingrese un numero: "
finMsj db ?
num db ?

org 2000h
mov bx, offset msj
mov al, offset finMsj - offset msj
int 7

mov bx, offset num
int 6
mov al, 1
int 7
int 0
end

; a. en cuanto a int 7, en bx se almacena la direccion de comienzo de un string
; y en al, la cantidad de caracteres a imprimir
; b. en cuanto a int 6, en bx se almacena la direccion donde se guardara
; el caracter que se lea
; la segunda interrumpcion de int 7 imprime el caracter que se acaba de leer
; en cl queda guardado el numero que se leyo
