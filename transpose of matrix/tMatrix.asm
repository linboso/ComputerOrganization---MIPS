# 108AB0032 ªL¬f¿« ¸ê°]¥|¥Ò
.data
nLine: .asciiz "\r\n"
sp: .asciiz " "

Am: .word 0:9
tAm1: .word 0:9
tAm2: .word 0:9
Len: .word 3
.text
main: 
	# Input Matrix
	la $a0, Am
	la $a1, Len
	lw $a1, 0($a1)
	jal InputMartix
	
	li $v0, 4
	la $a0, nLine
	syscall
	
	# Trans Martix 1
	la $a0, Am
	la $a1, tAm1
	la $a2, Len
	lw $a2, 0($a2)
	jal TranMatrix1
	# Output Martix
	la $a0, tAm1
	jal OutputMatrix
	
	# Trans Martix 2
	la $a0, Am
	la $a1, tAm2
	la $a2, Len
	lw $a2, 0($a2)
	jal TranMatrix2
	# Output Matrix
	la $a0, tAm2
	jal OutputMatrix
	
	
	li $v0, 10
	syscall
	
	
InputMartix:
	# a0 = A	a1 = len
	move $s0, $zero					# $s0 => i = 0
InRowFor:
	slt $s2, $s0, $a1				# i < j ? 1: 0
	beqz $s2, ERowFor
		move $s1, $zero				# $s1 => j = 0
	InColFor:
		slt $s2, $s1, $a1			
		beqz $s2, EColFor	
		
		li $v0, 5
		syscall
		sw $v0, 0($a0)
		
		addi $a0, $a0, 4
		addi $s1, $s1, 1
		j InColFor
	EColFor:
	addi $s0, $s0, 1
	j InRowFor
ERowFor:
	jr $ra
	
	
	
TranMatrix1:
	
	move $s0, $zero					# $s0 => i == 0
T1For:
	# a0 = A	a1 = B		a2 = len
	slt $s2, $s0, $a2
	beqz $s2, ExitT1For
		move $s1, $zero				# $s1 => j == 0
	T2For:
		slt $s2, $s1, $a2
		beqz $s2, ExitT2For
		
		mul $s3, $s0, $a2			# $s3 =  i * len
		add $s2, $s3, $s1			# $s2 =  i * len + j
		sll $s2, $s2, 2				# $s2 = (i * len + j) * 4
		add $s2, $s2, $a0			# A[i][j] address
		lw $s4, 0($s2)				# $s4 = A[i][j]
		
		mul $s2, $s1, $a2			# $s2 =  j * len
		add $s2, $s2, $s0			# $s2 = (j * len + i)
		sll $s2, $s2, 2				# $s2 = (j * len + i) * 4
		add $s2, $s2, $a1			# B[j][i] address
		sw $s4, 0($s2)				# B[j][i] = A[i][j]
		
		addi $s1, $s1, 1
		j T2For
	ExitT2For:
		addi $s0, $s0, 1
		j T1For
ExitT1For:
	jr $ra
	

# ==========================================================
TranMatrix2:
	# a0 = B	a1 = T		a2 = len
	addi $s0, $zero, 1				# $s0 => i == 1
	move $s1, $a0					# $s1 => ptrB 
	move $s2, $a1					# $s2 => ptrT 
	
	mul $s3, $a2, $a2				# $s3 = len * len 
	sll $s3, $s3, 2
	add $a0, $a0, $s3				# $a1 = B + len * len
	T3For:
		slt $s3, $s1, $a0			# $s3 =  ptrB < (B + len * len) ? 1 : 0 			
		beqz $s3, ExitT3For
					
		lw $s3 0($s1)				
		sw $s3, 0($s2)				# *ptrT  = *ptrB
		
		slt $s3, $s0, $a2			# $s3 ==  i < size ? 1 : 0
		beqz $s3, Else
			sll $s3, $a2, 2			# len * 4 	 (pointer + 1 == memory address + 4)
			add $s2, $s2, $s3		# $s2 = ptrT = ptrT + len
			addi $s0, $s0, 1		# i++
			j EndIf
		Else:
			mul $s3, $a2, $a2		# $s3 = len * len
			sub $s3, $s3, $a2		# $s3 = len * len - len
			addi $s3, $s3, -1		# $s3 = len * len - len - 1
			sll $s3, $s3, 2
			sub $s2, $s2, $s3		# $s2 = ptrP = ptrP - (len * len - len - 1) * 4
			addi $s0, $zero, 1		# i = 1
			j EndIf
		EndIf:
		addi $s1, $s1, 4			# ptrB++
		j T3For
	ExitT3For:
		jr $ra
# ==========================================================	
OutputMatrix:	
	# a0 = A
	move $s0, $zero 				# $s0 = i = 0
o1For:
	slti $s2, $s0, 3				# $s2 = $s0 < 3 ? 1 : 0 
	beqz $s2, o1Exit
		move $s1, $zero				# $s1 = j = 0
	o2For:
		slti $s2 $s1, 3
		beqz $s2, o2Exit
		
		mul $s2, $s0, 3				# $s2 = i * 3
		add $s2, $s2, $s1			# $s2 = i * 3 + j
		sll $s2, $s2, 2				# $s2 = (i*3 + j) * 4
		add $s2, $s2, $a0			# A[i][j] address
		
		move $s3, $a0				# tmp $a0
		li $v0, 1
		lw $a0, 0($s2)
		syscall					# print(A[i][j])
		
		li $v0, 4
		la $a0, sp
		syscall					# print(" ")
		
		move $a0, $s3				# restore $a0
		addi $s1, $s1, 1			# j++
		j o2For
	o2Exit:
		
		move $s3, $a0
		li $v0, 4
		la $a0, nLine
		syscall					# print("\r\n")
		move $a0, $s3				
		
		addi $s0, $s0, 1			# i++
		j o1For
o1Exit:
	jr $ra
	
	
	
	
	
	
  
    
