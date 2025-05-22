; Gets a random position and state and plots it to the bitmap display
; HuntaBadday

#include "../lib/ds1.asm"

snow:
    mov r1, [RANDOM]
    shr r1 ; Shift lsb out into the carry bit in the status
    and r1, 0xff ; Mask out upper bits
    mov [BITMAP+r1], st ; Set the state to the shifted out bit
    jmp snow