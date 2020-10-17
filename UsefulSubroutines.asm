; PIO CONFIGURATIONS

; PIO is for comunnication with periferia. 
; One form of connection has: keys (connected to port A) and leds (connected to port B) 
; the other form has the printer, wich uses port A for state and port B for data.

; Port A is on direction 30h and CA is on 32h
; Port B is on direction 31h and CB is on 33h
; Both are 8 bits.

; -------------------------------------------------------------------------------------

; pio for keys and leds
config_pioKL: mov al, 0FFh  ; keys for input
              out 33h, al
              mov al, 00h   ; leds for output
              out 32h, al
ret

; -------------------------------------------------------------------------------------

; pio for printer
; requires manually sending the signal for printing
; that is sending a 0 to 1 signal in strobe bit.

; setting bit 0 of PA as read, and bit1 as write
; setting PB as write, for sendig data
config_pioPR: in al, 32h  ; using 2 masks to avoid altering CA previous state.
              and al, 0FDh
              or al, 01h
              out 32h, al
              mov al, 00h ; CB uses the 8 bits for output.
              out 33h, al
ret

; -------------------------------------------------------------------------------------

; strobes for printer
; sending to bit 1 in port A a 0 or a 1.

; forcing a 0 and avoid altering the rest of bits.
strobe0:  in al, 30h
          and al, 0FDh
          out 30h, al
ret

; forcing a 1 and avoid altering the rest of bits.
strobe1:  in al, 30h
          or al, 02h
          out 30h, al
ret

; -------------------------------------------------------------------------------------

; polling with pio
; is the only way of using the printer with the PIO device.
pollPIO:  in al, 30h
          and al, 01h
          jnz pollPIO
ret

; -------------------------------------------------------------------------------------

; HANDSHAKE PRINTER
; with hanshake we have to ways of using the printer
; vía polling or vía interruptions

; The handshake device registers are in 40h (data) and 41h (state). Both 8 bits.

; 41h register has: 
; bit 0 as busy signal (0 indicates not busy)

; bit 1 as strobe, but the handshake sends the signals automatically (basically we don't need it)
; we just need to send data when printer is not busy.

; and bit 7 is the INT bit. A 1 indicates the handshake to produce a interruption when it can receive more data.

; -------------------------------------------------------------------------------------

; handshake polling
pollHAND: in al, 41h
          and al, 01h
          jnz pollHAND
ret

; handshake without INT

; this setting goes paired with polling, similar as using the PIO, the only diference is that
; the strobe signal is automatically sent when we put data in the 40h register.
configHAND: in al, 41h
            and al, 7Fh
            out 41h, al
ret

; -------------------------------------------------------------------------------------

; in this case is also needed that we configure the PIC to allow the printer to interrupt the CPU.
; if not, the printer will send the interruptions but they will not be atended.

; remember: the handshake corresponds with INT2 register in the PIC.

; handshake with INT
configHAND: in al, 41h
            or al, 80h
            out 41h, al
ret

; when we finished using the handshake via interruptions we can use the NO INT version to deactivate
; and also deactivate from the PIC

; -------------------------------------------------------------------------------------
