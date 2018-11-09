@ ARM Assembly Project1

	.text	@ instruction memory

	.global main

@ --- 6 - row / count - 9
@	  7 - col / count - 10
@	  8 - opp code

scan:
	sub sp,sp,#4
	str lr,[sp,#0]

	sub sp,sp,#4

	@scanf for int1
	ldr	r0, =formats
	mov	r1, sp	
	bl	scanf	@scanf("%d",sp)

	@copy int1 from the stack to register r5
	ldr	r5, [sp]

	@release stack
	add	sp, sp, #4

	@ stack handling (pop lr from the stack) and return
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr	
	


main:
	@ stack handling, 
    @ push (store) lr to the stack
	sub	sp, sp, #4
	str	lr, [sp, #0]

	mov r9,#1 @row / all num
	mov r10,#0 @col
	mov r4,#255

	@ Row in r6
	bl scan
	mov r6,r5

	@ COl in r7
	bl scan
	mov r7,r5
	
	@ Opp code in r8
	bl scan
	mov r8,r5

	cmp r8,#0 @ORIGINAL
	beq	ORIGINAL
	cmp r8,#1 @INVERT
	beq INVERT
	cmp r8,#2
	beq ROTATE
	cmp r8,#3
	beq ROTATE

	ldr r0,=format_not
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr		
	

INVERT:
	ldr r0, =format_inv
	bl printf

	invert_loop:
		cmp r10,r7
		beq in_row_chan
		bl scan

		sub r5,r4,r5
		mov r1,r5
		

		@printf
		ldr	r0, =formatp
		bl 	printf

		add r10,r10,#1
		bl invert_loop


ORIGINAL:
	ldr r0, =format_ori
	bl printf

	cmp r10,r7
	beq or_row_chan
	bl scan

	mov r1,r5
	

	@printf
	ldr	r0, =formatp
	bl 	printf

	add r10,r10,#1
	bl ORIGINAL

or_row_chan:
	cmp r9,r6
	beq exit
	mov r10,#0
	add r9,r9,#1

	ldr	r0, =formatn
	bl 	printf

	bl ORIGINAL

in_row_chan:
	cmp r9,r6
	beq exit
	mov r10,#0
	add r9,r9,#1

	ldr	r0, =formatn
	bl 	printf

	bl invert_loop

ROTATE:
	mul r5,r6,r7
	mov r4,#4
	mul r9,r4,r5
	mov r10,#0

	sub sp,sp,r9 @allocate space

	read:
		cmp r10,r9
		beq print
		bl scan
		str r5,[sp,r10]
		
		add r10,r10,#4
		b read

	print:
		sub r10,r10,#4
		mov r5,#0
		mov r4,#1

		cmp r8,#3
		beq print_flp

		ldr r0, =format_rot
		bl printf
		
		print_loop:
			cmp r5,r7
			beq rot_row_chan

			ldr r1,[sp,r10]
			ldr	r0, =formatp
			bl 	printf
			sub r10,r10,#4
			add r5,r5,#1
			b print_loop

		rot_row_chan:
			cmp r6,r4
			beq stack_change
			mov r5,#0
			add r4,r4,#1

			ldr	r0, =formatn
			bl 	printf

			b print_loop


stack_change:
	add sp,sp,r9
	b exit

print_flp:
	ldr r0,=format_flp
	bl printf

	mov r4,#4
	mov r11,#1
	sub r5,r7,#1
	mul r8,r5,r4

	mov r5,#0

	mul r10,r8,r11

	loop_flp:
		sub r6,r6,#1

		loop_flp_inter:
			cmp r5,r7
			beq con_flp
			@mov r1,r10

			ldr r1,[sp,r10]
			ldr	r0, =formatp
			bl 	printf

			sub r10,r10,#4
			add r5,r5,#1

			bl loop_flp_inter

		con_flp:
			cmp r11,r6
			bgt stack_change

			ldr	r0, =formatn
			bl 	printf

			add r11,r11,#1

			mov r5,#0
			mul r8,r11,r7
			sub r8,r8,#1
	
			mov r4,#4
			mul r10,r8,r4


			b loop_flp_inter

exit:
	ldr	r0, =formatn
	bl 	printf

    @ stack handling (pop lr from the stack) and return
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr		
	
	.data	@ data memory
formats: .asciz "%d"
formatp: .asciz "%d "
formatn: .asciz "\n"
format_rot: .asciz "Rotation by 180\n"
format_inv: .asciz "Inversion\n"
format_flp: .asciz "Flip\n"
format_ori: .asciz "Original\n"
format_not: .asciz "Invalid operation\n"
