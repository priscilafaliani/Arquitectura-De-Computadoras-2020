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
flag db 0
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
TIMERSR: cmp cantN, 2
push bx
jz restaSimple
; si tengo que hacer 0 - 1
; simula el proceso de pedir al companero (o a los companeros)
repetir: cmp byte ptr [bx], 30h
jnz restaSimple
mov byte ptr [bx], 39h
dec bx
jmp repetir
restaSimple: dec byte ptr [bx]
pop bx
; el primer digito quedo en cero? entonces lo quito porque no es significativo
push bx
mov bx, dx
cmp byte ptr [bx], 30h
pop bx
; si no era cero, puedo imprimir
jnz finCrearNumero
inc dx
push bx
mov bx, dx
cmp byte ptr [bx], 13
pop bx
jz finCuentaAtras
dec cantN
; imprime el numero 
finCrearNumero: push bx
mov bx, dx
mov al, cantN
int 7
pop bx
jmp finTimer
; cuando llega a 0 detiene el timer e imprime el 0 final
finCuentaAtras: mov flag, 1
in al, IMR
xor al, 00000011b
out IMR, al
mov al, 1
int 7
; end of interruption
finTimer: mov al, 0
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
mov al, 2
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

; espera que se inicie la cuenta atras con f10 o que termine la cuenta atras
lazo: cmp flag, 1
jnz lazo

int 0
END
