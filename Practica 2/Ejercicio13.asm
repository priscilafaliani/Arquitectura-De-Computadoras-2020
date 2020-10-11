; constants
EOI EQU 20h
IMR EQU 21h
IMRMASK EQU 11111100b
F10 EQU 24h
F10ID EQU 24
TIMER EQU 25h
TIMERID EQU 25
RCONT EQU 10h
RCOMP EQU 11h

; clock formatted as 00:00
org 1000h
minutos1 db 30h
minutos2 db 30h
segundos1 db 30h
segundos2 db 30h
finClock db 0

; activate/deativate subroutine
org 3000h
CLOCKROUTINE: 
mov al, EOI
out EOI, al
iret

; int vector set up
org 100
dw TIMERSR

; pic and timer set up
org 2000h
cli
mov al, IMRMASK
out IMR, al
mov al, F10ID
out F10, al
mov al, TIMERID
out TIMER, al
mov al, 10
out RCOMP, al
mov al, 0
out RCONT, al
sti

int 0
end