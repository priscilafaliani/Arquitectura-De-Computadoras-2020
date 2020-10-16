; constants
pio equ 30h

; variables
org 1000h
cant db 5
car db 0

; subroutines
org 3000h

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
mov bx, offset car
print: cmp cant, 0
jz fin
; lee
int 6
; envía a la impresora
mov al, [bx]
out pio + 1, al
call strobe0
call strobe1
; decrementa la cantidad de caracteres por leer
dec cant
jmp print
fin: int 0
end