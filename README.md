# ComputerOrganization---MIPS
NTUT - Class - HomeWork

如果想要執行 MIPS 要先去此 http://courses.missouristate.edu/kenvollmar/mars/ 
下載 Mars MIPS模擬器

希望可以幫助其他人更加熟習 MIPS 的語法及規則
如果有要考資工所的 可以多看 
  - Fibonacci 的在遞迴上的呼叫方式
  - Martix 的操作 & 儲存在記憶體中的樣子
建議自己實際操作 Mars 去跑一次追蹤 比較實在 

### Mips 32 個 Register 用途
|Name     |Register Number | 用途           |
|:-------:|:--------------:|:---------------|
|$Zero    |0               |硬體 0 |
|$at      |1               |保留給 Assembler用|
|$v0 - $v1|2 - 3           |values for results & expression evaluation|
|$a0 - $a3|4 - 7           |arguments (function/procedures)|
|$t0 - $t7|8 - 15          |temporaries| 
|$s0 - $s7|16 - 23         |saved|
|$t8 - $t9|24 - 25         |more temp|
|$k0 - $k1|26 - 27         |保留給OS使用|
|$gp      |28              |global pointer|
|$sp      |29              |stack pointer|
|$fp      |30              |frame pointer|
|$ra      |31              |return address|

### Instructure Format
|Format| 6 bits | 5 bits | 5 bits | 5 bits | 5 bits |X|
|----|----|----|----|----|----|----|
|R-Type|OPcode|Rs|Rt|Rd|Shamt|6-bits Funct|
|I-Type|OPcode|Rs|Rt|X|X|16-bits Immed|
|J-Type|OPcode|X|X|X|X|26-bits address|

### 常見的 Instructure & 常見的用法
|Instructure|        Format       |              解釋       |Format |OPcode|  Funct   |
|:---------:|---------------------|--------------------------|:------:|:-----:|:-----:|
|add        |add $t0, $t1, $t2    |$t0 = $t1 + $t2           |R|0|32|
|sub        |sub $t0, $t1, $t2    |$t0 = $t1 - $t2           |R|0|34|
|lw         |lw $t0, _Const_($t3) |**去 Memory 裡 _Const_+$t3 之 MemoryAddress 取得 MemoryContent 後存入 $t0** |I|35|X|                     
|sw         |sw $t3, _Const_($s4) |**把$t3裡的 Value 存入 _Const_+$s4 之MemoryAddress MemoryContent = $t3**    |I|43|X|       
|and        |and $t0, $t1, $t2    |$t0 = $t1 and $t2          |R|0|36|    
|or         |or $t0, $t1, $t2     |$t0 = $t1 or  $t2          |R|0|37|    
|sll        |sll $t3, $s1, 2      |$t3 = $s1 << 2             |R|0|0|
|addi       |addi $t4, $t1,**-5** |$t4 = $t1 + (-5)           |I|12|X|   
|beq        |beq $s1, $t3,`LABEL` |If $s1 == $t3 than goto LABEL  |I|4|X|          
|bne        |bne $s3, $s7,`LABEL` |If $s3 != $t7 than goto LABEL  |I|5|X|              
|slt        |slt $s0, $s1, $s2    |$s0 = $s1 < $s2 ? 1 : 0    |R|0|42|           
|j          |j  `LABEL`           |goto LABEL                 |J|2|X|       
|jr         |jr  $ra              |goto $ra 裡面所存的 address (固定用法)    |`**R**`|0|X|           
|jal        |jal  `LABEL`         |goto LABEL 且把 LABEL的下一行address 存入 $ra 中 |J|3|X|              

beq、bne、slt 可以交互組合形成不同的判斷方式 : < -- <= -- > -- >= 

### PseudoInstructure 虛擬指令
|Instructure|        Format         |              解釋            |  MIPS指令            |
|:---------:|-----------------------|------------------------------|---------------------|
|move       |move $t1, $s3          |$t1 == $s3                    |add $t1, $s3, $zero  |
|clear      |clear $s2              |$s2 = 0                       |add $s2, $zero, $zero|
|**blt**    |blt $s0, $s1, `LABEL`  |If $s0 <  $s1 than goto LABEL |slt $t0, $s0, $s1 <br\>bne $t0, $zero, `LABEL` |
|**bgt**    |bgt $s0, $s1, `LABEL`  |If $s0 >  $s1 than goto LABEL |slt $t0, **$s1, $s0** <br\>bne $t0, $zero, `LABEL` |
|**bge**    |bge $s0, $s1, `LABEL`  |If $s0 >= $s1 than goto LABEL |slt $t0, $s0, $s1 <br\>beq $t0, $zero, `LABEL` |
|**ble**    |ble $s0, $s1, `LABEL`  |If $s0 <= $ts than goto LABEL |slt $t0, **$s1, $s0** <br\>beq $t0, $zero, `LABEL` |



