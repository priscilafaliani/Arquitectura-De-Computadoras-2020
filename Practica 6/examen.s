    .data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
RESULT:     .word 0
    .code
; constantes E/S
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)

; --- lectura de 3 numeros enteros ----
daddi $t0, $0, 8    ; codigo de lectura de numeros

sd $t0, 0($s0)      ; leo
ld $a0, 0($s1)      ; recupero el numero

sd $t0, 0($s0)      ; leo
ld $a1, 0($s1)      ; recupero el numero

sd $t0, 0($s0)      ; leo
ld $a2, 0($s1)      ; recupero el numero

; --- limpia la pantalla ----
daddi $t1, $t1, 6
sd $t1, 0($s0)

; --- realiza el calculo ---
jal operar

; --- muestra el resultado ---
dadd $a1, $0, $s0
dadd $a2, $0, $s1
dadd $a0, $0, $v0
jal mostrar

; --- almacena en memoria ---
sd $v0, RESULT($0)
    halt

; recibe A en $a0, B en $a1 y C en $a2
; retorna en $v0 el resultado
; realiza el calculo (A - B)/C
operar: dsub $v0, $a0, $a1
        ddiv $v0, $v0, $a2
jr $ra

; recibe en $a0 un digito a mostrar en pantalla
; recibe en $a1 y $a2 las direccioneS de CONTROL y DATA respectivamente
mostrar: daddi $t0, $0, 2
         sd $a0, 0($a2)
         sd $t0, 0($a1)
jr $ra
