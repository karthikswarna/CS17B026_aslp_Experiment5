# MIPS program to multiply two unsigned 32-bit numbers.

		.data
var1:	.word	654858
var2:	.word	455466  # (product = 4572032BA4)

		.text

main:
	lw $t0, var1		# loading number in $t0.
	lw $t1, var2		# loading number in $t1.
	multu $t0, $t1		# $t0 * $t1.(stored in HI, LO)
	mfhi $s0			# moving from HI to $s0.(=45)
	mflo $s1			# moving from LO to $s1.(=72032BA4)
	jr $ra
.end main