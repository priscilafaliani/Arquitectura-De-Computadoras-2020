; decir cuál es el equivalente de estas instrucciones en assembly x86

.code
dadd r1, r2, r0 ; mov r1, r2
daddi r3, r0, 5 ; mov r3, 5
dsub r4, r4, r4 ; sub r4, r4
daddi r5, r5, -1 ; sub r5, 1
xori r6, r6, 0xfffffffffffffffff ; xor r6, 0FFFFh porque el registro más grande es de 16 bits
