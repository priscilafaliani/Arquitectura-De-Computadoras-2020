; constants
EOI EQU 20h
IMR EQU 21h
IMRMASK EQU 11111110b
INT0 EQU 24h
DIR EQU 24
; variables
org 1000h
letra db "A"
; interruption routine
org 3000h
int 7
push ax
mov al, EOI
out EOI, al
pop ax
iret
; [int0] int 24 vector content
org 96
dw 3000h
; principal program
org 2000h
; setting up PIC
cli
mov al, IMRMASK
out IMR, al
; setting up int0 register
mov al, DIR
out INT0, al
; setting up int 7
mov bx, offset letra
mov al, 1
sti
; loop trough letters until f10 is pressed
loop: cmp letra, 90
jz reboot
inc letra
jmp loop
reboot: mov letra, 65
jmp loop

int 0
end
