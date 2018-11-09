@ ARM Assembly - sample program 

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values --> can be changed
	mov r5, #1;
	
	@ Write YOUR CODE HERE
	@ ---------------------
	b OneToTen
	
	OneToTen:
		cmp r5,#11
		beq exit
		b printthis
		

	printthis:
		@ load aguments and print
		mov r1,r5
		ldr r0, =format
		@mov r5,r1
		bl printf
		add r5,r5,#1;
		b OneToTen
	
	
	@ ---------------------
	



exit:
	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "This value is %d \n"

