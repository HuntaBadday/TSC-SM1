#once
; A bitmap library, currently not used
; HuntaBadday

#include "../lib/ds1.asm"

; r1 - X
; r2 - Y
setPixel:
    mov r2, [shift4]
    or r1, r2
    mov r2, 1
    mov [BITMAP+r1], r2
    rts
    
; r1 - X
; r2 - Y
clearPixel:
    mov r2, [shift4]
    or r1, r2
    mov r2, 0
    mov [BITMAP+r1], r2
    rts
    
; r1 - X
; r2 - Y
xyToAddr:
    mov r2, [shift4]
    or r1, r2
    rts
    
; r1 - Value
; r2 - Line
setLine:
    mov r2, [shift4+r2]
.loop:
    shl r1
    mov [BITMAP+r2], st
    add r2, 1
    bit r2, 0xf
    bne .loop
    rts
    
; r1 - Src
drawBitmap:
    mov r0, r1
    mov r3, 15
.loop:
    mov r1, [r0+r3]
    mov r2, r3
    jsr setLine
    sub r3, 1
    bpl .loop
    rts
    
shift4:
    #d16 0x00
    #d16 0x10
    #d16 0x20
    #d16 0x30
    #d16 0x40
    #d16 0x50
    #d16 0x60
    #d16 0x70
    #d16 0x80
    #d16 0x90
    #d16 0xa0
    #d16 0xb0
    #d16 0xc0
    #d16 0xd0
    #d16 0xe0
    #d16 0xf0