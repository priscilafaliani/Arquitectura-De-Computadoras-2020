; buscar numeros mayores que 10
; almacenar la cantidad en CANT
; generar otro arreglo complementario, res[1] corresponde tabla[1]
; res[1] = 0, indica que tabla[1] <= num
; res[1] = 1, indica que tabla[1] > num

  .data
numeros: .word 2, 5, 6, 16, 3, 37, 8, 12, 22, 18, 23, 14, 51
longitud: .word 13
num: .word 10
cant: .word 0
estado: .word 0

  .code
ld r1, num(r0)
ld r2, longitud(r0)
ld r3, cant(r0)
; desplazamiento
dadd r4, r0, r0

loop: beqz r2, fin
      ld r5, numeros(r4)

      slt r5, r1, r5      ; r1 <= r5 ? r5 = 1
      beqz r5, seguir
      daddi r3, r3, 1
      seguir: sd r5, estado(r4)
              daddi r2, r2, -1
              daddi r4, r4, 8
      j loop

fin: sd r3, cant(r0)
halt
