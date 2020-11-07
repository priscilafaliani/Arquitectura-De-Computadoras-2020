; definir 2 variables, A y B, con valor 4 y 5 respectivamente
; definir variables C y D sin un valor
; calcular C = A + 2 * B y D = C / A + 1

.data
A: .word 4
B: .word 5
C: .word 0
D: .word 0

.code
; recupero A(r1) y B(r2)
ld r1, A(r0)
ld r2, B(r0)
; guardo dato inmediato 2(r3)
daddi r3, r0, 2
; resuelvo C = A + 2 * B
dmul r3, r3, r2
dadd r3, r3, r1
; guardo C
sd r3, C(r0)
; resuelvo D = C / A + 1
ddiv r3, r3, r1
daddi r3, r3, 1
; guardo D
sd r3, D(r0)

halt
