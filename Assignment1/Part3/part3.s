.equ SWI_Exit, 0x11

.global merge_sort

.text

merge_sort:
    stmfd	sp!, {r2-r8,lr}
    lsl     r1,r1,#2
    mov     r4,r2
    mov     r5,r3
    add     r3,r0,r1

    bl      sort

    sub     r1,r1,r0
    lsr     r1,r1,#2
    ldmfd	sp!, {r2-r8,pc}



@Helper function, basically I keep r3 as end of list and case senitivity params ir r4,r5, as it makes my code easier to use.
sort:
    stmfd	sp!, {r2-r8,lr}
    sub     r6,r3,r0

    cmp     r6,#0
    beq     end_eq


    lsr     r6,r6,#3
    lsl     r6,r6,#2
    add     r1,r0,r6
    add     r2,r1,#4

2:
    mov     r7,r2
    mov     r8,r3

    mov     r3,r1
    bl      sort

    stmfd	sp!, {r0-r1}
    mov     r0,r7
    mov     r3,r8

    bl      sort

    mov     r2,r0
    mov     r3,r1
    ldmfd	sp!, {r0-r1}

    bl       merge


end_b:
    ldmfd	sp!, {r2-r8,pc}

end_eq:
    mov     r1,r3
    ldmfd	sp!, {r2-r8,pc}




.data
arr_m:    .space 160

.end