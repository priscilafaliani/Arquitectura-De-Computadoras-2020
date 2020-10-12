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

; variables
org 1000h
cantN db 0
num db 0


; int subroutines
org 3000h

; da inicio al timer
F10SR: in al, IMR
xor al, 11111100b
; incia contador del timer
mov al, 0
out RCONT, al
; end of interruption
mov al, EOI
out EOI, al
iret

; hace la cuenta regresiva
TIMERSR: cmp cantN, 0
jz stopCounting
cmp [bx], 30h
jnz print

; imprime el número
print: push bx
mov bx, offset num
mov al, cantN
int 7
pop bx
; end of interruption
stopCounting: mov al, EOI
out EOI, al
iret

; lee numeros en la direccion enviada por bx
; retorna en bx la dirección de fin del arreglo
; deja de leer cuando recibe un "enter" (13)
LEER: push ax
cmp al, 0
jz stop
repetir: int 6
cmp byte ptr [bx], 13
jz stop
inc bx
jnz repetir
stop: ret


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
; lee el número
mov bx, offset num
call LEER
; calcula la cantidad de caracteres
mov cantN, bx
sub cantN, offset num
; queda apuntando al último carácter
dec bx
sti

; espera que se inicie la cuenta atrás con f10
lazo: jmp lazo

int 0
end