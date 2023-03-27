# 108AB0032 ªL¬f¿« ¸ê°]¥|¥Ò
.data
nLine: .asciiz "\r\n"
sp: .asciiz ", "
dp: .word 0:201
aa: .asciiz "  --> \r\n"
bb: .asciiz " ******* \r\n"
.text
main:

	la $a1, dp
	li $s0, 0
IntArray:
	slti $s1, $s0, 200		# $s1 = $s0 < 200 ? 1 : 0
	beqz $s1, ExitInit
	addi $s0, $s0, 1
	addi $a1, $a1, 4
	sw $zero, 0($a1)
	j IntArray
ExitInit:
	
	li $v0, 5
	syscall
	addi $a0, $v0, -1
	la $a1, dp
	jal Fib
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
Fib:
	sll $s0, $a0, 2			
	add $s0, $a1, $s0		# $s0 == > address of dp[n] 
	lw $s1, 0($s0)			# $s1 = dp[n]
	
	beqz $s1, L1			# $s1 == 0 than goto L1
			li $v0, 1
			move $a0, $s1
			syscall
			li $v0, 4
			la $a0, nLine
			syscall
		move $a0, $s1
		move $v0, $s1		# $v0 == dp[n]
		jr $ra			# return dp[n]
L1:	# if (n == 1 || n == 2)
	slti $s1, $a0, 2		# $s1 = $a0 < 2 ? 1 : 0 
	beqz $s1, L2			# $s1 == 0 than goto L2
		sw $s1 0($s0)		# dp[n] = 1
		move $v0, $s1		# $v0 = $s1 = 1
		jr $ra			# return 1
	
L2:	# else
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	
	addi $a0, $a0, -1
	jal Fib				# call fib(n-1, dp) 
	sw $v0, 8($sp)			# store fib(n-1, dp) result
	
	addi $a0, $a0, -1
	jal Fib				# call fib(n-2, dp)
	
	lw $s1, 8($sp)			# read fib(n-1, dp) result
	add $v0, $s1, $v0		# $v0 = fib(n-1, dp) + fib(n-2, dp)
	
	lw $a0, 4($sp)			#restore $a0
	sll $s0, $a0, 2			#
	add $s0, $s0, $a1		#
	sw $v0, 0($s0)			# dp[n] = fib(n-1, dp) + fib(n-2, dp)
		move $s0, $v0
		div $s1, $v0, 3
		mfhi $s1		# Get remainder
	#	andi $s1, $s1, 3	# if $s1 % 3 == 0
		bnez $s1, L3		# if $s1 != 0 than goto L3
			move $a0, $v0
			li $v0, 1
			syscall
			li $v0, 4
			la $a0, nLine
			syscall
		move $v0, $s0
	lw $a0, 4($sp)
L3:
	lw $ra, 0($sp)	
	addi $sp, $sp, 12
	jr $ra
