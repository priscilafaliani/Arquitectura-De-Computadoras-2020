; PIO CONFIGURATIONS

; pio for keys and leds
config_pioKL: mov al, 0FFh  ; keys for input
              out 33h, al
              mov al, 00h   ; leds for output
              out 32h, al
ret

; pio for printer
config_pioPR: in al, 32h  ; using 2 masks to avoid altering CA previous state.
              and al, 0FDh
              or al, 01h
              out 32h, al
              mov al, 00h ; CB uses the 8 bits for output.
              out 33h, al
ret

; strobes for printer
strobe0:  in al, 30h
          and al, 0FDh
          out 30h, al
ret

strobe1:  in al, 30h
          or al, 02h
          out 30h, al
ret

; polling with pio
pollPIO:  in al, 30h
          and al, 01h
          jnz pollPIO
ret

; HANDSHAKE PRINTER

; handshake polling
pollHAND: in al, 41h
          and al, 01h
          jnz pollHAND
ret

; handshake without INT
configHAND: in al, 41h
            and al, 7Fh
            out 41h, al
ret

; handshake with INT
configHAND: in al, 41h
            or al, 80h
            out 41h, al
ret
