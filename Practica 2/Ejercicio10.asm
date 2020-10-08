org 1000h
cant db  0

org 3000h
	inc cant
	mov al, 20h
	out 20h, al
	iret

org 40
	dw 3000h

org 2000h
cli
	mov al, 0FEh
	out 21h, al
	mov al, 10
	out 24h, al
sti

loop: jmp loop

int 0
end
