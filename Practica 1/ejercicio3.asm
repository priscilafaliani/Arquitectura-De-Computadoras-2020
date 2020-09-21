; indicar el contenido de la pila luego de cada instrucción
; si es desconocido indicar con ?
org 3000h
rut: mov bx 3   ; 1er call: PILA = 2002h 2do call: PILA = 2006h
 ret            ; PILA = ?
org 2000h
 call rut ; PILA = 2002h
 add cx, 5  ; PILA = ?
 call rut ; PILA = 2006h
hlt ; PILA = ?
end.


; explicar que acciones realizan "call rut" y "ret"
CALL -> hace push del ip al stack
RET -> hace pop en el ip desde el stack
