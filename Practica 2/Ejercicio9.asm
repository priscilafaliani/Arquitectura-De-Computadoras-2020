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

; recibe por pila dos caracteres
; retorna en *al* 0FFh si son iguales o 00h en caso contrario
COMPARECHAR: push dx
push bx
mov bx, sp
add bx, 2
; guarda primer caracter
push bx
mov bx, [bx]
mov dl, [bx]
pop bx
; guarda segundo caracter
add bx, 2
mov bx, [bx]
mov dh, [bx]
; compara
cmp dh, dl
jz sonIguales
mov al, 00h
jmp fin
sonIguales: mov al, 0FFh
fin: push bx
pop dx
ret

; recibe por pila dos direcciones de comienzo de strings
; recibe por pila la cantidad de caracteres de cada string
; asume que son del mismo largo
; retorna por pila si son iguales 0FFh
COMPAREKEY: push ax
push bx
push cx
push dx
mov bx, sp
; recupera la cantidad de caracteres
add bx, 10

push dx
push cx
push bx
push ax
ret

org 2000h
; prompt
mov bx, offset prompt
mov al, offset finPrompt - offset prompt
int 7
; read
mov bx, offset claveLeida
mov al, 4
call LEER
; verify
mov ax, offset clave
push ax
mov ax, offset claveLeida
push ax
mov ax, offset finClave - offset clave
push ax
call COMPAREKEY
; returns sp
pop dx
pop dx
pop dx
; checks if equals
cmp al, 0FFh
jz iguales
; prints result
; inequal
mov bx, offset accesoDenegado
mov al, offset finDenegado - offset accesoDenegado
int 7
; equal
iguales: mov bx, offset accesoPermitido
mov al, offset finAcceso - offset accesoPermitido

int 0 
end