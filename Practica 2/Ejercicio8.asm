org 1000h
msj1 db "Ingrese un numero: "
msj1Fin db ?
msj2 db "Ingrese otro numero: "
msj2Fin db ?
num1 db 0
num2 db 0
minus db "-"
result db ?

org 2000h
; prompt
mov bx, offset msj1
mov al, offset msj1Fin - offset msj1
int 7
; read
mov bx, offset num1
int 6
; prompt 2
mov bx, offset msj2
mov al, offset msj2Fin - offset msj2
int 7
; read
mov bx, offset num2
int 6
; char to int
sub num1, 30h
sub num2, 30h
; sub
mov ah, num1
sub ah, num2
mov result, ah
; verify is minus sign is needed
cmp result, 0
js complementar2
; else prints only one char
mov al, 1
mov bx, offset result
jmp toChar
; negative numbers are in ca2
complementar2: xor result, 0FFh
add result, 1
; prints min symbol + result
mov al, 2
mov bx, offset minus
; int to char
toChar: add result, 30h
int 7

int 0
end