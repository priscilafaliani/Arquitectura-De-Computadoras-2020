; escribir un programa que multiplique dos numeros
; utilizando sumas repetidas
; debe estar optimizado para utilizar delay slot

  .data
A: .word 6
B: .word 3
res: .word 0

  .code
ld r1, A(r0)
ld r2, B(r0)

daddi r3, r0, 0
sumar:  daddi r2, r2, -1
        bnez r2, sumar
        dadd r3, r3, r1
sd r3, res(r0)
halt
