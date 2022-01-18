.equ SWI_Exit, 0x11

.global compare

.text

_start:
    ldr     r1, =string1
    ldr     r2, =string2
    mov     r3, #1          @for comparison mode Put 0 for case sensitive mode, and 1 for case insensitive

compare:
    mov     r6,r1
    mov     r7,r2

1:  mov      r0,#0
    ldrb     r4,[r1,#0]
    ldrb     r5,[r2,#0]

    cmp      r3,#0
    beq      2f
    bl       normalise
    
2:  cmp      r4, #'\n'
    cmpeq    r5, #'\n'
    beq      last
    mov      r0, #-1
    cmp      r4, #'\n'
    beq      last
    mov      r0, #1
    cmp      r5, #'\n'
    beq      last

    mov      r0,#1
    cmp      r4,r5
    bhi      last

    mov      r0, #-1
    cmp      r4,r5
    blo      last

    add      r1,r1,#1
    add      r2,r2,#1
    b       1b

normalise:
    cmp     r4,#'a'
    blt     1f
    cmp     r4,#'z'
    bgt     1f
    sub     r4,r4,#32

1:  cmp     r5,#'a'
    blt     2f
    cmp     r5,#'z'
    bgt     2f
    sub     r5,r5,#32
2:  mov     pc, lr


last:
    mov     r1,r6
    mov     r2,r7


swi SWI_Exit


.data
string1: .ascii "a\n"
string2: .ascii "A\n"
.end
