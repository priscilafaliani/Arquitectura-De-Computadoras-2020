; variables
org 1000h
numbers db "Cero  Uno   Dos   Tres  CuatroCinco Seis  Siete Ocho  Nueve "
numbersEnd db 0
prompt db "Ingrese un numero: "
endPrompt db 0
num db 0

; subroutines
org 3000h
; dx = number
; cl = times to be multiplied
; ax = result
MUL: mov ax, 0
cmp cl, 0
jz fin
repetir: add ax, dx
dec cl
cmp cl, 0
jnz repetir
fin: ret

; principal program
org 2000h
; prompt
mov bx, offset prompt
mov al, offset endPrompt - offset prompt
int 7
; read
mov bx, offset num
int 6
; find needed text
sub num, 30h
mov dh, 00h
mov dl, num
mov cl, 6
call MUL
; finally has the direction of the string vector
mov bx, offset numbers
add bx, ax
mov al, 6
; prints
int 7

int 0
end