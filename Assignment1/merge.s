.equ SWI_Exit, 0x11

.global merge

.text

merge:
    stmfd	sp!, {r2-r5,lr}
    stmfd	sp!, {r0}
    ldr     r6, = arr_m

 1: cmp     r1,r0
    blt     5f

    cmp     r3,r2
    blt     6f

    stmfd   sp!, {r0-r2}
    ldr     r1,[r0,#0]
    ldr     r2,[r2,#0]
    bl      compare
    mov     r7,r0
    ldmfd   sp!, {r0-r2}


    cmp     r7,#-1
    beq       2f

    cmp     r7,#1
    beq       3f

2:
    ldr     r7,[r0]
    add     r0,r0,#4
    b       4f

3:  
    ldr     r7,[r2]
    add     r2,r2,#4
    b       4f

4:  
    str     r7,[r6]
    add     r6,r6,#4
    b       1b

5:
    mov     r0,r2
    mov     r1,r3

6:
    cmp     r1,r0
    blt     7f
    ldr     r7,[r0]
    str     r7,[r6]

    add     r0,r0,#4
    add     r6,r6,#4

    b       6b

7:
    ldr     r2, =arr_m
    ldmfd	sp!, {r0}
    mov     r1,r0
  
  
8:  cmp     r2,r6
    bgt     9f
    ldr     r3,[r2]
    str     r3,[r1]

    add     r1,r1,#4
    add     r2,r2,#4
    b       8b

9:
    sub     r1,r1,#4
    ldmfd	sp!, {r2-r5,pc}



.data
arr_m:    .space 160

.end