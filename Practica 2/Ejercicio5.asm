org 1000h
msj db "Ingrese un numero: "
finMsj db ?
msjNumInvalido db "Caracter no valido"
finMsjInvalido db ?
num db ?

org 3000h
; recibe en bx la dirección del caracter para chequear
; retorna en al 0FFh si es digito, si no retorna 00h
ESNUMERO: cmp byte ptr [bx], 48
  js noEs
  mov al, 57
  cmp al, [bx]
  js noEs
  mov al, 0FFh
  jmp fin
noEs: mov al, 00h
fin: ret

org 2000h
; prompt
mov bx, offset msj
mov al, offset finMsj - offset msj
int 7

; read
mov bx, offset num
int 6

; check
; no paso parametros porque la dir del caracter ya esta en bx
call ESNUMERO

; print
cmp al, 00h
jz print
; era un numero
mov al, 1
int 7
jmp finPrograma

; no era un numero
print: mov al, offset finMsjInvalido - offset msjNumInvalido
mov bx, offset msjNumInvalido
int 7

finPrograma: int 0
end
