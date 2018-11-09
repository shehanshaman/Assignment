@ ARM Assembly - sample program 

	.text 	@ instruction memory

adder:

sub sp,sp,#28
str lr,[sp,#24]
	
	@mov r7,#22
	@mov r1,r7;

	@ldr r0,=format2
	@bl printf

	str r4,[sp,#0]
	str r5,[sp,#4]
	str r6,[sp,#8]
	str r7,[sp,#12]
	str r8,[sp,#16]
	str r1,[sp,#20]

	mov r4,#25
	mov r5,#40
	mov r6,#30
	mov r7,#100
	mov r8,#10

	add r1,r4,r5
	sub r1,r1,r6
	add r1,r1,r7
	add r1,r1,r8

	ldr r0,=format2
	bl printf

	ldr r4,[sp,#0]
	ldr r5,[sp,#4]
	ldr r6,[sp,#8]
	ldr r7,[sp,#12]
	ldr r8,[sp,#16]
	ldr r1,[sp,#20]

	@mov r1,r7;
	@ldr r0,=format2
	@bl printf

	ldr lr,[sp,#28]
	add sp,sp,#24
	mov pc, lr

	.global main

main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #20
	str lr, [sp, #0]

	@ load values --> can be changed


	
	@ Write YOUR CODE HERE
	@ ---------------------
	
	b call
	b adder
	
	


	
	
	@ ---------------------
	
	
	@ load aguments and print

call:
	ldr r0, =format1
	bl printf
	b adder


	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format1: .asciz "Calling the adder\n"
format2: .asciz "%d\nFinish\n"

