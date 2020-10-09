; ejercicio a) y b)
org 1000h
num db 15

org 3000h
; recibe un byte y lo rota a la izquierda (equivalente a multiplicar por 2)
; recibe en bx la direccion del byte
shiftLleft: push ax ; salva el contenido de ax
mov ah, [bx]
add ah, ah
adc ah, 0
mov byte ptr [bx], ah
pop ax ; retorna los valores de ax
ret

; rota a la izquieda n veces
; recibe a n por al
; recibe la direccion del byte por bx
nShiftLeft: cmp al, 0
jz fin
call shiftleft
dec al
jmp nShiftLeft
fin: ret

org 2000h
mov bx, offset num
mov al, 2
call shiftleft
hlt
end
; al final num = 60
