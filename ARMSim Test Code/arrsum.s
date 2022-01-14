.equ SWI_Exit, 0x11
.text
mov r1, #0
ldr r3, =AA
add r6, r3, #400
L: ldr r5, [r3, #0]
add r1, r1, r5
add r3, r3, #4
cmp r3, r6 @ r6 = q
blt L
swi SWI_Exit
.data
AA: .space 400
.end