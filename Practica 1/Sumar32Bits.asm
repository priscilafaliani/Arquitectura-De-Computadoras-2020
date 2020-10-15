org 1000h
num1H dw 1234h
num1L dw 1234h
num2H dw 1111h
num2L dw 1000h

org 2000h

add num1L, num2L
adc num1H, num2H

int 0
end