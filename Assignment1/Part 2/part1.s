.equ SWI_Exit, 0x11

.global compare

.text



    ldr     r0,=onei
    bl      prints

    ldr     r0,=string1
    mov     r1,#40
    mov     r2,#0
    bl      fgets

    ldr     r0,=twoi
    bl      prints

    ldr     r0,=string2
    mov     r1,#40
    mov     r2,#0
    bl      fgets

    ldr     r0, =sensinse
    bl      prints

    ldr     r0,=string3
    mov     r1,#40
    mov     r2,#0
    bl      fgets

    ldr     r1, =string1
    ldr     r2, =string2
    ldr     r4, =string3
    ldrb    r5, [r4,#0]
    sub     r5, #'0'
    mov     r3, r5          @for comparison mode Put 0 for case sensitive mode, and 1 for case insensitive 
    bl      compare
    cmp     r0,#-1
    beq     1f
    cmp     r0,#1
    beq     2f
    ldr     r0,=equa
    b       3f
1:  
    ldr     r0,=twol
    b       3f
2:  
    ldr     r0,=onel
    b       3f
3:  
    bl      prints
    mov     r0,#0x18
    swi     0x123456


compare:
    stmfd	sp!, {r1-r7,lr}
    mov     r6,r1
    mov     r7,r2

1:  mov      r0,#0
    ldrb     r4,[r1,#0]
    ldrb     r5,[r2,#0]

    cmp      r3,#0
    beq      2f
    bl       normalise
    
2:  cmp      r4, #0
    cmpeq    r5, #0
    beq      last
    mov      r0, #-1
    cmp      r4, #0
    beq      last
    mov      r0, #1
    cmp      r5, #0
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
    ldmfd	sp!, {r1-r7,pc}






.data
string1: .space 40
string2: .space 40
string3: .space 40
equa: .asciz   "Equal strings"
twol: .asciz   "String 2 is larger"
onel: .asciz   "String 1 is larger"
onei: .asciz   "Enter String 1 \n"
twoi: .asciz   "Enter String 2 \n"
sensinse: .asciz   "Enter 0 for case-sensitive mode and 1 for case-insensitive mode \n"
.end
