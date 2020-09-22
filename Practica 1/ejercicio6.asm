; Multiplicar dos numeros desde el programa principal

org 1000h

num1 dw 2
num2 dw 2
res dw 0

org 2000h

mov ax, 0
mov bx, num2

mul: cmp bx, 0
jz store
add ax, num1
dec bx
jmp mul

store: mov res, ax

hlt
end
