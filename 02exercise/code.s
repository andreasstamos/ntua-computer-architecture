loop:
lw $t1, 0($t2)
addi $t2, $t2, -4
lw $t3, 0($t1)
addi $t9, $t9, -4
lw $t5, 100($t3)
add $t4, $t3, $t3
add $t6, $t5, $t4
sw $t6, 0($t2)
bnez $t9, loop
