org 1000h
prompt db "Ingrese clave: "
finPrompt db ?
clave db "1234"
finClave db ?
claveLeida db 0
accesoPermitido db "Acceso permitido"
finAcceso db ?
accesoDenegado db "Acceso denegado"
finDenegado db ?

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


; recibe por pila la direccion de comienzo de dos claves
; luego tambien por la pila la cantidad de caracteres de las claves
; se asume que ambas claves son del mismo largo
; retorna en *al* 0FFh si son iguales o 00h en caso contrario
COMPAREKEY: push bx ; salva registros
push cx
push dx
; recupera los datos
mov bx, sp
; clave 1
add bx, 4
mov cx, [bx]
; clave 2
add bx, 2
mov dx, [bx]
; cantidad de caracteres
sub bx, 4
; comienza a comparar
; si no hay caracteres termina
repetirComparar: push bx
mov bl, [bx]
cmp bl, 0
pop bx
jz finComparar
push bx
; primer caracter
mov bx, cx
mov bx, [bx]
push bx
; segundo caracter
mov bx, dx
mov bx, [bx]
push bx
call COMPARECHAR
; recupera cant de caracteres
push bx
push bx
push bx
; verifica
cmp al, 0FFh
jnz finComparar 
; si fueron iguales, repite
dec [bx]
inc cx
inc dx
jmp repetirComparar
; verifica si salió antes de tiempo o recorrio todas las claves y fueron iguales 
finComparar: cmp al, [bx]
jz clavesIguales
mov al, 00h
jmp final
clavesIguales: mov al, 0FFh
final: pop dx
pop cx
pop bx
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