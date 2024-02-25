.data
#EXAMPLE
n: .word 6
example: .word 5, 7, 1, -1, -2, -1000

.text 

.globl main

bubbleSort:
#$t0 := &A[N-i-1] (therefore the limits of the loop are from A+4*n-4 to A and the loop step is -4)

#&A[N-i-1] = &A[n-0-1]     (i=0)
addi $t0, $a1, -1
sll $t0, $t0, 2
add $t0, $t0, $a0

#$t1 NOT USED

#$t2 := swapped

L1:
#if !(&A[N-i-1]>&A): exit L1     (if i < N-1)
slt $t3, $a0, $t0
beq $t3, $zero, exitL1

or $t2, $zero, $zero #swapped = false

#$t3 := &A[j]
or $t3, $zero, $a0 #&A[j] = $A[0]

#$t4 NOT USED

L2:
#if !(&A[j] < &A[N-1-i]): exit L2
slt $t5, $t3, $t0
beq $t5, $zero, exitL2

lw $t5, 0($t3)
lw $t6, 4($t3)

#if !(A[j+1] < A[j]): do not swap
slt $t7, $t6, $t5
beq $t7, $zero, skipSwap

#A[j+1], A[j] = A[j], A[j+1]
sw $t5, 4($t3)
sw $t6, 0($t3)

ori $t2, $zero, 1 #swapped = true

skipSwap:
addi $t3, $t3, 4 #j++
j L2

exitL2:
beq $t2, $zero, exitL1
addi, $t0, $t0, -4 #i++ (reminder: $t0 = &A[n-i-1])
j L1

exitL1:
jr $ra


#ONLY FOR DEMONSTRATION PURPOSES
main:
la $a0, example
addi $sp, $sp, -4
sw $ra, 4($sp)
lw $a1, n
jal bubbleSort
lw $ra, 4($sp)
addi $sp, $sp, 4
jr $ra

