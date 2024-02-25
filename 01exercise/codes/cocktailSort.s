.data
#EXAMPLE
n: .word 6
example: .word 5, 7, 1, -1, -2, -1000

.text 

.globl main

cocktailSort:
ori $t0, $zero, 1 #swapped = true
or $t1, $zero, $a0 #start = &A[0]

#end = &A[n-1]
or $t2, $zero, $a1
addi $t2, $t2, -1
sll $t2, $t2, 2
add $t2, $t2, $a0

L1:
beq $t0, $zero, exitL1
or $t0, $zero, $zero #swapped = false
or $t3, $zero, $t1 #i = &A[start]

L2:
#if !(i<end): exitL2
slt $t4, $t3, $t2
beq $t4, $zero, exitL2

lw $t4, 0($t3) #$t4 = A[i]
lw $t5, 4($t3) #$t5 = A[i+1]

#if !(A[i+1]<A[i]) skip the swap
slt $t6, $t5, $t4
beq $t6, $zero, skipSwapL2

#A[i], A[i+1] = A[i+1], A[i]
sw $t4, 4($t3)
sw $t5, 0($t3)

ori $t0, $zero, 1 #swapped = true

skipSwapL2:
addi $t3, $t3, 4 #i++
j L2

exitL2:
beq $t0, $zero, exitL1
or $t0, $zero, $zero #swapped = false
addi $t2, $t2, -4 #end--
addi $t3, $t2, -4 #i = &A[end-1]

L3:
#if i<start: exitL3
slt $t4, $t3, $t1
bne $t4, $zero, exitL3

lw $t4, 0($t3) #$t4 = A[i]
lw $t5, 4($t3) #$t4 = A[i+1]

#if !(A[i+1]<A[i]) skip the swap
slt $t6, $t5, $t4
beq $t6, $zero, skipSwapL3

#A[i], A[i+1] = A[i+1], A[i]
sw $t4, 4($t3)
sw $t5, 0($t3)

ori $t0, $zero, 1 #swapped = true

skipSwapL3:
addi $t3, $t3, -4 #i--
j L3

exitL3:
addi $t1, $t1, 4 #start++
j L1

exitL1:
jr $ra


#ONLY FOR DEMONSTRATION PURPOSES
main:
la $a0, example
addi $sp, $sp, -4
sw $ra, 4($sp)
lw $a1, n
jal cocktailSort
lw $ra, 4($sp)
addi $sp, $sp, 4
jr $ra

