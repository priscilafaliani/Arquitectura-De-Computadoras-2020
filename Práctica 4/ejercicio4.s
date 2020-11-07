; Ejecutar, analizar, indicar que reliza el siguiente código
; el resultado y donde queda guardado
; con forwarding habilitado

  .data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num:   .word 7
long:  .word 10

  .code
ld r1, long(r0) ; guarda la longitud de la tabla
ld r2, num(r0)  ; guarda el número que se quiere buscar en la tabla

dadd r3, r0, r0  ; r3 = 0, registro de desplazamiento
dadd r10, r0, r0 ; r10 = 0, si el programa termina con r10 = 0, no se encontro num

loop:  ld r4, tabla(r3)   ; trae un número de la tabla
       beq r4, r2, listo  ; si encontró el número que buscaba, termina
       daddi r1, r1, -1   ; si no, sigue buscando, decrementa la cantidad de elementos por revisar
       daddi r3, r3, 8    ; incrementa el desplazamiento
       bnez r1, loop      ; si r1 != 0, tiene que seguir revisando numeros
       j fin              ; si no, finaliza el programa porque no encontro el número

listo: daddi r10, r0, 1 ; si encontró el número, r10 = 1
fin:   halt

; reejecutar con BTB. Explicar la ventaja de usarlo y cómo trabaja.
; la ventaja es que puede evitar gran parte de los atascos BTS, en casos
; donde hay loops que se repiten más de 4 veces.
; a mayor cantidad de loops, menor cantidad de atascos a rasgo general.
; ya que sin BTB, se producirian en cada loop.

; su funcionamiento esta basado en la idea de "predecir" el próximo salto.
; si nunca se produjo un salto -> se comienza a ejecutar la instruccion siguiente
; y en la tabla del BTB, se guarda la dirección siguiente
; si esa predicción falló, se actualiza la tabla y además se produce un BTS
; lo cual, son 2 ciclos de atasco.

; si se produjo un salto antes, se inicia a ejecutar la instrucción guardada en la tabla
; si es correcta, entonces no hay problema
; si es incorrecta, nuevamente, se actualiza la tabla BTB y un BTS.

; sin embargo, esto solo ocurriria en los "límites", ya que en un loop
; una vez puesta la predicción en el comienzo del mismo, será correcta
; hasta que se llegue al final de las repeticiones.
