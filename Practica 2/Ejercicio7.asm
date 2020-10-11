org 1000h
prompt db "Ingrese dos numeros: "
endPrompt db 0
num1 db 0
num2 db 0
result db 0
result2 db 0

org 3000h
; recibe en bx la direccion donde quiere guardar los caracteres
; en al la cantidad de caracteres
; se utiliza para la lectura de dos numeros, guardados consecutivamente
LEER: cmp al, 0
jz finLectura
repetirLeer: int 6
inc bx
dec al
cmp al, 0
jnz repetirLeer
finLectura: ret

; recibe en bx la direccion del caracter a convertir
; se asume que es un caracter numérico
chartonum1: sub byte ptr [bx], 30h
ret

; recibe en bx la direccion inicial de un vector de caracteres numéricos
; recibe en al la cantidad de elementos del vector
; se asume que son todos caracteres numéricos
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
sumTwo: mov byte ptr [bx], al
add byte ptr [bx], ah
ret

; recibe la direccion de un digito en bx
; se asume que es un único dígito de 0 a 9
intToChar: add byte ptr [bx], 30h
ret

; recibe en bx la direccion inicial de un vector de números
; recibe en al la cantidad de elementos del vector
; se asume que son todos números
intToCharAll: push ax
cmp al, 0
jz endIntToChar
repetirToChar: call intToChar
inc bx
dec al
cmp al, 0
jnz repetirToChar
endIntToChar: pop ax
ret

; PRINCIPAL PROGRAM ;
org 2000h
; prompt
mov bx, offset prompt
mov al, offset endPrompt - offset prompt
int 7

; read
mov bx, offset num1
mov al, 2
call LEER

; char to int for sum
mov bx, offset num1
mov al, 2
call charToNumAll

; sum
mov al, num1
mov ah, num2
mov bx, offset result2
call sumTwo

; checks if number requires two caracter for representation (has two digits)
cmp result2, 10
jns bcd

; if only has one digit, prepares *al* for printing 1 char
mov al, 1
mov ah, result2
mov result, ah
jmp convertForPrinting

; if has two digits applies bcd sum algorithm and preprares *al* for printing 2 char
bcd: add result2, 6
and result2, 0Fh
inc result
mov al, 2

; reconverts to ASCII *al* characters
convertForPrinting: mov bx, offset result
call intToCharAll

; prints
mov bx, offset result
int 7

int 0
end
