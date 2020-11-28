  .data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0

  .code
dadd r1, r0, r0
ld r2, cant(r0)

loop: ld r3, datos(r1)
      daddi r2, r2, -1
      dsll r3, r3, 1
      sd r3, res(r1)
      daddi r1, r1, 8
      bnez r2, loop
      nop
halt

; ¿Qué efecto tiene el Delay Slot?
; la instrucción siguiente a un salto, siempre se ejecuta.

; ¿Por qué se incluye el NOP?¿Qué pasaría si no estuviera?
; se incluye para que, con el delay slot, no se ejecute el HALT
; lo cual, acabaría el programa, sin ningún loop.

; ciclos, cant instrucciones y CPI: (con forwarding, DS y NOP)
; 63, 59, 1.068

; ciclos, cant instrucciones y CPI (con forwarding, DS y reordenamiento)
; 55, 51, 1.078

; modificar para aprovechar el delay slot, eliminando el NOP
; comparar ciclos, instrucciones y CPI

; codigo modificado:

.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0

.code
dadd r1, r0, r0
ld r2, cant(r0)

loop: ld r3, datos(r1)
      daddi r2, r2, -1
      dsll r3, r3, 1
      sd r3, res(r1)
      bnez r2, loop
      daddi r1, r1, 8
halt
