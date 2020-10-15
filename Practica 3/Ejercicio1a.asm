PB EQU 31h
CB EQU 33h
MASK EQU 00h

org 1000h
patron db 11000011b

org 2000h
mov al, MASK
out CB, al
mov al, patron
out PB, al

int 0
end