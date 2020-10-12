; constants
EOI EQU 20h
IMR EQU 21h
IMRMASK EQU 11111101B
TIMER EQU 25h
TIMERID EQU 25
RCONT EQU 10h
RCOMP EQU 11h

; reloj con formato 00:00
org 1000h
minutos1 db 30h
minutos2 db 30h
semicolon db ":"
segundos1 db 30h
segundos2 db 30h
enterA db 0Dh
finReloj db 0
flag db 0

; timer subroutine
org 3000h
; si llego a 00:60 no se tiene que imprimir!
timerSR: cmp segundos1, 35h
jz compareMinutos2
inc segundos1
jmp print
; si llego a 09:60 no se tiene que imprimir!
compareMinutos2: cmp minutos2, 39h
jz compareMinutos1 
inc minutos2
mov segundos1, 30h
jmp print
; si llego a 69:60 no tiene que imprimir!
compareMinutos1: cmp minutos1, 35h
jz fin 
inc minutos1
mov minutos2, 30h
mov segundos1, 30h
print: mov al, offset finReloj - offset minutos1
int 7
; reinicia el contador
mov al, 0
out RCONT, al
jmp seguir
fin: mov flag, 1
seguir: mov al, EOI
out EOI, al
iret

; int vector set up
org 100
dw timerSR

; interruptions set up
org 2000h
cli
mov al, IMRMASK
out IMR, al
mov al, TIMERID
out TIMER, al
mov al, 1
out RCOMP, al
mov al, 0
out RCONT, al
mov bx, offset minutos1
sti

count: cmp flag, 1
jnz count

int 0
end