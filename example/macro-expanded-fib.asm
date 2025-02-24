
.data
    input_prompt: .asciiz "input integer: "
.text 

.data
    done: .asciiz "\ndone :)"
    got_input: .asciiz "got input: "
    fibonaccin: .asciiz "\nfibonacci "
    colons: .asciiz " : "

.text
main:
    
    
    la $a0, input_prompt
    li $v0, 4
    syscall

    li $v0, 5
    syscall 
    move $t1, $v0 
 
    addiu $sp $sp -8
    sw $t1 0($sp)
    add $t2 $t2 $zero
    sw $t2 4($sp)
    
    la $a0, got_input
    li $v0, 4
    syscall

    
    move $a0, $t1
    li $v0, 1
    syscall

    
    li $a0, 0x0A
    li $v0, 11
    syscall
 
loop:
    
    la $a0, fibonaccin
    li $v0, 4
    syscall
 
    lw $t2 4($sp)
    
    move $a0, $t2
    li $v0, 1
    syscall
 
    
    la $a0, colons
    li $v0, 4
    syscall
 
    
    
    lw $a0 4($sp)
    jal fibonacci
    
    move $a0, $v0
    li $v0, 1
    syscall
 
    lw $t2 4($sp)
    addiu $t2 $t2 1
    sw $t2 4($sp)
    lw $t1 0($sp)
    blt $t2 $t1 loop

    j EXIT

fibonacci:
    addiu $sp $sp -12
    sw $ra 0($sp)
    sw $a0 4($sp)
    blt $a0 2 base_case
    addi $a0 $a0 -1
    jal fibonacci
    sw $v0 8($sp) 
    lw $a0 4($sp)
    addi $a0 $a0 -2
    jal fibonacci
    lw $t0 8($sp)
    addu $v0 $v0 $t0
    j clear_stk
base_case:
    add $v0 $a0 $zero
    j clear_stk 
clear_stk:
    lw $ra 0($sp)
    addiu $sp $sp 12
    jr $ra

EXIT:
    
    la $a0, done
    li $v0, 4
    syscall

    li $v0, 10              
    syscall

