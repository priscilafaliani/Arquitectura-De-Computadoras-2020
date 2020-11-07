; analizar el siguiente código

.data
A: .word 1
B: .word 2

.code
ld r1, A(r0)
ld r2, B(r0)
sd r2, A(r0)
sd r1, B(r0)
halt

; analizar con fowarding deshabilitado

; la instrucción que genera atascos es la 3. Porque necesitan el valor de r2
; antes de que esté disponible.

; aparecen atascos de tipo RAW

; el CPI es de 2.20

; analizar con fowarding habilitado

; ahora no se producen atascos porque:
; la instruccion 3, precisa del operador en la etapa MEM
; y la instrucción 2, en su etapa MEM, guardo el dato en un buffer.

; el color en los registros indica que se está escribiendo/leyendo de los registros.
; ahora tiene un CPI de 1.8
