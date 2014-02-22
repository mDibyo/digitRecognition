##### Variables #####
.data
# Header for dense matrix
head:		.asciiz	"  -----0----------1----------2----------3----------4----------5----------6----------7----------8----------9-----\n"

##### print_dense function code #####
.text
# print_dense will have 3 arguments: $a0 = address of dense matrix, $a1 = matrix width, $a2 = matrix height
print_dense:
	# store address of dense matrix, its width and the return address
	add	$s0, $a0, $0		# add	$s1, $a1, $0
	add	$s1, $a1, $0		# s1 = a1
	addiu	$sp, $sp, -4		# sp -= 4
	sw	$ra, 0($sp)		# *sp = ra
	
	# print head
	la	$a0, head		# load header
	jal	print_str		# print header
	
	# loop through matrix and print it out
	li	$t0, 0			# t0 = 0
outer_loop:
	bge	$t0, $a2, outer_end	# if (t0 >= a2) goto outer_end

	add	$a0, $t0, $0		# a0 = t0
	jal	print_int		# print t0
inner_loop:
	beq	$a1, $0, inner_end	# if (a1 == 0) goto inner_end
	jal	print_space		# print ' '
	lw	$a0, ($s0)		# a0 = *s0
	jal	print_intx		# print *s0
	addiu	$s0, $s0, 4		# s0 += 4
	addiu	$a1, $a1, -1		# a1 -= 1
	j	inner_loop
inner_end:
	add	$a1, $s1, $0		# a1 = s1
	addiu	$t0, $t0, 1		# t0 += 1
	jal	print_newline		# print a new line
	j	outer_loop		# goto outer_loop
	
	# retrieve return address and return
outer_end:
	lw	$ra, 0($sp)		# ra = *sp
	addiu	$sp, $sp, 4		# sp += 4
	jr	$ra			# return to main function
	
	
	

