; constants
EOI EQU 20h
IMR EQU 21h
IMRMASK EQU 11111100b ; timer y tecla f10
F10 EQU 24h
F10ID EQU 24
TIMER EQU 25h
TIMERID EQU 25
RCONT EQU 10h
RCOMP EQU 11h

; variables
org 1000h
; "básquet" clock
minutes1 db "0"
minutes2 db "0"
semicolon db ":"
seconds1 db "0"
seconds2 db "0"
jumpOfLine db 13
endClock db 0

; int subroutines
org 3000h
; pausa/reanuda/inicia el las interrupciones del timer
F10SR: push ax
in al, IMR
xor al, 00000010b
out IMR, al
; en cualquier caso, reinicia el contador
mov al, 0  
out RCONT, al
; imprime un mensaje
; end of interruption
mov al, EOI
out EOI, al
pop ax
iret

; lo primero que verifica es si llego a 00:31
; quiere decir que ya no tiene que contar más
; detiene el reloj, lo reinicia y espera a f10 para iniciar de nuevo
TIMERSR: push ax
cmp seconds1, 33h
jnz continuaReloj
mov seconds1, 30h
mov seconds2, 30h
in al, IMR
xor al, 00000010b
out IMR, al
jmp endTimer
; si llego a 00:09 o similar
; tiene que aumentar seconds1 y poner a 0 seconds2
; sino, solo incrementa seconds2
continuaReloj: cmp seconds2, 39h
jz incDec
inc seconds2
jmp print
incDec: inc seconds1 
mov seconds2, 30h
print: mov al, offset endClock - offset minutes1
int 7
; resets counter
mov al, 0
out RCONT, al
jmp endTimer
; end of interruption
endTimer: mov al, EOI
out EOI, al
pop ax
iret

; int vector set up
org 96
dw F10SR

org 100
dw TIMERSR

; PIC set up
org 2000h
cli
; mask 
mov al, IMRMASK
out IMR, al
; f10
mov al, F10ID
out F10, al
; timer
mov al, TIMERID
out TIMER, al
; timer comp
mov al, 1
out RCOMP, al
; timer cont
mov al, 0 
out RCONT, al
; for printing clock
mov bx, offset minutes1
sti 

cont: jmp cont

int 0
end