; definir dos varaibles A y B con valores 4 y 5 respectivamente
; definir una variable C sin valores
; sumar A y B
; guardar el resultado en C
; ** utilizar un desplazamiento desde A para cargar B y C **

.data
A: .word 4
B: .word 5
C: .word 0

.code
ld r1, A(r0)
daddi r2, r0, 8
ld r2, A(r2)

dadd r2, r1, r2
daddi r3, r0, 16
sd r2, A(r3)
halt
