	.data
peso: 	.double 50.0
altura: .double 1.83
IMC: 	.double 0.0
infrapeso: .double 18.5
normal: .double 25.0
sobrepeso: .double 30.0
estado: .word 1

	.code
; datos de persona
l.d f0, peso($zero)
l.d f1, altura($zero)

; valores de comparación
l.d f31, infrapeso($zero)
l.d f30, normal($zero)
l.d f29, sobrepeso($zero)

; ---- Calculo de IMC ----
mul.d f1, f1, f1 ; altura = altura^2
div.d f0, f0, f1 ; peso = peso / altura
s.d f0, IMC($zero) ; IMC = peso

; ---- Calculo de estado ----
; ¿tiene infrapeso?
c.lt.d f0, f31 ; 22 < 18.5 ? fp = 0
bc1t fin
; ¿es 'normal'?
c.lt.d f0, f30 ; 22 < 25 ? fp = 1
bc1f seguir
daddi $t0, $t0, 2
sd $t0, estado($zero)
j fin
; ¿tiene sobrepeso?
seguir: c.lt.d f0, f29
bc1f obesidad
daddi $t0, $t0, 3
sd $t0, estado($zero)
j fin
; obesidad
obesidad: daddi $t0, $t0, 4
sd $t0, estado($zero)
fin: halt
	