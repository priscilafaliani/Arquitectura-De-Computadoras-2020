; CODIGO A MODIFICAR
;     .data
; texto:      .asciiz "Hola, mundo!"
; CONTROL:    .word32 0x10000
; DATA:       .word32 0x10008
;
;     .code
; lwu $s0, DATA($zero)
; daddi $t0, $zero, texto
; sd $t0, 0($s0)
;
; lwu $s1, CONTROL($zero)
; daddi $t0, $zero, 6
; sd $t0, 0($s1)
;
; daddi$t0, $zero, 4
; sd $t0, 0($s1)
;     halt

    .data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
texto:      .byte 0

    .code
; uso como variables globales, constantes
lwu $s0, CONTROL($zero)
lwu $s1, DATA($zero)

; lee un mensaje y lo guarda en 'texto'
daddi $a0, $zero, texto
jal leer

; limpiar terminal
daddi $t0, $zero, 6
sd $t0, 0($s0)

; imprimir mensaje
daddi $t0, $zero, texto
sd $t0, 0($s1)

daddi $t1, $zero, 4
sd $t1, 0($s0)
    halt

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
