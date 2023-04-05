.data
dp: 	.word	0:100

nLine: 	.asciiz "\r\n"
sp:	.asciiz " ,"
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

  ## DP-Fibonacci
  li $a0, 9
  la $a1, dp			# $a1 = dp[0] address
  jal dpFibonacci
  
  move $t0, $v0
  li $v0, 4			#
  la $a0, dpfib			#
  syscall			# print nrFibonacci: 
  li $v0, 1
  move $a0, $t0
  syscall			# result
  li $v0, 4
  la $a0, nLine
  syscall			# \r\n 
  ## --------------------------------------------
  
  li $t0, 0
  main_for:
  slti $t1, $t0, 10
  beqz $t1, main_Exit
    sll $t1, $t0, 2
    add $t1, $a1, $t1
    lw $a0, 0($t1)
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, sp
    syscall
    addi $t0, $t0, 1
    j main_for
  main_Exit:
  ##  
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
    
    
dpFibonacci:
  sll $t0, $a0, 2
  add $t0, $t0, $a1
  lw $t1, 0($t0)		# $t0 = dp[n]
  move $v0, $t1			# return dp[n]
  beqz $t1, L1			# If dp[n] == 0 than goto ExitdpFib
  jr $ra
    L1:
    sw $a0, 0($t0)		# dp[n] = n
    move $v0, $a0		# return n
    slti $t1, $a0, 2		# $t1 = $a0 < 2? 1: 0
    beqz $t1, L2		# If n >= 2 than goto ExitdpFib
    jr $ra
        L2:
      addi $sp, $sp, -12
      sw $ra, 0($sp)
      sw $a0, 4($sp)
      
      addi $a0, $a0, -1
      jal dpFibonacci
      sw $v0, 8($sp)
      
      addi $a0, $a0, -1
      jal dpFibonacci
      
      lw $t0, 8($sp)
      add $v0, $v0, $t0		# tmp = fib(n-1) + fib(n-2)
      
      addi $t0, $a0, 2
      sll $t0, $t0, 2
      add $t0, $t0, $a1
      sw $v0, 0($t0)		# dp[n] = fib(n-1) + fib(n-2)
      	
      lw $a0, 4($sp)
      lw $ra, 0($sp)
      addi $sp, $sp, 12
      jr $ra
    
    
    
    
    
    
    
    
    
