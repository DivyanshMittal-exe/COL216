.equ SWI_Exit, 0x11
.text
ldr r4, =AA
add r6, r4, #400
ldr r0, [r4, #0]
add r4, r4, #4
L: ldr r1, [r4, #0]
bl gcd
add r4, r4, #4
cmp r4, r6 	
blt L
gcd: cmp r0, r1
beq ret
blt sub10
sub01: sub r0, r0, r1
b gcd
sub10: sub r1, r1, r0
b gcd
ret: mov pc, lr
swi SWI_Exit
.data
AA: .space 400
.end