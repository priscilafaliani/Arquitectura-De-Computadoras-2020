; dadas dos variables A y B
; calcular el máximo entre las dos y guardar el resultado en C
; asumir que A = 4 y B = 10 para probar el ejercicio
.data
A: .word 10
B: .word 4
C: .word 0

.code
        ; guarda A y B en r1 y r2 respectivamente
        ld r1, A(r0)
        ld r2, B(r0)

        slt r3, r1, r2 ; r3 = 1, si r1 < r2
        bnez r3, mayorB ; si r3 = 1, es porque r1 < r2, o sea, r2 es el mayor
        sd r1, C(r0)
        j fin

mayorB: sd r2, C(r0)
fin:    halt
