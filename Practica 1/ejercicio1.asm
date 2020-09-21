; si el registro SP vale 8000h al iniciar el programa
; indicar el valor del registro SP luego de cada instrucción
; indicar los valores de ax y bx
org 2000h
  mov ax, 5 ; SP = 8000h, AX = 5, BX = ?
  mov bx, 3 ; SP = 8000h, AX = 5, BX = 3
  push ax   ; SP = 7FFEh, AX Y BX SE MANTIENEN.
  push ax   ; SP = 7FFCh
  push bx   ; SP = 7FFAh
  pop bx    ; SP = 7FFCh
  pop bx    ; SP = 7FFEh
  pop ax    ; SP = 8000h
hlt
end
