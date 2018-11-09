@ ARM Assembly - exercise 6
@ 
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
gcd:
	sub sp, sp, #4
	str lr, [sp, #0]

	gcdfun:    
		CMP      r0, r1
        BEQ      end
        BLT      less
        SUBS     r0, r0, r1  @ could be SUB r0, r0, r1 for ARM
        B        gcdfun
	
	less:
        SUBS     r1, r1, r0  @ could be SUB r1, r1, r0 for ARM
        B        gcdfun



	end:
		ldr lr, [sp, #0]
		add sp, sp, #4
		mov pc, lr


@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64 	@the value a
	mov r5, #24 	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "gcd(%d,%d) = %d\n"

