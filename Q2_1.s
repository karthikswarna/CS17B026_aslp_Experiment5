# MIPS program to divide two unsigned numbers

			.data   
dividend:	.word	21
divisor:	.word	15
quotient:	.word	0
remainder:	.word	0

			.text

main:
	lw $s0, dividend
	lw $s1, divisor
	li $s2, 0					# Remainder.
	li $t0, 0					# Quotient.
	li $t1, 0					# Quotient * Divisor.

	slt $t2, $s0, $s1			# if Dividend < Divisor.
	beq $t2, 1, large_divisor

for:
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
	sub $s2, $s0, $t1			# Remainder.
	sw $s2, remainder
	sw $t0, quotient
	jr $ra

large_divisor:
	add $s2, $zero, $s0			# Remainder = Dividend. 
	sw $s2, remainder
	sw $t0, quotient
	jr $ra
.end main