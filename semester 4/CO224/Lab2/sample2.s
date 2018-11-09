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
	mov r1, #7
	mov r2, #6
	mov r3, #-8

	
	@ Write YOUR CODE HERE
	@ ---------------------
	cmp r1,r2
	bge print1
	bne print2
	
	
	
	


	
	
	@ ---------------------
	
	
	@ load aguments and print
print1:
	ldr r0, =format1
	bl printf
	b exit

print2:
	ldr r0, =format2
	bl printf
	b exit


exit:
	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format1: .asciz "r1 is equal or larger than r2\n"
format2: .asciz "r1 is less than r2\n"

