; indicar que tipo de pasaje de parametros son

; 1 -> pasaje de parámetro por registro, por valor.
mov ax, 5
call subrutina

; 2 -> pasaje de parámetro por registro, por referencia
mov dx, offset A
call subrutina

; 3 -> pasaje de parámetro por stack, por valor
mov bx, 5
push bx
call subrutina
pop bx

; 4 -> pasaje de parametro por stack, por referencia
mov cx, offset A
push cx
call subrutina
pop cx

; 5 -> pasaje de parametro por registro, por valor
mov dl, 5
call subrutina

; 6 -> pasaje de parametro por registro, por valor
call subrutina
mov A, dx
