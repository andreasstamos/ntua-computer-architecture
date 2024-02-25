addi $s1, $s0, 12
LOOP:
lw $t0, 0($s1)
beq $t0, $zero, END
div $t0, $s2
slti $t1, $t0, 50
beq $t1, $zero, ELSE
mfhi $t0
j NEXT
ELSE:
mflo $t0
NEXT:
sw $t0, 0($s1)
addi $s1, $s1, 4
j LOOP
END:

