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
