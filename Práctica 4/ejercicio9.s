; simular el siguiente fragmento
; while a > 0 do begin
;   x := x + y
;   a := a - 1
; end;
; ejecutar con delay slot

    .data
a: .word 3
x: .word 1
y: .word 1

    .code
ld r1, a(r0)
ld r2, x(r0)
ld r3, y(r0)

loop: beqz r1, fin
      daddi r1, r1, -1
      j loop
      dadd r2, r2, r3
fin: halt
