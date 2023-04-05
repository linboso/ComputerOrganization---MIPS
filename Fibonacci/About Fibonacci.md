## C++ 
裡面分有 3種寫法分別: <br />
  * Recursive
  * Non-Recursive
  * DP / Memoization
    
MIPS 裡面也是分別對應    


## MIPS

`.data`: 表示下面區域是用來存放宣告的變數 可以是 int/ char/ array <br />
  - **dp:  .word: 0:100**  
    -  宣告一個名為 dp 之長度 100個 word的 MemSpace


`.text`: 表示下面區域是要執行的Code  
```
li $v0, 4          
la $a0, LABEL  
syscall    
```
- $v4 = 4 表示要到 **LABEL** 之 address print 出對應的 char 
```
li $v0, 1  
li $a, X  
syscall  
```
- $v4 = 1 表示要 print 出 $a0 的 number **X** 

```
li $v0, 10
syscall
```
- $v4 = 10 表示要 End Program
