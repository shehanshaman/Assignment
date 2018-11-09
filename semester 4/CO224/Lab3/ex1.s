@ ARM Assembly - exercise 1


	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
@ mypow:
@ implement using loops
mypow:
sub sp,sp,#4
str lr,[sp,#0]

mov r7,#0 @count
mov r8,#1 @sum

loop:
	cmp r7,r1
	beq exit
	mul r9,r8,r0
	mov r8,r9
	add r7,r7,#1
	b loop

exit:
mov r0,r8


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

	mov r4, #8 	@the value x
	mov r5, #3 	@the value n
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl mypow
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
format: .asciz "%d^%d is %d\n"

