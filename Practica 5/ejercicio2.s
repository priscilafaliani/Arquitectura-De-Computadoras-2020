	.data
base:	.double 5.85
altura: .double 13.47
superficie: .double 0.0

	.code
l.d f1, base($zero)
l.d	f2, altura($zero)

mul.d 	f3, f1, f2

daddi 	$t0, $zero, 2
mtc1 	$t0, f4
cvt.d.l f4, f4

div.d 	f3, f3, f4

s.d f3, superficie($zero)
halt