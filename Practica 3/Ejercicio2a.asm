pio equ 30h

org 1000h
car db "A"

org 3000h
config_pio: mov al, 01h
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


org 2000h
; configuro el pio
call config_pio
call poll
        
mov al, car
out pio + 1, al

call strobe0
call strobe1

int 0
end