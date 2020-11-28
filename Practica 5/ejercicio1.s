	.data
n1: 	.double 9.13
n2: 	.double 6.58
res1: 	.double 0.0
res2: 	.double 0.0

	.code
l.d f1, n1(r0) ; guarda el primer numero en f1
l.d f2, n2(r0) ; guarda el segundo numero en f2

nop
add.d f3, f2, f1 ; suma f2 + f1
mul.d f1, f2, f1
mul.d f4, f2, f1 ; multiplica f2 * f1

s.d f3, res1(r0) ; guarda la suma
s.d f4, res2(r0) ; guarda la multiplicación

halt