@ ARM Assembly - exercise 3

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
Fibonacci:

	sub sp, sp, #4
	str lr, [sp, #0]


	mov r6,#0 @sum
	mov r7,#1

	loop:
		cmp r0,#1
		beq exit
		mov r8,r7
		add r7,r7,r6
		mov r6,r8
		sub r0,r0,#1
		b loop



exit:
	mov r0,r7
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

	mov r4, #8 	@the value n

	@ calling the Fibonacci function
	mov r0, r4 	@the arg1 load
	bl Fibonacci
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "F_%d is %d\n"

