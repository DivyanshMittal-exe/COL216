    .global fgets

    .text


fgets:	
    stmfd	sp!, {r1-r4,lr}
	ldr	r3, =operands
	str	r2, [r3]	@ specify input stream
	mov	r2, r0
	mov	r4, r1
	mov	r0, #1
	str	r0, [r3,#8]	@ to read one character
	mov	r1, r3
	mov	r3, r2
1:	sub	r4, r4, #1
	str	r3, [r1,#4]
2:	mov	r0, #0x06	@ read operation
	swi	0x123456
	ldrb	r0, [r3]
	add	r3, r3, #1
	cmp	r0, #'\n'
    beq 3f
    cmp	r0, #'\r'
    beq 3f
    strb	r0, [r3]
	b	1b
3:  mov r0,#'\0'
	strb	r0, [r3]
	mov	r0, r2		@ set success result
	ldmfd	sp!, {r1-r4,pc}

	.data
operands:
	.word	0, 0, 0