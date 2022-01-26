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

    stmfd	sp!, {r0}
    ldr     r0,=onei
    bl      prints
    ldmfd	sp!, {r0}


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

    stmfd	sp!, {r0}
    ldr     r0,=twoi
    bl      prints
    ldmfd	sp!, {r0}

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

5:  cmp     r0,r1
    bgt     6f
    stmfd   sp!, {r0}
    ldr     r0,[r0,#0]
    bl      prints
    ldmfd   sp!, {r0}
    add     r0,r0,#4
    b       5b

6:
    mov     r0,#0x18
    swi     0x123456

    


.data
arr:    .space 160
strn:   .space 400

onei: .asciz   "Enter 1st List of String. Keep entering Strings with Enter, and when list one is over press CTRL + Enter \n"
twoi: .asciz   "Enter 2nd List of String. Keep entering Strings with Enter, and when list two is over press CTRL + Enter \n"


.end
