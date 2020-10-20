; constants
USART EQU 60h

; variables
org 1000h
char db "A"

; subroutines
org 3000h

DTRprotocol:    mov al, 51h
                out USART + 2, al
ret


USARTisready:   in al, USART + 2
                and al, 01h
                jz USARTisready
ret

DEVICEisready:  in al, USART + 2
                and al, 80h
                jz DEVICEisready
ret

CANsend:    call USARTisready
            call DEVICEisready
ret

; ____ principal ____
org 2000h
    call DTRprotocol
    call CANsend
    mov al, char
    out USART + 1, al
int 0
end