; definir un vector de 3 numeros V
; calcular el maximo de los numeros del vector, con saltos
; sin utilizar desplazamiento, sino un registro puntero
; guardar el resutlado en C
; asumir que V = {2, 8, 16}

.data
V: .word 2, 8, 16, 2, 55, 3, 100, 99
C: .word 0

.code
; puntero
daddi r1, r0, V
; resultado
daddi r3, r0, 0
; elementos del vector
daddi r4, r0, 9

; maximo
loop:   ld r2, 0(r1)
        slt r5, r3, r2
        bnez r5, mayor
        j cont
mayor:  dadd r3, r0, r2
cont:   daddi r1, r1, 8
        daddi r4, r4, -1
        bnez r4, loop

sd r3, C(r0)
halt
