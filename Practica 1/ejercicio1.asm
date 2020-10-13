; si el registro SP vale 8000h al iniciar el programa
; indicar el valor del registro SP luego de cada instrucción
; indicar los valores de ax y bx
org 2000h
  mov ax, 5 ; SP = 8000h, AX = 5, BX = ?
  mov bx, 3 ; SP = 8000h, AX = 5, BX = 3
  push ax   ; SP = 7FFEh -> 5, AX = 5, BX = 3
  push ax   ; SP = 7FFCh -> 5, AX = 5, BX = 3
  push bx   ; SP = 7FFAh -> 3 AX = 5, BX = 3
  pop bx    ; SP = 7FFCh -> 5, BX = 3, AX = 5
  pop bx    ; SP = 7FFEh -> 3, BX = 5, AX = 5
  pop ax    ; SP = 8000h BX = 5, AX = 5
hlt
end
