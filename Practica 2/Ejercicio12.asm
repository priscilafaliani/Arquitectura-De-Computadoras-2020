; constants
EOI EQU 20h
IMR EQU 21h
IMRMASK EQU 11111101B
TIMER EQU 25h
TIMERID EQU 25
RCONT EQU 10h
RCOMP EQU 11h

; variables
org 1000h
segundos db 0 

; timer subroutine
org 3000h
timerSR: int 7
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
mov al, 0
out RCONT, al
mov al, 1
out RCOMP, al
sti
