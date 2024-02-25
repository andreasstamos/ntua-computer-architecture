.data
#EXAMPLE
n: .word 6
example: .word 5, 7, 1, -1, -2, -1000

.text 

.globl main

insertionSort_rec:
addi $a1, $a1, -1

#if N==0: return
beq $a1, $zero, exitFunc

addi $sp, $sp, -12
sw $a0, 4($sp)
sw $a1, 8($sp)
sw $ra, 12($sp)

jal insertionSort_rec

lw $a0, 4($sp)
lw $a1, 8($sp)
lw $ra, 12($sp)
addi $sp, $sp, 12

#j = A+N
sll $a1, $a1, 2
add $t0, $a0, $a1

lw $t1, 0($t0) #key = *j

L1:
beq $t0, $a0, exitL1 #if j == A: exit L1

#if !(key < *(j-1)): exit L1
lw $t2, -4($t0)
slt $t3, $t1, $t2
beq $t3, $zero, exitL1

sw $t2, 0($t0) #*j = *(j-1)
addi $t0, $t0, -4 #--j;

j L1

exitL1:
sw $t1, 0($t0)

exitFunc:
jr $ra


#ONLY FOR DEMONSTRATION PURPOSES
main:
la $a0, example
addi $sp, $sp, -4
sw $ra, 4($sp)
lw $a1, n
jal insertionSort_rec
lw $ra, 4($sp)
addi $sp, $sp, 4
jr $ra

