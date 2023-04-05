.data
he:	.asciiz "Input Height: "
we: 	.asciiz "Input Weight: "
bmi:	.asciiz " BMI: "
uw: 	.asciiz "UnderWeight "
ow: 	.asciiz "OverWeight "
std:	.asciiz "Standard "
newL: 	.asciiz "\r\n"

.text
main:
  li $v0, 5
  syscall
  move $a0, $v0 		# input height

  li $v0, 5
  syscall
  move $a1, $v0 		# input weight

  jal bmic			# cal BMI
		
  move $a0, $v0			# $a0 =  return val of calBMI 
  jal level			# Output bmi	

  li $v0, 10
  syscall
	
bmic:
  mul $v0, $a0, $a0		# height x height
  mul $a1 $a1, 10000		# kg * 10000
  div $v0, $a1, $v0		# retunr wight / height^2
  jr $ra

level:				# Output bmi level	
  move $t1, $a0
  slti $t0, $a0, 19		# $t0 = $s0 < 18 ? 1 : 0
  beqz $t0, ElseIF		# if $t0 == 0 than goto ElseIF 
  li $v0, 4			
  la $a0, uw			# Under Weight
  syscall
  j Endfunc
  
ElseIF:				
  slti $t0, $a0, 24		# $t0 = $s0 < 24 ? 1 : 0
  bnez $t0, Else		# $t0 != 0 than Else
  li $v0, 4
  la $a0, ow			# Over Weight
  syscall
  j Endfunc
  
Else:				# Normall Weight
  li $v0, 4
  la $a0, std
  syscall
  
Endfunc:				# return 
 li $v0, 4
 la $a0, bmi
 syscall

  li $v0, 1
  move $a0, $t1
  syscall  
  jr $ra


