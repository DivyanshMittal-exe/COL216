.equ SWI_Exit, 0x11


.text

_start:
    ldr     r0,=strn
    ldr     r3,=arr
    ldr     r4,=arr

    stmfd	sp!, {r0}
    ldr     r0,=onei
    bl      prints
    ldmfd	sp!, {r0}

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

    Cstmfd	sp!, {r0}
    ldr     r0,=twoi
    bl      prints
    ldmfd	sp!, {r0}
    
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

    stmfd	sp!, {r0}
    ldr     r0,=ins
    bl      prints
    ldmfd	sp!, {r0}

    stmfd	sp!, {r0-r2}
    ldr     r0,=ins_ans
    mov     r1,#4
    mov     r2,#0
    bl      fgets
    ldr     r0,=ins_ans
    ldrb    r4, [r0,#0]
    sub     r4, r4, #'0'
    ldmfd	sp!, {r0-r2}

    stmfd	sp!, {r0}
    ldr     r0,=dup
    bl      prints
    ldmfd	sp!, {r0}   

    stmfd	sp!, {r0-r2}
    ldr     r0,=dup_ans
    mov     r1,#4
    mov     r2,#0
    bl      fgets
    ldr     r0, =dup_ans
    ldrb    r5, [r0,#0]
    sub     r5, r5, #'0'
    ldmfd	sp!, {r0-r2}    

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

onei:       .asciz   "Enter 1st List of String. Keep entering Strings with Enter, and when list one is over press CTRL + Enter \n"
twoi:       .asciz   "Enter 2nd List of String. Keep entering Strings with Enter, and when list two is over press CTRL + Enter \n"
ins:        .asciz   "Enter 0 for case-sensitive mode and 1 for case-insensitive mode \n"
ins_ans:    .space 4

dup:        .asciz   "Enter 0 for keep duplicates and 1 to remove them \n"
dup_ans:    .space 4

.end
