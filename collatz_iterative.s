# CS61C Sp14 Project 1-2
# Task A: The Collatz conjecture

.globl main
.include "collatz_common.s"

main:
	jal read_input			# Get the number we wish to try the Collatz conjecture on
	move $a0, $v0			# Set $a0 to the value read
	la $a1, collatz_iterative	# Set $a1 as ptr to the function we want to execute
	jal execute_function		# Execute the function
	li $v0, 10			# Exit
	syscall
	
# --------------------- DO NOT MODIFY ANYTHING ABOVE THIS POINT ---------------------

# Returns the stopping time of the Collatz function (the number of steps taken till the number reaches one)
# using an ITERATIVE approach. This means that if the input is 1, your function should return 0.
#
# The initial value is stored in $a0, and you may assume that it is a positive number.
# 
# Make sure to follow all function call conventions.
collatz_iterative:
	li	$t0, 1			# t0 = 1
	li	$v0, 0			# v0 = 0
loop:	beq 	$a0, $t0, back_to_main	# if (a0 == 1) goto back_to_main
	addiu	$v0, $v0, 1		# v0 += 1
	add	$t1, $a0, $0 		# t1 = a0
	li	$t2, 2 			# t2 = 2
mod_2:	blt	$t1, $t2, end		# if (t1 < 2) goto end
	addiu	$t1, $t1, -2		# t1 -= 2
	j	mod_2			# goto mod_2
end:	beq	$t1, $0, even		# if (t1 == 0) goto even
odd:	add	$t1, $a0, $a0		# t1 = 2 * a0
	add	$a0, $a0, $t1		# a0 = a0 + t1 = 3 * a0
	addiu	$a0, $a0, 1		# a0 += 1
	j	after_even			# goto after
even:	li	$t1, 1			# t1 = 1
find_half:
	add	$t2, $t1, $t1		# t2 = 2 * t1
	beq	$t2, $a0, after_half	# if (t2 == a0) goto after_half
	addiu	$t1, $t1, 1		# t1 += 1
	j	find_half		# goto find_half
after_half:
	add	$a0, $t1, $0		# a0 = t0
after_even:
	j	loop			# loop
back_to_main:
	jr	$ra			# go back to main






