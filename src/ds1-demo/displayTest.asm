; Tests displays
; HuntaBadday

#include "../lib/ds1.asm"

displayTest:
    ; Draw test patterns to debug display
    mov r1, DEBUG
    mov r2, 0xaaaa
    mov r3, 16
    jsr fillMemory
    
    mov r1, DEBUG
    mov r2, 0x5555
    mov r3, 16
    jsr fillMemory
    
    mov r1, DEBUG
    mov r2, 0
    mov r3, 16
    jsr fillMemory
    
    ; Go through 0-255 on the score display
    mov r1, 0
.scoreTest:
    mov [GPIO0], r1
    add r1, 1
    cmp r1, 0x100
    bne .scoreTest
    
    mov r1, 0
    mov [GPIO0], r1
    
    ; Fill bitmap
    mov r1, BITMAP
    mov r2, 1
    mov r3, 0x100
    jsr fillMemory
    
    ; Clear bitmap
    mov r1, BITMAP
    mov r2, 0
    mov r3, 0x100
    jsr fillMemory
    
    ; Fill debug with random values twice to test the RNG peripheral
    mov r1, DEBUG
    mov r2, RANDOM
    mov r3, 16
    jsr fillFromAddr
    
    mov r1, DEBUG
    mov r2, RANDOM
    mov r3, 16
    jsr fillFromAddr
    
    ; Clear debug display
    mov r1, DEBUG
    mov r2, 0
    mov r3, 16
    jsr fillMemory
    
    ; Exit
    rts
    
#include "../lib/mem.asm"