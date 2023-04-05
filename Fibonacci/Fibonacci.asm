.data
dp: 	.word	0:100

nLine: 	.asciiz "\r\n"
rfib: 	.asciiz " rFibonacci: "
nefib:	.asciiz	"nrFibonacci: "
dpfib:	.asciiz	"dpFibonacci: "

.text
main:
  ## rFibonacci
  li $a0, 9
  jal rFibonacci
  move $t0, $v0
  li $v0, 4			#
  la $a0, rfib			#
  syscall			# print rFibonacci: 
  li $v0, 1
  move $a0, $t0
  syscall			# result
  li $v0, 4
  la $a0, nLine
  syscall			# \r\n
  
  ## nrFibonacci
  li $a0, 9
  jal nrFibonacci
  move $t0, $v0
  li $v0, 4			#
  la $a0, nefib			#
  syscall			# print nrFibonacci: 
  li $v0, 1
  move $a0, $t0
  syscall			# result
  li $v0, 4
  la $a0, nLine
  syscall			# \r\n
  
  
  li $v0, 10
  syscall			# Exit Program
 
 # Recursive   $a0 = n
 rFibonacci:
  slti $t0, $a0, 2		# $s0 = n < 2 ? 1 : 0
  beqz $t0, rFibElse		# If $t0 == 0 than goto rFibElse
    move $v0, $a0
    jr $ra
  rFibElse:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    
    addi $a0, $a0, -1		# n = n -1
    jal rFibonacci		# rFibonacci(n-1)
    sw $v0, 8($sp)		# store return value
    addi $a0, $a0, -1		
    jal rFibonacci		# rFibonacci(n-2)
    
    lw $t0, 8($sp)
    add $v0, $t0, $v0		# return rFib(n-1) + rFib(n-2)
    
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    addi $sp, $sp, 12
    jr $ra
    
# nrFibonacci   $a0 = n
nrFibonacci:
  move $t0, $zero		# fib = 0
  move $t1, $zero		# a = 0
  addi $t2, $zero, 1		# b = 1
  move $v0, $a0			# set return n
  beqz $a0, ExitnrFib
    # For begin
    addi $t3, $zero, 1		# $t3 = i  == 1
    For:
    slt $t4, $t3, $a0		# $t4 = i < n ? 1 : 0
    beqz $t4, ExitnrFib		# If $t4 == 0 than goto ExitnrFib
      add $t0, $t1, $t2		# fin = a + b
      move $t1, $t2		# a = b
      move $t2, $t0		# b = fib
      addi $t3, $t3, 1		# i++
      j For
  ExitnrFib:
    move $v0, $t0		# return fib
    jr $ra
    
    
    
    
    
    
    
    
    
    
    