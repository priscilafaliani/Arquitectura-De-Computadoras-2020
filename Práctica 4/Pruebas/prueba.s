; sección de variables
.data
A: .word 5

; sección de código.
.code
daddi r1, r0, 4
ld r2, A(r0)
daddi r1, r1, r2

loop: daddi r1, r1, -1
      bnez r1, loop

halt
