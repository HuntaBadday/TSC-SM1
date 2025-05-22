; Snake part of the demo program
; HuntaBadday

#include "../lib/ds1.asm"

SCORE = GPIO0
KEYS = GPIO1

LEFT = -0x01
RIGHT = 0x01
UP = -0x10
DOWN = 0x10

TURNMAP = 0x0000

; 0x0000 - 0x00FF : Contains direction the tail piece should follow

snake:
    ; Clear debug display
    mov r1, DEBUG
    mov r2, 0
    mov r3, 0x10
    jsr fillMemory
    
    ; Set score display to 0
    mov r1, 0
    mov [SCORE], r1
    
    ; Clear bitmap and turn map at the same time to save time
    mov r0, 0xff
    mov r1, 0
.clear:
    mov [TURNMAP+r0], r1
    mov [BITMAP+r0], r1
    sub r0, 1
    bpl .clear
    
    ; Initialize variables
    mov r5, 0x88    ; Head location
    mov r6, 0x87    ; Tail location
    mov r7, 0x89    ; Food location
    mov r8, RIGHT   ; Current direction
    mov r9, -1      ; Score
    ; r10: Last tail
    
    mov [TURNMAP+r6], r8
    
.mainLoop:
    ; Move head forward and put it's location in the turn map
    mov [TURNMAP+r5], r8
    add r5, r8
    
    ; Check for out of bounds
    cmp r5, 0x100
    bcs .loose
    
    ; Check if the head landed on the snake body
    mov r1, [TURNMAP+r5]
    bne .loose
    
    ; Check if the head is on food, if so, pause the tail for one step
    cmp r5, r7
    beq .skipTail
    
    ; Move tail and zero out it's location on the turn map
    mov r10, r6
    mov r2, 0
    mov r1, [TURNMAP+r6]
    mov [TURNMAP+r6], r2
    add r6, r1
    
    jmp .skipScore
    
.skipTail:
    add r9, 1
    ; Regenerate the food location
    mov r7, [RANDOM]
    and r7, 0xff
    
.skipScore:
    ; Update screen and score
    mov r1, 1
    mov r2, 0
    mov [BITMAP+r5], r1
    mov [BITMAP+r10], r2
    mov [BITMAP+r7], r1
    mov [SCORE], r9
    
    mov [KEYS], r1 ; Queue controls
    mov r1, [KEYS] ; Get controls
    
    mov r2, r8 ; Save last direction
    mov r3, r8
    
    ; Set direction corresponding to the key press
    bit r1, 0b0001
    beq .s1
    cmp r8, DOWN ; If trying to move the snake into itself, skip keypress
    beq .s1
    mov r8, UP ; Set direction variable coresponding to key
    jmp .mainLoop
.s1:
    
    bit r1, 0b0010
    beq .s2
    cmp r8, RIGHT
    beq .s2
    mov r8, LEFT
    jmp .mainLoop
.s2:
    
    bit r1, 0b0100
    beq .s3
    cmp r8, UP
    beq .s3
    mov r8, DOWN
    jmp .mainLoop
.s3:
    
    bit r1, 0b1000
    beq .s4
    cmp r8, LEFT
    beq .s4
    mov r8, RIGHT
.s4:
    
    jmp .mainLoop
    
.loose:
    rts
    
#include "../lib/mem.asm"