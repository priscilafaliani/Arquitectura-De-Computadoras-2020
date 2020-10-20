; constants
PIC EQU 20h
HANDid EQU 26
HAND EQU 40h


; variables
org 1000h
    text db "UNIVERSIDAD NACIONAL DE LA PLATA"
    endT db 0

; subroutines
org 3000h
INTHAND:    in al, HAND + 1
            or al, 80h
            out HAND + 1, al
ret

HANDPIC:    cli
            mov al, 0FBh
            out PIC + 1, al
            mov al, HANDid
            out PIC + 6, al
            sti
ret

HANDSERVICE:    push ax
                cmp cl, 0
                jz finImpresion
                mov al, [bx]
                out HAND, al
                inc bx
                dec cl
                jmp finInt

finImpresion:   mov al, 0FFh
                out PIC + 1, al

finInt:         mov al, PIC
                out PIC, al
                pop ax
iret

; interruption service
org 104
dw HANDSERVICE

; ____ principal _____
org 2000h
    call INTHAND
    mov bx, offset text
    mov cl, offset endT - offset text
    call HANDPIC
    
    esperar: cmp cl, 0
    jnz esperar
int 0
end