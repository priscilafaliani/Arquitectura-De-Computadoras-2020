org 1000h
prompt db "Ingrese dos números: "
endPrompt db 0
num1 db 0
num2 db 0
resultNum dw 0
resultChar db ?

org 3000h
; recibe en bx la direccion donde quiere guardar los caracteres
; en al la cantidad de caracteres
; se utiliza para la lectura de dos numeros, guardados consecutivamente
LEER: cmp al, 0
jz finLectura
repetir: int 6
inc bx
dec al
cmp al, 0
jnz repetir
finLectura: ret

; recibe en bx la direccion del caracter a convertir
; se asume que es un caracter numérico
chartonum1: sub byte ptr [bx], 30h
ret

; recibe en bx la direccion inicial de un vector de caracteres numéricos
; recibe en al la cantidad de elementos del vector
; se asume que son todos números
charToNumAll: cmp al, 0
jz endchartonum
repetir: call chartonum1
inc bx
dec al
cmp al, 0
jnz repetir
endchartonum: ret

; recibe en al y ah dos números de 1 byte
; retorna en la direccion en bx
sumTwo: mov word ptr [bx], al
add word ptr [bx], ah
ret

; recibe la direccion de un digito en bx
; se asume que es un único dígito de 0 a 9
intToChar: add byte ptr[bx], 30h
ret

; recibe en ax un número
; retorna en la direccion pasada por bx, una cadena de caracteres
intToCharAll: push dx
repetir: cmp ax, 0
jz fin


finintochar: ret



org 2000h
; prompt
mov bx, offset prompt
mov al, offset endPrompt - offset prompt
int 7

; read
mov bx, num1
mov al, 2
call LEER

; char to int
mov bx, offset num1
mov al, 2
call CONVERTIRVARIOS

; sum
mov al, num1
mov ah, num2
mov bx, offset result
call sumTwo

; int to char

; print

int 0
end
