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

; timer subroutine
org 3000h
; si llego al 00:09 (o similar)
timerSR: cmp segundos2, 39h
jz checkSegundos1
inc segundos2
jmp print
; si llego al 00:59
checkSegundos1: cmp segundos1, 35h
jz fin
; si no, incrementa 00:*0*0 y reinicia 00:0*0*
inc segundos1
mov segundos2, 30h
print: mov al, offset finReloj - offset minutos1
int 7
mov al, 0
; reinicia el contador
out RCONT, al
mov al, EOI
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

count: jmp count

fin: int 0
end