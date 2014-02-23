##### sparse2dense function code #####
.text
# sparse2dense will have 2 arguments: $a0 = address of sparse matrix data, $a1 = address of dense matrix, $a2 = matrix width
# Recall that sparse matrix representation uses the following format:
# Row r<y> {int row#, Elem *node, Row *nextrow}
# Elem e<y><x> {int col#, int value, Elem *nextelem}
sparse2dense:
	# store the pointer to the first row in a variable
	# add	$s0, $a0, $0
	li	$s1, 4
	add	$a2, $a2, $a2		# a2 = a2 + a2
	add	$a2, $a2, $a2		# a2 = a2 + a2 # a2 *= 4 # width in bytes of each row
	
row_loop:
	beq	$a0, $0, row_end	# if (a0 == 0) goto row_exit
	lw	$t0, 0($a0)		# t0 = *a0 # Row number
	lw	$s0, 4($a0)		# s0 = *(a0 + 4) # Pointer to elem
	lw	$a0, 8($a0)		# a0 = *(a0 + 8) # Pointer to next row
elem_loop:
	beq	$s0, $0, elem_end	# if (s0 == 0) goto elem_exit
	lw	$t1, 0($s0)		# t1 = *s0 # Elem number
	lw	$t2, 4($s0)		# t2 = *(s0 + 4) # Value
	lw	$s0, 8($s0)		# t0 = *(s0 + 8) # Pointer to next elem
	# mult	$t1, $s1		# lo = t1 * s1 = t1 * 4
	# mflo	$t1			# t1 = lo = t1 * 4
	add	$t1, $t1, $t1		# t1 = t1 + t1
	add	$t1, $t1, $t1		# t1 = t1 + t1 # t1 *= 4
	mult	$t0, $a2
	mflo	$t3			# t3 = t0 * a2 # Offset upto correct row
	add	$t3, $t3, $t1		# t3 += t1 # Offset upto correct elem
	add	$t3, $t3, $a1		# t3 += a1 # correct address for storing
	sw	$t2, ($t3)		# *t3 = t2 # store elem in the correct place
	j	elem_loop
elem_end:		
	j	row_loop	
row_end:	
	jr	$ra
