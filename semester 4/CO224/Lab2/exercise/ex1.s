@ ARM Assembly - Exercise 2
@ Find the total of values of arrayA

	.text 	@ instruction memory
	.global main
	
main:
	
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	ldr r0, =array_a
	
	@ Write YOUR CODE HERE
	@ Total = arrayA[0]+arrayA[1]+arrayA[2]+arrayA[3]+arrayA[4]+arrayA[5]
	@ Store the result in r5

	@ ---------------------
 	mov r5,#0
 	add r5,r5,[r0,#0]
 	add r5,r5,[r0,#4]
 	add r5,r5,[r0,#8]
 	add r5,r5,[r0,#12]
 	add r5,r5,[r0,#16]

	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1,r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr
	
	.data	@ data memory
	
format: .asciz "The Answer is %d (Expect 297 if correct)\n"
	
	@array called array_a of size 40 bytes
	.balign 4 			@align to an address of multiple of 4
array_a: .word 67,54,65,23,34,54
