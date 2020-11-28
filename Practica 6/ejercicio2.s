    .data
CONTROL: .word32 0x10000
DATA:    .word32 0x10008
CERO:    .asciiz "cero"
UNO:     .asciiz "uno"
DOS:     .asciiz "dos"
TRES:    .asciiz "tres"
CUATRO:  .asciiz "cuatro"
CINCO:   .asciiz "cinco"
SEIS:    .asciiz "seis"
SIETE:   .asciiz "siete"
OCHO:    .asciiz "ocho"
NUEVE:   .asciiz "nueve"

    .code
; constantes
lwu $s0, CONTROL($zero)
lwu $s1, DATA($zero)

jal leer
dadd $a0, $v0, $zero
jal mostrar

    halt

; lee digitos entre 0 y 9, si no es valido sigue insistiendo (?)
; retorna en $v0
leer: daddi $t0, $zero, 8   ; cod lectura
      daddi $t1, $zero, 9   ; para comparar
repetir:    sd $t0, 0($s0)  ; lee y guarda
            ld $t2, 0($s1)
            sltu $t3, $t1, $t2 ; compara
            beqz $t3, fin
            j repetir
fin: dadd $v0, $t2, $zero
     jr $ra

; muestra el string correspondiente a un digito
; recibe en $a0 el digito
mostrar: dadd $t0, $a0, $zero
         daddi $t8, $zero, 8
         daddi $t2, $zero, 4 ; cod impresion asciiz
         dmul $t0, $t0, $t8  ; obtengo el desplazamiento         
         daddi $t0, $t0, CERO
         sd $t0, 0($s1)
         sd $t2, 0($s0)
jr $ra
