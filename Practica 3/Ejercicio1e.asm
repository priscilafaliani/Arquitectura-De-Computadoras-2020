; constants
pic equ 20h
pio equ 30h
timer equ 10h

; variables
org 1000h
counter db 1

; interruption set up
org 100
dw SENDLEDS

org 3000h
; recibe un byte y lo rota a la izquierda (equivalente a multiplicar por 2)
; recibe en bx la direccion del byte
shiftLleft: push ax
mov ah, [bx]
add ah, ah
adc ah, 0
mov byte ptr [bx], ah
pop ax
ret

; interruption subroutine
SENDLEDS: mov al, counter
out pio + 1, al
mov bx, offset counter
call shiftLleft
cmp counter, 0
jnz seguir
mov counter, 1
seguir: mov al, 0
out timer, al
mov al, pic
out pic, al
iret

; principal
org 2000h
cli
; mask
mov al, 0FDh
out pic + 1, al
; int1
mov al, 25
out pic + 5, al
; timer comp
mov al, 1
out timer + 1, al
; leds
mov al, 0
out pio + 3, al
out pio + 1, al
; timer cont
out timer, al
sti

lazo: jmp lazo

int 0
end