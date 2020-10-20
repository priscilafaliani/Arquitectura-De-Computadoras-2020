; constants
pic equ 20h
pio equ 30h

; variables
org 1000h
flag db 0
cantCar db 0
msj db 0

; interruption subroutines
org 96
dw 3500h

; interruption managment
org 3500h
mov al, 0FFh
out pic + 1, al
mov flag, 1
mov al, pic
out pic, al
iret

; pic config
config_f10: mov al, 0FEh
out pic + 1, al
mov al, 24
out pic + 4, al
ret


; printer subroutines
org 3000h
config_pio: mov al, 0FDh
out pio + 2, al
mov al, 00h
out pio + 3, al
ret

poll: in al, pio
and al, 01h
jnz poll
ret


strobe0: in al, pio
and al, 0FDh
out pio, al
ret


strobe1: in al, pio
or al, 02h
out pio, al
ret


; principal
org 2000h
cli
call config_f10
call config_pio
sti

mov bx, offset msj
read: cmp flag, 1
jz preparePrint
int 6
inc bx
inc cantCar
jmp read

preparePrint: mov bx, offset msj
mov cl, cantCar

printCar: cmp cl, 0
jz fin
mov al, [bx]
out pio + 1, al
call strobe0
call strobe1
inc bx
dec cl
jmp printCar

fin: int 0
end