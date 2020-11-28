; contar la cantidad de veces que aparece un caracter en un string

    .data
cadena: .asciiz "asifasdaghalsjdkl"
char: .asciiz "a"
cant: .word 0

    .code
; char
ld r1, char(r0)
; cant
dadd r2, r0, r0
; desplazamiento
dadd r3, r0, r0

loop:   lbu r4, cadena(r3)
        beqz r4, fin
        daddi r3, r3, 1
        beq r4, r1, sumar
        j loop
        sumar: daddi r2, r2, 1
        j loop
fin: sd r2, cant(r0)
      halt
