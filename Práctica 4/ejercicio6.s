; escribir un programa que lea tres números enteros A, B y C de memoria
; y determine cuantos son iguales entre sí (0, 2 o 3)
; el resultado debe quedar almacenado en D

  .data
A: .word 2
B: .word 2
C: .word 2
D: .word 0
  .code
; numbers
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
; result
dadd r4, r0, r0
; for comparision
daddi r5, r0, 2

         bne r1, r2, seguir1    ; A = B ?
         daddi r4, r4, 2
seguir1: bne r1, r3, seguir2    ; A = C ?
         beq r4, r5, sumar1
         daddi r4, r4, 2
seguir2: bne r2, r3, fin        ; B = C ?
         beq r4, r5, sumar1
         daddi r4, r4, 2

sumar1: daddi r4, r4, 1
fin: sd r4, D(r0)
  halt
