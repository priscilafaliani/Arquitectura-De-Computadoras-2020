; contar numero de caracteres de una cadena termianda en 00h

org 1000h
cadena db "HolaComoEstas"
finCadena db 0
res dw ?
org 3000h
; recibe la direccion de la cadena por bx
; retorna por dx
LONGITUD: mov dx, 0
contar: mov ah, [bx]
cmp ah, 0
jz fin
inc dx
inc bx
jmp contar
fin: ret

org 2000h
mov bx, offset cadena
call LONGITUD
mov res, dx
hlt
end

; contar minusculas en una cadena

org 1000h
cadena db "HolaComoEstas??"
finCadena db 0
res dw ?
min db "a"
max db "z"

org 3000h
; recibe la direccion de la cadena por bx
; retorna por dx
CONTAR_MINUS: mov dx, 0
contar: mov ah, [bx]
cmp ah, 0 ; verifica si llego al fin de la cadena
jz fin
cmp ah, min ; verifica si es una minuscula
js seguir
cmp max, ah
js seguir
inc dx  ; incrementa si es minuscula
seguir: inc bx
jmp contar
fin: ret

org 2000h
mov bx, offset cadena
call CONTAR_MINUS
mov res, dx
hlt
end

; subrutina que dice si un caracter es vocal
org 1000h
vocales db "AEIOUaeiou"
fin_vocales db 0
car db "a"
resultadoVocal db ?

org 3000h
; utiliza un array de vocales almacenado en memoria
; recibe un caracter por el registro al
; retorna por cl OFFh si es vocal o 00H de caso contrario
ES_VOCAL: mov bx, offset vocales
mov ah, 00h
contarVocales: mov cl, [bx]
cmp cl, 0
jz finVocales ; si llego al final del arreglo, no es vocal
cmp cl, al
jz esVocal ; si la comapracion dio 0, entonces al = una vocal
inc bx
jmp contarVocales
esVocal:mov cl, 0FFh
finVocales: ret

org 2000h
mov al, car
call ES_VOCAL
mov resultadoVocal, cl
hlt
end

; programa que cuenta las vocales de una cadena
org 1000h
vocales db "AEIOUaeiou"
fin_vocales db 0
cadena db "contareiquos1#!"
fin_cadena db 0
cant_vocales db ?

org 3000h
; utiliza un array de vocales almacenado en memoria
; recibe un caracter por el registro al
; retorna por ah OFFh si es vocal o 00H de caso contrario
ES_VOCAL: push bx ; salva a bx
mov bx, offset vocales
contarVocales: mov ah, [bx]
cmp ah, 0
jz noVocal ; si llego al final del arreglo, no es vocal
cmp ah, al
jz esVocal ; si la comparacion dio 0, entonces al = una vocal
inc bx
jmp contarVocales
esVocal: mov ah, 0FFh
jmp fin
noVocal: mov ah, 00h
fin: pop bx
ret

; recibe la direccion de una cadena por bx
; retorna cantidad de vocales por dx
CONTAR_VOCALES: mov dx, 0
contar: mov al, [bx]
cmp al, 0
jz finContarVocales ; si llego al final de la cadena
call ES_VOCAL
cmp ah, 0 ; verifica si es vocal
jz continuar
inc dx
continuar: inc bx
jmp contar
finContarVocales: ret

org 2000h
mov bx, offset cadena
call CONTAR_VOCALES
mov cant_vocales, dx
hlt
end

; cuenta la cantidad de veces que aparece un caracter x
; en una cadena
org 1000h
cadena db "cntreiquos1#!"
fin_cadena db 0
car db "a"
res db 0

org 3000h
; recibe la direccion de una cadena por la pila
; recibe un caracter por la pila
; retorna por referencia por la pila
CONTAR_CAR: push bx ; salva los registros para usarlos
push ax
push dx
; recupera los datos
mov bx, sp
add bx, 8
mov dx, [bx] ; guarda la direccion del resultado
add bx, 2
mov al, [bx] ; guarda el caracter para comparar
add bx, 2
mov bx, [bx] ; guarda la direccion de la cadena
contar: mov ah, [bx] ; guarda el caracter de la cadena
cmp ah, 0
jz fin ; si llego al final de la cadena
cmp ah, al
jnz seguir ; si no es el caracter
push bx
mov bx, dx
inc byte ptr [bx]
pop bx
seguir: inc bx
jmp contar
fin: pop dx ; devuelve los registros
pop ax
pop bx
ret

org 2000h
mov ax, offset cadena
push ax
mov ax, car
push ax
mov ax, offset res
push ax
call CONTAR_CAR
pop ax
pop ax
pop ax
hlt
end

; cambia los caracteres x por los y en una cadena
org 1000h
cadena db "pineapple"
fin_cadena db 0
original db "e"
remplazo db "u"

org 3000h
; recibe un caracter por valor por la pila
; recibe el remplazo del caracter por valor por la pila
; recibe la direccion de una cadena por la pila
REMPLAZAR_CARACTER: push ax ; salva los registros
push bx
push cx
push dx
; recupera los datos
mov bx, sp
add bx, 10
mov al, [bx] ; caracter para remplazar
add bx, 2
mov ah, [bx] ; caracter a reemplazar
add bx, 2
mov bx, [bx] ; cadena
remplazar: mov cl, [bx]
cmp cl, 0
jz fin
cmp cl, original
jnz seguir
mov byte ptr [bx], al
seguir: inc bx
jmp remplazar
fin: pop dx ; retorna los registros
pop cx
pop bx
pop ax
ret

org 2000h
mov ax, offset cadena
push ax
mov ax, original
push ax
mov ax, remplazo
push ax
call REMPLAZAR_CARACTER
pop ax
pop ax
pop ax
hlt
end
