; definir un vector de 3 numeros V
; calcular la suma de los numeros del vector, sin saltos
; guardar el resutlado en C
; asumir que V = {2, 8, 16}

.data
V: .word 2, 8, 16
C: .word 0

.code
daddi r1, r0, 0

ld r2, V(r1) ; r2 = 2
daddi r1, r1, 8
ld r3, V(r1) ; r3 = 8

dadd r2, r2, r3  ; r2 = 2 + 8
daddi r1, r1, 8

ld r3, V(r1) ; r3 = 16
dadd r2, r2, r3 ; r2 = 10 + 16

daddi r1, r1, 8
sd r2, V(r1) ; c = 26


halt
