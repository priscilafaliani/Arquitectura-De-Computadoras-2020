; analizar el CodigoA

; ejecutar con forwarding habilitado

; ¿Por qué se presentan atascos de tipo RAW?
; porque la instrucción 'bnez r2, loop', precisa de r2 en la etapa ID
; y para ese entonces, 'daddi r2, r2, -1' está en la etapa EX
; por lo que se atasca 1 ciclo

; branch taken es otro atasco que aparece, ¿qué significa, por qué se produce?
; significa que un salto se "equivoco" en cuanto a que branch debia ejecutar
; y tuvo que cancelar la ejecución del branch que tenía.
; se produce porque cuando inicia 'bnez r2, loop', se comienza a hacer fetch
; del halt, y hasta la etapa ID de bnez, no se sabe si se salta o no.


; ejecutar con fowrwarding deshabilitado

; ¿Qué instrucciones generan los atascos tipo RAW y por qué?
; las instrucciones que generan atascos de tipo RAW son:
; dsll r1, r1, 1, en el primer acceso al loop
; y la instrucción bnez r2, loop, al igual que antes, sólo que ahora
; se atasca durante 1 ciclo adicional, ya que sin forwarding el dato
; no está disponible hasta el ciclo WB

; los BTS se siguen generando, que cantidad de ciclos dura?
; dura 2 ciclos cada atasco.
; la diferencia con el forwarding y por qué dura menos, es porque
; con forwarding los datos estan disponibles un ciclo antes.


; reordenar para que la cantidad de RAW sea 0, con forwarding habilitado
; CodigoB


; Codigo C
; modificar el programa para que almacene en un arreglo los contenidos parciales del
; registro r1
; ¿Que significado tienen esos elementos?
; son 3 multiplicaciones * 2 del valor que esta en A
