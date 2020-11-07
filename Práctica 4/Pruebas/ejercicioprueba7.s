; definir un vector de 3 numeros V
; calcular la suma de los numeros del vector, con saltos
; guardar el resutlado en C
; asumir que V = {2, 8, 16}

.data
V: .word 2, 8, 16, -3, 2, 55, 3
C: .word 0

.code
; desplazador
daddi r1, r0, 0
; resultado
daddi r3, r0, 0
; elementos del vector
daddi r4, r0, 7

; sumas
loop: ld r2, V(r1)
      dadd r3, r3, r2
      daddi r1, r1, 8
      daddi r4, r4, -1
      bnez r4, loop

sd r3, C(r0)
halt
