.data
#EXAMPLE
n: .word 6
example: .word 5, 7, 1, -1, -2, -1000

.text 

.globl main

insertionSort:

#$t0 = &A[N]
or $t0, $zero, $a1
sll $t0, $t0, 2
add $t0, $t0, $a0

addi $t1, $a0, 4 #i = &A[1]

L1:
#if i == n: exit L1
beq $t1, $t0, exitL1

lw $t2, 0($t1) #key = A[i]

or $t3, $zero, $t1 #$t3 = &A[j+1] = $A[i]

L2:
#if &A[j+1] == &A: exitL2   (equivalantly if j == -1)
beq $t3, $a0, exitL2

lw $t4, -4($t3)  #key = &A[j] = &A[j+1] - 4

#if !(key<A[j]): exitL2
slt $t5, $t2, $t4
beq $t5, $zero, exitL2

sw $t4, 0($t3) #A[j+1] = A[j]
addi $t3, $t3, -4 #j--
j L2 #loop L2

exitL2:
sw $t2, 0($t3) #A[j+1] = key
addi $t1, $t1, 4 #i++
j L1 #loop L1

exitL1:
jr $ra


#ONLY FOR DEMONSTRATION PURPOSES
main:
la $a0, example
addi $sp, $sp, -4
sw $ra, 4($sp)
lw $a1, n
jal insertionSort
lw $ra, 4($sp)
addi $sp, $sp, 4
jr $ra

