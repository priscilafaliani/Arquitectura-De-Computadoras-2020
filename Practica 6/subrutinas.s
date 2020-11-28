; recibe una direccion de almacenamiento en $a0
; lee hasta que se apreta 'enter'
; retorna un asciiz

; parte set up
leer: daddi $t0, $zero, 9       ; cod lectura
      daddi $t2, $a0, 0         ; dirección
      daddi $t4, $zero, 13      ; cod enter
; parte funcional
loop: sd $t0, 0($s0)            ; espero a input
      lbu $t3, 0($s1)           ; guardo data
      sb $t3, 0($t2)            ; almaceno en mem
      daddi $t2, $t2, 1         ; incremento despl
      bne $t3, $t4, loop        ; comparo
      daddi $t0, $zero, 0       ; agrego un 0 para el final
      sb $t0, 0($t2)
jr $ra


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
