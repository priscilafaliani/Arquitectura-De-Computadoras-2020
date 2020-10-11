EOI EQU 20h
IMR EQU 21h
IMRMASK EQU 0FEh
INT0 EQU 24h
DIR EQU 10

org 1000h
cant db  0

; INT 10
org 3000h
	inc cant
	mov al, EOI
	out EOI, al
	iret
; content of INT 10
org 40
	dw 3000h
; principal program
org 2000h
; setting up PIC
cli
mov al, IMRMASK
out IMR, al
mov al, DIR
out INT0, al
sti
; end of setting
; the program never ends
loop: jmp loop
int 0
end
