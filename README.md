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
||||||||
|----|----|----|----|----|----|----|
|R-Type|OPcode|Rs|Rt|Rd|Shamt|Funct|
|I-Type|OPcode|Rs|Rt|||16-bits Immed|
|J-Type|OPcode|||||26-bits address|

<table>
    <thead>
        <tr>
            <th>Layer 1</th>
            <th>Layer 2</th>
            <th>Layer 3</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan=4>L1 Name</td>
            <td rowspan=2>L2 Name A</td>
            <td>L3 Name A</td>
        </tr>
        <tr>
            <td>L3 Name B</td>
        </tr>
        <tr>
            <td rowspan=2>L2 Name B</td>
            <td>L3 Name C</td>
        </tr>
        <tr>
            <td>L3 Name D</td>
        </tr>
    </tbody>
</table>
