; constants
PA EQU 30h
CA EQU 32h

; variables
org 1000h
on db "Llave encendida"
endOn db 0
off db "Llave apagada"
endOff db 0

; principal
org 2000h
; activo la llave, para poder cambiarla
mov al, 80h
out CA, al
; verifico si está encedida o apagada
in al, PA
and al, 80h
; imprimo según corresponda
jz keyOff
mov bx, offset on
mov al, offset endOn - offset on
int 7
jmp fin
keyOff: mov bx, offset off
mov al, offset endOff - offset off
int 7
fin: int 0
end