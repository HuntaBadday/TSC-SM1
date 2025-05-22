#once
; data copy routines
; HuntaBadday

; Copy data from one region to another
; r1 - Source
; r2 - Dest
; r3 - Size
blockCopy:
    sub r3, 1
.loop:
    mov r4, [r1+r3]
    mov [r2+r3], r4
    sub r3, 1
    bpl .loop
    rts
    
; Fill a region of memory with a value
; r1 - Dest
; r2 - Value
; r3 - Size
fillMemory:
    sub r3, 1
.loop:
    mov [r1+r3], r2
    sub r3, 1
    bpl .loop
    rts
    
; Fill a region of memory with a value at another address
; r1 - Dest
; r2 - Value vector
; r3 - Size
fillFromAddr:
    sub r3, 1
.loop:
    mov r4, [r2]
    mov [r1+r3], r4
    sub r3, 1
    bpl .loop
    rts
    
; Copy a whole region of memory to a single address
; r1 - Source
; r2 - Dest
; r3 - Size
copyToAddr:
    sub r3, 1
.loop:
    mov r4, [r1+r3]
    mov [r2], r4
    sub r3, 1
    bpl .loop
    rts