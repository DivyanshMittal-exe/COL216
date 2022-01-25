.equ SWI_Exit, 0x11


.text

_start:
    ldr     r0,=strn
    ldr     r3,=arr
    ldr     r4,=arr

1:  str     r0,[r3]
    add     r3,r3,#4

    mov     r1,#10
    mov     r2,#0

    bl      fgets

    ldrb    r7,[r0,#0]
    cmp     r7,#0
    beq     2f
    mov     r7,#0
    strb    r7,[r0,#0]
    add     r0,r0,#1
    b       1b

2:
    sub     r5,r3,#4
    add     r0,r0,#1
    mov     r6,r3

    
3:  str     r0,[r3]
    add     r3,r3,#4

    mov     r1,#10
    mov     r2,#0

    bl      fgets

    ldrb    r7,[r0,#0]
    cmp     r7,#0
    beq     4f
    mov     r7,#0
    strb    r7,[r0,#0]
    add     r0,r0,#1
    b       3b

4:
    sub     r7,r3,#4

    mov     r0,r4
    mov     r1,r5
    mov     r2,r6
    mov     r3,r7

    mov     r4,#0
    mov     r5,#0
    bl      merge

5:  cmp     r0,r6
    bgt     6f
    str     r0,[sp,#-4]!
    ldr     r0,[r0,#0]
    bl      prints
    str     r0,[sp,#4]!
    add     r0,r0,#4
    b       5b

6:
    mov     r0,#0x18
    swi     0x123456

merge_old_bekar:
    stmfd	sp!, {r1-r7,lr}

    mov     r6,#0
    sub     r5,r3,r0
    lsr     r5,r5,#2

1:  add     r5,r5,#1
    lsr     r5,r5,#1
    
    cmp     r5,#1
    moveq   r6,#1

    mov     r2,r5
    lsl     r2,r2,#2
    
    add     r2,r2,r0
    mov     r1,r0

2:  cmp     r3,r2
    cmplt   r6,#1
    beq     3f

    cmp     r3,r2
    blt     1b
    str     r0,[sp,#-4]!
    str     r1,[sp,#-4]!
    str     r2,[sp,#-4]!

    ldr     r1,[r1,#0]
    ldr     r2,[r2,#0]
    bl      compare

    ldr     r2,[sp]
    add     sp,sp,#4
    ldr     r1,[sp]
    add     sp,sp,#4
    cmp     r0,#1
    bleq    swap
    ldr     r0,[sp,#4]!
    add     r1,r1,#4
    add     r2,r2,#4
    b       2b

3:
    ldmfd	sp!, {r1-r7,pc}

swap:
    stmfd	sp!, {r1-r4,lr}
    str     r3,[r1]
    str     r4,[r2]
    ldr     r3,[r2]
    ldr     r4,[r1]
    ldmfd	sp!, {r1-r4,pc}

    


.data
arr:    .space 160
strn:   .space 400


.end
