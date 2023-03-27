# 108AB0032 ªL¬f¿« ¸ê°]¥|¥Ò
.data
he: .asciiz "Height: "
we: .asciiz "Weight: "
bmi: .asciiz "BMI: "
uw: .asciiz "UnderWeight"
ow: .asciiz "OverWeight"
newL: .asciiz "\r\n"

.text
main:
	li $v0, 5
	syscall
	move $s0, $v0 		# input height
	beq $s0 -1, End		# if input ==  -1 than Exit
	
	li $v0, 5
	syscall
	move $a1, $v0 		# input weight
	move $a0, $s0
	
	jal calculateBMI	# cal BMI
		
	move $a0, $v0		# $a0 =  return val of calBMI 
	jal printResult		# Output bmi	
	li $v0, 4
	la $a0, newL
	syscall
	j main			# Loop 
End:				# Exit 
	li $v0, 10
	syscall
	
calculateBMI:
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	mul $v0, $a0, $a0	# height x height
	mul $a1 $a1, 10000	# kg * 10000
	div $v0, $a1, $v0	# wight / height^2
	
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	jr $ra

printResult:			# Output BMI
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	slti $t0, $a0, 18	# $t0 = $s0<18 ? 1 : 0
	beqz $t0, ElseIF	# if $t0 == 0 than  goto ElseIF 
	li $v0, 4		# Under Weight
	la $a0, uw
	j Endfunc
ElseIF:				# Over Weight
	slti $t0, $a0, 24	# $t0 = $s0 < 24 ? 1 : 0
	bnez $t0, Else		# $t0 != 0 than Else
	li $v0, 4
	la $a0, ow
	j Endfunc
Else:				# Normall Weight
	li $v0, 1
	#move $a0, $a0
Endfunc:				# return 
	syscall
	lw $s0 0($sp)
	addi $sp $sp 4
	jr $ra



