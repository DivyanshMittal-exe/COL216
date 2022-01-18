.equ SWI_Exit, 0x11
.text


_start:
    ldr     r0, =string1
    ldr     r1, =string2
    mov     r2, #1          @for comparison mode 

compare:
    cmp     r2,#1
    bne     comp_sens

normalise:
    mov     r5,r0
    mov     r6,r1
1:  ldrb     r2,[r0,#0]
    add     r0,r0,#1
    cmp     r2, #'\n'
    beq     2f
    cmp     r2,#'a'
    blt     1b
    sub     r2,r2,#32
    strb     r2,[r0,#-1]
    b       1b

2:  ldrb     r2,[r1,#0]
    add     r1,r1,#1
    cmp     r2, #'\n'
    beq     3f
    cmp     r2,#'a'
    blt     2b
    sub     r2,r2,#32
    strb     r2,[r1,#-1]
    b       2b

3:  
    mov     r0,r5
    mov     r1,r6


comp_sens:

    mov      r2,#0
    ldrb     r3,[r0,#0]
    ldrb     r4,[r1,#0]
    cmp      r3, #'\n'
    cmpeq    r4, #'\n'
    beq      last
    mov      r2, #-1
    cmp      r3, #'\n'
    beq      last
    mov      r2, #1
    cmp      r4, #'\n'
    beq      last

    mov      r2, #1
    cmp      r3,r4
    bhi      last

    mov      r2, #-1
    cmp      r3,r4
    blo      last

    add     r0,r0,#1
    add     r1,r1,#1
    b       comp_sens

last:


swi SWI_Exit


.data
string1: .ascii "ADD\n"
string2: .ascii "HelloWorld\n"
.end
