    .data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
clave:      .asciiz "1234"
leida:      .asciiz "...."
bienvenido: .asciiz "Bienvenido"
error:      .asciiz "ERROR, ingrese clave nuevamente"

    .code
; constantes
lwu $s0, CONTROL($zero)
lwu $s1, DATA($zero)

; lee clave de 4 caractres
repetir: daddi $s2, $zero, 4
daddi $a0, $zero, leida
loop: jal char
      daddi $a0, $a0, 1
      daddi $s2, $s2, -1
      bnez $s2, loop

daddi $a0, $zero, leida
daddi $a1, $zero, clave
jal compare
dadd $a0, $zero, $v0
jal clear
jal respuesta
; si dio error, pide que se vuelva a ingresar...
beqz $v0, repetir
    halt

; recibe una direccion donde almacenar el caracter por $a0
char: daddi $t0, $zero, 9   ; codigo de lectura de char
      sd $t0, 0($s0)        ; leo
      ld $t0, 0($s1)        ; recupero dato
      sb $t0, 0($a0)       ; guardo en $a0
jr $ra

; recibe un flag en $a0
; si es 1, muestra "bienvenido"
; si no "ERROR"
respuesta: daddi $t0, $zero, 4
           beqz $a0, _error
           daddi $t1, $zero, bienvenido
           j seguir
_error:    daddi $t1, $zero, error
seguir:    sd $t1, 0($s1)
           sd $t0, 0($s0)
jr $ra

; recibe dos claves de 4 digitos en $a0 y $a1 (direccion de comienzo)
; retorna en $v0 1 si son iguales
; 0 si son diferentes
compare: daddi $t2, $zero, 4 ; cant caracteres
         daddi $v0, $zero, 0 ; resultado previsto
loop:    ld $t0, 0($a0)
         ld $t1, 0($a1)
         bne $t0, $t1, fin
         daddi $t2, $t2, -1
         daddi $a0, $a0, 1
         daddi $a1, $a1, 1
         beqz $t2, iguales
iguales: daddi $v0, $zero, 1
fin: jr $ra

; limpia la terminal
clear: daddi $t0, $zero, 6
       sd $t0, 0($s0)
jr $ra
