; constants
EOI EQU 20h
IMR EQU 21h
IMRMASK EQU 11111101b
TIMER EQU 25h
TIMERID EQU 25
RCONT EQU 10h
RCOMP EQU 11h

; clock formatted as 00:00
org 1000h
minutos1 db "0"
minutos2 db "0"
semicolon db ":"
segundos1 db "0"
segundos2 db "0"
jumpOfLine db 0Dh
finClock db 0

; activate/deativate subroutine
org 3000h
mov al, offset finClock - offset minutos1
int 7
mov al, 0
out RCONT, al
mov al, EOI
out EOI, al
iret

; int vector set up
org 100
dw 3000h

; pic and timer set up
org 2000h
cli
mov al, IMRMASK
out IMR, al
mov al, TIMERID
out TIMER, al
mov al, 10
out RCOMP, al
mov al, 0
out RCONT, al
mov bx, offset minutos1
sti

lazo: cmp segundos2, 39h
jz compareSeg1
inc segundos2
jmp lazo
compareSeg1: cmp segundos1, 35h
jz compareMin2
mov segundos2, 30h
inc segundos1
jmp lazo
compareMin2: cmp minutos2, 39h
jz compareMin1
inc minutos2
mov segundos1, 30h 
mov segundos2, 30h
jmp lazo
compareMin1: cmp minutos1, 35h
jz fin
inc minutos1
mov minutos2, 30h
mov segundos1, 30h
mov segundos2, 30h
jmp lazo

fin: int 0
end