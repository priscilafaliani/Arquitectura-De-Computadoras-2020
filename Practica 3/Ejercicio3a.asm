; constants
DREGHAND EQU 40h
SCREGHAND EQU 41h

; variables
org 1000h
    text db "INGENIERIA E INFORMATICA"
    endT db 0

; subroutines
POLLINGHAND:    in al, SCREGHAND
                and al, 7Fh
                out SCREGHAND, al
ret

POLL:   in al, SCREGHAND 
        and al, 01h
        jnz POLL
ret

; ____principal____
org 2000h
    call POLLINGHAND
    mov cl, offset endT - offset text
    mov bx, offset text
loop:   cmp cl, 0
        jz fin
        call POLL
        mov al, [bx]
        out DREGHAND, al
        inc bx
        dec cl
        jmp loop
fin: int 0
end