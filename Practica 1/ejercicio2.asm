; Si el registro SP vale 8000h al comenzar
; indicar el valor de SP luego de cada instrucción
; la ejecución comienza a partir de 2000h

org 3000h
  rutina: mov bx, 3 ; SP = 7FFCh
  ret ; SP = 7FFCEh
org 2000h
  push ax     ; SP = 7FFEh
  call rutina ; SP = 7FFCh
  pop bx      ; SP = 8000h
hlt
end
