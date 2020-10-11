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
min db "0"
min2 db "0"
semicolon db ":"
seg db "0"
seg2 db "0"
enterA db 0Dh
finReloj db ?

; timer subroutine
org 3000h
; si llego al 00:09 (o similar)
timerSR: cmp seg2, 39h
jz checkSegundos1
inc seg2
jmp print
; si llego al 00:59
checkSegundos1: cmp seg, 35h
jz fin
; si no, incrementa 00:*0*0 y reinicia 00:0*0*
inc seg
mov seg2, 30h
print: int 7
mov al, 0
; reinicia el contador
out RCONT, al
mov al, EOI
out EOI, al
fin: iret

; int vector set up
org 100
dw timerSR

; pic and timer set up
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
mov bx, offset min
mov al, offset finReloj - offset min
sti

count: jmp count

hlt
end
