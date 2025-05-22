; Falling blocks demo for the debug display
; HuntaBadday

#include "../lib/ds1.asm"

blocks:
    ; Clear the debug display
    mov r0, 0xf
    mov r1, 0
.clearLoop:
    mov [DEBUG+r0], r1
    sub r0, 1
    bpl .clearLoop
    
    mov r0, 0x100 ; Iterations until reset
.mainLoop:
    ; Generate random column to place the block
    mov r1, [RANDOM]
    and r1, 0xf
    mov r1, [.indexToBit+r1]
    mov r2, [DEBUG]
    or r1, r2
    mov [DEBUG], r1
    
    ; Loop though every line
    mov r1, 14
.loop:
    ; Fetch current line and next line
    mov r2, [DEBUG+r1]
    mov r3, [(DEBUG+1)+r1]
    
    ; Bit math to decide the next state of both lines
    mov r4, r3 ; Final output 2
    or r4, r2
    and r2, r3 ; Final output 1
    
    ; Re-write the lines to the display
    mov [DEBUG+r1], r2
    mov [(DEBUG+1)+r1], r4
    
    ; Loop through each line
    sub r1, 1
    bpl .loop
    
    ; If r0 is not at 0, keep looping and placing blocks
    sub r0, 1
    bne .mainLoop
    jmp blocks ; Reset if r0 reaches 0
    
    ; Convert a value from 0-15 to a bit
.indexToBit:
    #d16 0b1
    #d16 0b10
    #d16 0b100
    #d16 0b1000
    #d16 0b10000
    #d16 0b100000
    #d16 0b1000000
    #d16 0b10000000
    #d16 0b100000000
    #d16 0b1000000000
    #d16 0b10000000000
    #d16 0b100000000000
    #d16 0b1000000000000
    #d16 0b10000000000000
    #d16 0b100000000000000
    #d16 0b1000000000000000