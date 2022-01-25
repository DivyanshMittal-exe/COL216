.equ SWI_Exit, 0x11


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
