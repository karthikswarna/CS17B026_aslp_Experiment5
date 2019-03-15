# MIPS program to multiply two signed 32-bit numbers.

		.data
var1:	.word	-65
var2:	.word	45      # (product = -2925)

		.text

main:
	lw $t0, var1		# loading number in $t0.
	lw $t1, var2		# loading number in $t1.
	mult $t0, $t1		# $t0 * $t1(stored in HI, LO)
	mfhi $s0			# moving from HI to $s0.(= -1 default value)
	mflo $s1			# moving from LO to $s1.(= -2925)
	jr $ra
.end main