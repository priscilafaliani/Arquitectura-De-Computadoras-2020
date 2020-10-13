; constants
EOI EQU 20h
IMR EQU 21h
IMRMASK EQU 11111110b
F10 EQU 24h
F10ID EQU 24
TIMER EQU 25h
TIMERID EQU 25
RCONT EQU 10h
RCOMP EQU 11h

; variables
org 1000h
cantN dw 0
num db 0

; int vector set up
org 96
dw F10SR

org 100
dw TIMERSR

; int subroutines
org 3000h

; da inicio al timer
F10SR: in al, IMR
xor al, 00000011b
out IMR, al
; incia contador del timer
mov al, 0
out RCONT, al
; end of interruption
mov al, EOI
out EOI, al
iret

; hace la cuenta regresiva
TIMERSR: push bx
mov bx, dx
; si llego al final del numero
cmp bx, 13
pop bx
jz finCuentaAtras
push bx
; si tengo que hacer 0 - 1
; simula el proceso de pedir al companero (o a los companeros)
repetir: cmp byte ptr [bx], 30h
jnz restaSimple
mov byte ptr [bx], 39h
dec bx
; es necesario pedir a otro?
jmp repetir
restaSimple: dec byte ptr [bx]
mov bx, dx
; el primer digito es cero? entonces lo quito
cmp byte ptr [bx], 30h
pop bx
jnz finCrearNumero
inc dx
dec cantN
finCrearNumero: push bx
mov bx, dx
mov al, cantN
int 7
pop bx
; end of interruption
finCuentaAtras: mov al, 0
out RCONT, al
mov al, EOI
out EOI, al
iret

; lee numeros en la direccion enviada por bx
; retorna en bx la direccion de fin del arreglo
; deja de leer cuando recibe un "enter" (13)
LEER: push ax
cmp al, 0
jz stop
repetirLeer: int 6
cmp byte ptr [bx], 13
jz stop
inc bx
jnz repetirLeer
stop: pop ax
ret


; PIC set up
org 2000h
cli
; imr
mov al, IMRMASK
out IMR, al
; int0
mov al, F10ID
out F10, al
; int1
mov al, TIMERID
out TIMER, AL
; comp
mov al, 1
out RCOMP, al
; lee el numero
mov bx, offset num
call LEER
; guarda la direccion de comienzo
mov dx, offset num
; guarda la cantidad de numeros
mov cantN, bx
sub cantN, dx
inc cantN ; para que cuando imprima de el salto de linea
; queda apuntando al ultimo caracter
dec bx
sti
; espera que se inicie la cuenta atras con f10
lazo: jmp lazo

HLT
END
