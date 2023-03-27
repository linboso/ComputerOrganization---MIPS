# 108AB0032 ªL¬f¿« ¸ê°]¥|¥Ò
.data
Array: .word 0:6
Len: .word 5
nLine: .asciiz "\r\n"

.text
main:
	
	move $s0, $zero
	la $s1, Array
	la $a1, Len			
	lw $a1, 0($a1)				# Len
	iLoop:					# Input Array Value
		slt $s2, $s0, $a1			# $s1 == $s0 < Len ? 1 : 0
		beqz $s2, iOut
			li $v0, 5	
			syscall
			sw $v0, 0($s1)
			
			addi $s0, $s0, 1
			addi $s1, $s1, 4
			j iLoop
	iOut:
	
	la $a0, Array				# Array

	jal InsertionSort			# Call InsertionSort
	
	move $s0, $zero
	la $s1, Array
	eLoop:					# Output Array Final Value 
		slt $s2, $s0, $a1			# $s1 == $s0 < Len ? 1 : 0
		beqz $s2, eOut
			li $v0, 1
			lw $a0, 0($s1)
			syscall
			li $v0, 4
			la $a0, nLine
			syscall
			
			addi $s0, $s0, 1
			addi $s1, $s1, 4
			j eLoop
	eOut:
	
	li $v0, 10
	syscall
	
	
	
InsertionSort:
	addi $s0, $zero, 1			# $s0 => i == 1
For:
	slt $s1, $s0, $a1			# $s1 ==  i < len ? 1 : 0
	beqz $s1, Exit
	
	sll $s2, $s0, 2				# i * 4
	add $s2, $s2, $a0			# array[i] address
	lw $s1, 0($s2)				# $s1 =>  current   == array[i]
	addi $s2, $s0, -1			# $s2 => j  == i - 1
	
	While:
		slti $s3, $s2, -1		# $s3 == j < -1 ? 1 : 0		j >= 0
		bnez $s3, innerExit		# if $s0 != = than goto innrExit
	
		sll $s3, $s2, 2			# $s3 == j * 4
		add $s4, $s3, $a0		# array[j] address
		lw $s5, 0($s4)			# $s5 ==  array[j] value
		slt $s6, $s1, $s5		# $s6 == current < array[j] ? 1: 0	
		beqz $s6, innerExit
		
		sw $s5, 4($s4)			# array[j + 1] = array[j]
		addi $s2, $s2, -1		# j --
		j While
	innerExit:
	
	move $t0, $a0				# store Array address
	addi $s3, $s2, 1			# j + 1	
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
	la $a0, nLine
	syscall
	
	move $a0, $t0
	sw $s1, 4($s4)				# array[j + 1] = current
	
	addi $s0, $s0, 1
	j For
Exit:
	jr $ra
	
