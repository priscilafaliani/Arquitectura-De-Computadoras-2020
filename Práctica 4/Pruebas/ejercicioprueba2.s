; definir 2 variables, A y B, con valores 4 y 5 respectivamente
; definir una variable C, sin valores
; sumar A y B y guardar el resultado en C
.data
A: .byte 4
B: .byte 5
C: .byte 0

.code
ld r1, A(r0)
ld r2, B(r0)
dadd r1, r1, r2
sd r1, C(r0)

halt
