# MIPS program to divide two signed numbers

			.data   
dividend:	.word	-71
divisor:	.word	-2
quotient:	.word	0
remainder:	.word	0

			.text

main:
	lw $s0, dividend
	lw $s1, divisor
	li $s2, 0					# Remainder.
	li $t0, 0					# Quotient.
	li $t1, 0					# Quotient * Divisor.

	li $t4, 0					# Remember the signs.
	li $t5, 0
	slt $t4, $s0, $t4
	slt $t5, $s1, $t5			# t4 t5 = 00, 01, 10, 11.

	beq $t4, 1, dividend_negative
	j divisor_negative

dividend_negative:				# If only Dividend is negative.
	beq $t5, 1, both_negative
	sub $s0, $zero, $s0
	j none_negative

divisor_negative:				# If only Divisor is negative.
	beq $t5, 0, none_negative
	sub $s1, $zero, $s1
	j none_negative

both_negative:					# If both Dividend and Divisor are negative.
	sub $s0, $zero, $s0
	sub $s1, $zero, $s1
	j none_negative

none_negative:					# If both are positive dont negate.
	slt $t2, $s0, $s1			# if Dividend < Divisor.
	beq $t2, 1, large_divisor

for:							# If Divisor < Dividend.
	add $t1, $t1, $s1
	addi $t0, $t0, 1
	slt $t2, $t1, $s0
	beq $t2, 1, continue
	beq $t1, $s0, end_for
	slt $t3, $s0, $t1
	beq $t3, 1, last_one

continue:
	j for

last_one:
	sub $t1, $t1, $s1
	addi $t0, $t0, -1

end_for:
	beq $t4, 1, dividend_negative_1
	j divisor_negative_1

dividend_negative_1:
	beq $t5, 1, both_negative_1
	sub $s2, $s0, $t1			# Remainder.
	sub $s2, $zero, $s2			# Negate the Remainder to match sign of Dividend.
	sub $t0, $zero, $t0			# Negate Quotient(as signs are opposite.)
	sw $s2, remainder
	sw $t0, quotient
	jr $ra

divisor_negative_1:
	beq $t5, 0, none_negative_1
	sub $s2, $s0, $t1			# Remainder.
	sub $t0, $zero, $t0			# Negate Quotient(as signs are opposite.)
	sw $s2, remainder
	sw $t0, quotient
	jr $ra

both_negative_1:
	sub $s2, $s0, $t1			# Remainder.
	sub $s2, $zero, $s2			# Negate the Remainder to match sign of Dividend.
	sw $s2, remainder
	sw $t0, quotient
	jr $ra
	
none_negative_1:
	sub $s2, $s0, $t1			# Remainder.
	sw $s2, remainder
	sw $t0, quotient
	jr $ra

large_divisor:
	add $s2, $zero, $s0			# Remainder = Dividend.
	beq $t4, 0, dont_negate
	sub $s2, $zero, $s2
dont_negate:
	sw $s2, remainder
	sw $t0, quotient
	jr $ra
.end main