org 1000h
prompt db "Ingrese clave: "
finPrompt db ?
clave db "1234"
finClave db ?
accesoPermitido db "Acceso permitido"
finAcceso db ?
accesoDenegado db "Acceso denegado"
finDenegado db ?
claveLeida db 0

org 3000h
; recibe en bx la direccion inicial a guardar string
; en al la cantidad de caracteres
LEER: cmp al, 0
jz finLeer
repetir: int 6
inc bx
dec al
cmp al, 0
jnz repetir
finLeer: ret

; recibe un caracter en al y otro en ah
; retorna en al 0FFh si son iguales, 00h de caso contrario
COMPARECHAR: cmp al, ah
jnz diferentes
mov al, 0FFh
jmp fin
diferentes: mov al, 00h
fin: ret

; recibe dos direcciones de strings por pila
; recibe en ah el largo de las cadenas (asumimos que son del mismo largo)
; retorna en al 0FFh si son iguales o 00h en caso contrario
COMPAREKEY: cmp ah, 0
jz diferentesClaves
push bx
push cx
push dx
mov bx, sp
; __recupera primer direccion__
add bx, 8
mov cx, [bx]
; __recupera segunda direccion__
add bx, 2
mov dx, [bx]
; __recupera los caracteres__
; salva la cantidad de caracteres
repetirCompareK: push ax 
mov bx, cx
mov ah, [bx]
mov bx, dx
mov al, [bx]
call COMPARECHAR
; __verifica la igualdad__
cmp al, 0FFH
pop ax ; recupera la cantidad de caracteres
; __si son caracteres distintos__
jnz diferentesClaves
; __se prepara para el siguiente caracter__
inc cx
inc dx
dec ah
cmp ah, 0
jnz repetirCompareK
; __si llego al final es que son iguales__
mov al, 0FFh
jmp finCompareK
diferentesClaves: mov al, 00h
finCompareK: pop dx
pop cx
pop bx
ret

; PRINCIPAL PROGRAM ;
org 2000h
; prompt
mov bx, offset prompt
mov al, offset finPrompt - offset prompt
int 7

; read
mov bx, offset claveLeida
mov al, 4
call LEER

; compare
mov ax, offset clave
push ax
mov ax, offset claveLeida
push ax
mov ah, offset finClave - offset clave
call COMPAREKEY

; checks results
cmp al, 0FFh
jnz diffKeys
; returns allowed access msg
mov bx, offset accesoPermitido
mov al, offset finAcceso - offset accesoPermitido
int 7
jmp finProgram

; returns denied access msg
diffKeys: mov bx, offset accesoDenegado
mov al, offset finDenegado - offset accesoDenegado
int 7

; returns sp
finProgram: pop ax
pop ax

int 0 
end