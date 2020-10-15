pio equ 30h

org 1000h
car db "A"

org 2000h
; configuro el pio
mov al, 0FDh
out pio + 2, al
mov al, 00h
out pio + 3, al

loop:   in al, pio
        and al, 01h
        jnz loop
        
mov al, car
out pio + 1, al
; strobe
in al, pio
or al, 00000010b
out pio, al

int 0
end