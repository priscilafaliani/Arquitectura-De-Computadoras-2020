; constants
pic equ 20h
pio equ 30h
timer equ 10h

; variables
org 1000h
flag db 0
counter db 0

; interruption set up
org 100
dw 3000h

; interruption subroutine
org 3000h
inc counter
cmp counter, 0FFh
jnz send
; envia las ultimas luces, deshabilita el timer y finaliza
mov al, counter
out pio + 1, al
inc flag
mov al, 0FFh
out pic + 1, al
jmp endInt
; envia las luces y resetea el timer
send: mov al, counter
out pio + 1, al
mov al, 0
out timer, al
endInt: mov al, pic
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
; timer
mov al, 1
out timer + 1, al
; leds
mov al, 00h
out pio + 3, al
mov al, 0
out pio + 1, al
; timer reset
out timer, al
sti

lazo: cmp flag, 1
jnz lazo

int 0
end