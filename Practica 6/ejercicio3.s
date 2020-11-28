    .data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008

    .code
; constantes
lwu $s0, CONTROL($zero)
lwu $s1, DATA($zero)

jal leer
dadd $a0, $v0, $zero
jal leer
dadd $a1, $v0, $zero
jal sumAndShow
    halt


; lee digitos entre 0 y 9, si no es valido sigue insistiendo (?)
; retorna en $v0
leer: daddi $t0, $zero, 8   ; cod lectura
      daddi $t1, $zero, 9   ; para comparar
repetir:    sw $t0, 0($s0)  ; lee y guarda
            ld $t2, 0($s1)
            sltu $t3, $t1, $t2 ; compara
            beqz $t3, fin
            j repetir
fin: dadd $v0, $t2, $zero
     jr $ra

; imprime el resultado de la suma entre $a0 y $a1
sumAndShow: dadd $t0, $a0, $a1
            daddi $t1, $zero, 1
            sw $t0, 0($s1)
            sw $t1, 0($s0)
jr $ra
