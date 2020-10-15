; constants
PA EQU 30h
CA EQU 32h
PB EQU 31h
CB EQU 33h
ACONFIG EQU 0FFh ; llaves de entrada
BCONFIG EQU 00h ; luces de salida

; principal
org 2000h
; configurar
mov al, ACONFIG
out CA, al
mov al, BCONFIG
out CB, al
; loop infinito
loop: in al, PA
out PB, al
jmp loop

int 0
end