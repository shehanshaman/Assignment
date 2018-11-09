@ ARM Assembly - sample program 

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values --> can be changed
	mov r0, #10
	mov r1, #5
	mov r2, #6
	mov r3, #-8

	
	@ Write YOUR CODE HERE
	@ ---------------------
	
	cmp r2,#8
	beq printthis
	b exit
	
	
	
	


	
	
	@ ---------------------
	
	
	@ load aguments and print
printthis:
	ldr r0, =format
	bl printf

exit:
	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The values are equal\n"

