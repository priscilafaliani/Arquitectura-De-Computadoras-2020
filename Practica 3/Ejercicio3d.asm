; constants
HAND EQU 40h

; ____variables____
org 1000h
    cant dw 0005h
    prompt db "Ingrese 5 caracteres: "
    endP db 0
    normal db "Se imprime en el mismo orden: "
    endN db 13
    reverse db "Se imprime en reversa: "
    endR db 13
    string db 0

; _____subroutines____
org 3000h

; recibe en bx la dir de comienzo para guardar
; en al la cantidad de caracteres a leer

READ:   cmp al, 0
        jz finR
repeat: int 6
        inc bx
        dec al
        jnz repeat        
finR: ret

POLLINGHAND:    in al, HAND + 1
                and al, 7Fh
                out HAND + 1, al
ret

POLL:   in al, HAND + 1
        and al, 01h
        jnz POLL
ret


; ____ principal ____
org 2000h
    ; prompts user
    mov bx, offset prompt
    mov al, offset endP - offset prompt
    int 7

    ; reads string
    mov bx, offset string
    mov al, cant
    call READ
    ; agrega salto de linea al final
    mov word ptr [bx], 13

    call POLLINGHAND

    ; prompts user
    mov bx, offset normal
    mov al, offset endN - offset normal
    inc al
    int 7

    ; prints in normal way
    mov bx, offset string
    mov cl, cant
    ; para que imprima el salto de linea
    inc cl

printN:  cmp cl, 0
        jz printReverse
        call POLL
        mov al, [bx]
        out HAND, al
        dec cl
        inc bx
        jmp printN

    ; prompts user
printReverse:    mov bx, offset reverse
                 mov al, offset endR - offset reverse
                 int 7

    ; prints in reverse
    mov bx, offset string
    add bx, cant
    ; para que no comience desde el salto de linea
    dec bx
    mov cl, cant

printR:   cmp cl, 0
          jz fin
          call POLL
          mov al, [bx]
          out HAND, al
          dec cl
          dec bx
          jmp printR

fin: int 0
end