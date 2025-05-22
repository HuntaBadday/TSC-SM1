; Main demo code
; HuntaBadday

#bankdef sm1bank {
    #bits 16
    #addr 0xf000
    #size 0x1000
    #outp 0
}
#bank sm1bank

#include "../lib/ds1.asm"

LAST_KEY = 0x0000

init:
    ; Init stack
    mov sp, 0x1000
    
    ; Clear debug
    mov r1, DEBUG
    mov r2, 0
    mov r3, 16
    jsr fillMemory
    
    ; Clear debug
    mov r1, BITMAP
    mov r2, 0
    mov r3, 0x100
    jsr fillMemory
    
    ; Draw pattern onto debug
    mov r1, mainPrev
    mov r2, DEBUG
    mov r3, 16
    jsr blockCopy
    
    mov r12, 0 ; Init menu select number
main:
    ; Get a key press
    jsr getKey
    
    ; Check if "up" was pressed
    bit r1, 0b0001
    beq .noRun
    ; Get the corresponding program and jsr to it 
    mov r1, [indexToProg+r12]
    jsr r1
    jmp init
.noRun:
    ; "left"
    bit r1, 0b0010
    beq .s1
    sub r12, 1
.s1:
    ; "right"
    bit r1, 0b1000
    beq .s2
    add r12, 1
.s2:
    
    ; If selection goes out of range, reset it to 0
    cmp r12, 4
    bcc .inRange
    mov r12, 0
.inRange:
    
    ; Set the number display to show current selection
    mov [GPIO0], r12
    
    ; Copy corresponding image data to the debug display
    mov r1, [indexToPrev+r12]
    mov r2, DEBUG
    mov r3, 16
    jsr blockCopy
    
    ; Loop
    jmp main
    
; R1 - Key
getKey:
    mov [GPIO1], r1
    mov r1, [GPIO1]
    rts
    
; LUT for corresponding programs
indexToProg:
    #d16 snake
    #d16 blocks
    #d16 snow
    #d16 displayTest
    
; LUT for corresponding images
indexToPrev:
    #d16 snakePrev
    #d16 blocksPrev
    #d16 snowPrev
    #d16 mainPrev
    
snakePrev:
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    #d16 0b0111111000000000
    #d16 0b0000001000000000
    #d16 0b0000001111110100
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    #d16 0b0000000000000000
    
blocksPrev:
    #d16 0b0000000000000010
    #d16 0b0000010000000000
    #d16 0b0000000000100000
    #d16 0b0000000001000000
    #d16 0b0000000000000100
    #d16 0b0000000000010000
    #d16 0b0000000010000000
    #d16 0b0010000000000000
    #d16 0b0000010000000000
    #d16 0b0010000000000000
    #d16 0b0000000000100000
    #d16 0b0000000000110000
    #d16 0b0000111000111000
    #d16 0b0011111100111000
    #d16 0b0111111111111110
    #d16 0b1111111111111111
    
snowPrev:
    #d16 0b0001000000000000
    #d16 0b0000000000100000
    #d16 0b0000100000000000
    #d16 0b1000000100100000
    #d16 0b0010000000000001
    #d16 0b1000000100000000
    #d16 0b0000000000010000
    #d16 0b0010000000000001
    #d16 0b0000000100000000
    #d16 0b0000000001000000
    #d16 0b1000010000000001
    #d16 0b0010000000000000
    #d16 0b0000010001000000
    #d16 0b0001000000010000
    #d16 0b1000010000000001
    #d16 0b0000000000010000
    
mainPrev:
    #d16 0b1111111111111111
    #d16 0b1000000000000001
    #d16 0b1011111111111101
    #d16 0b1010000000000101
    #d16 0b1010111111110101
    #d16 0b1010100000010101
    #d16 0b1010101111010101
    #d16 0b1010101001010101
    #d16 0b1010101001010101
    #d16 0b1010101111010101
    #d16 0b1010100000010101
    #d16 0b1010111111110101
    #d16 0b1010000000000101
    #d16 0b1011111111111101
    #d16 0b1000000000000001
    #d16 0b1111111111111111
    
; Used libraries
#include "../lib/mem.asm"

; Included programs
#include "snake.asm"
#include "blocks.asm"
#include "snow.asm"
#include "displayTest.asm"

; Start vector for SM1's reset sequence
#addr 0xffff
#d16 init