# CS61C Sp14 Project 1-2
# Task A: The Collatz conjecture

.globl main
.include "collatz_common.s"

main:
	jal read_input			# Get the number we wish to try the Collatz conjecture on
	move $a0, $v0			# Set $a0 to the value read
	la $a1, collatz_recursive	# Set $a1 as ptr to the function we want to execute
	jal execute_function		# Execute the function
	li $v0, 10			# Exit
	syscall
	
# --------------------- DO NOT MODIFY ANYTHING ABOVE THIS POINT ---------------------

# Returns the stopping time of the Collatz function (the number of steps taken till the number reaches one)
# using an RECURSIVE approach. This means that if the input is 1, your function should return 0.
#
# The current value is stored in $a0, and you may assume that it is a positive number.
#
# Make sure to follow all function call conventions.
collatz_recursive:
	li	$t0, 1			# t0 = 1
	li	$v0, 0			# v0 = 0
	bne	$a0, $t0, continue	# if (a0 != 0) goto continue
	jr	$ra			# go back to calling function
continue:
	add 	$t1, $a0, $0		# t1 = a0
 	li	$t2, 2
mod_2:	blt	$t1, $t2, end
	addiu	$t1, $t1, -2		# t1 -= 2
	j	mod_2
end:	beq	$t1, $0, even		# if (t1 == 0) goto even
odd:	add	$t1, $a0, $a0		# t1 = 2 * a0
	add	$a0, $a0, $t1		# a0 = a0 + t1 = 3 * a0
	addiu	$a0, $a0, 1		# a0 += 1
	j	after_even			# goto after
even:	li	$t1, 1			# t1 = 1
find_half:
	add	$t2, $t1, $t1		# t2 = 2 * t1
	beq	$t2, $a0, after_half	# if (t2 == 0) goto after_half
	addiu	$t1, $t1, 1		# t1 += 1
	j	find_half		# goto find_half
after_half:
	add	$a0, $t1, $0		# a0 = t0
after_even:
	addiu	$sp, $sp, -4		# sp -= 4
	sw	$ra, 0($sp)		# sp = ra
	jal	collatz_recursive
	lw	$ra, 0($sp)		# ra = lw
	addiu	$sp, $sp, 4		# sp += 4
	addiu	$v0, $v0, 1		# v0 += 1
	jr	$ra