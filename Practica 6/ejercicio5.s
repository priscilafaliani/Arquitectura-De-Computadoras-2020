    .data
CONTROL: .word32 0x10000
DATA:    .word32 0x10008

    .code
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)

; base
jal leer
dadd $a0, $0, $v0

jal clear

; exponent
jal leer
dadd $a1, $0, $v0

jal clear

; ---- ;
jal pow

; prints fp result
daddi $t0, $0, 3
sd $v0, 0($s1)
sd $t0, 0($s0)
    halt

; lee un numero
leer:   daddi $t1, $0, 8
        sd $t1, 0($s0)
        ld $v0, 0($s1)
jr $ra

; limpia la pantalla grafica
clear:  daddi $t1, $t0, 6
        sd $t1, 0($s0)
jr $ra

; pow of a $a0 floating-point number to $a1 integer
; returns a **¡¡floating point number!!** in $v0
pow:    mtc1 $a0, f0
        ; base result
        daddi $t0, $0, 1
        mtc1 $t0, f1
        cvt.d.l f1, f1
repeat: beqz $a1, fin
        mul.d f1, f1, f0
        daddi $a1, $a1, -1
        j repeat
fin:    mfc1 $v0, f1
jr $ra
