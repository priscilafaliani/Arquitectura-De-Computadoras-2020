; constants
pio equ 30h

; variables
org 1000h
msj db "ORGANIZACION Y ARQUITECTURA DE COMPUTADORAS"
finMsj db 0

; subroutines
org 3000h
; setea bit0 de PA como de lectura y bit1 como de escritura
; setea el registro PB como de escritura
config_pio: mov al, 0FDH 
out pio + 2, al 
mov al, 00h
out pio + 3, al 
ret

; "retorna" true cuando busy = 0
poll: in al, pio
and al, 01h
jnz poll
ret

; setea el bit de strobe (PA1) a 0
strobe0: in al, pio
and al, 0FDh
out pio, al
ret

; seteal el bit de strobe (PA1) a 1
strobe1: in al, pio
or al, 02h
out pio, al
ret

; principal
org 2000h
call config_pio

mov bx, offset msj
mov cl, offset finMsj - offset msj
imprimirCar: call poll
cmp cl, 0
jz fin
mov al, [bx]
out pio + 1, al
call strobe0
call strobe1
inc bx
dec cl
jmp imprimirCar
fin: int 0
end