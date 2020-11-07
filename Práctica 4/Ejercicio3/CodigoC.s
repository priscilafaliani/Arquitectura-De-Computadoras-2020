.data
A: .word 1
B: .word 3
arr: .word 0

.code
dadd r3, r0, r0 ; desplazamiento del arreglo

ld r2, B(r0)
ld r1, A(r0)

loop: daddi r2, r2, -1
      dsll r1, r1, 1
      dadd r4, r0, r1
      sd r4, arr(r3)
      daddi r3, r3, 8
      bnez r2, loop

halt
