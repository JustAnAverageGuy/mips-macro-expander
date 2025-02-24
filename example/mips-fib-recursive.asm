# vim: ft=mips fdm=marker sw=4

#### Takes the number of fibonacci numbers to print, and prints them, using recursion ####


# .include "utils.asm"

# utils.asm {{{

# vim: ft=mips

#### COLLECTION OF USEFUL MACROS ####

# print_str
# print_int
# print_ln
# get_input

.data
    input_prompt: .asciiz "input integer: "
.text 

.macro print_str(%label)
    la $a0, %label
    li $v0, 4
    syscall
.end_macro

.macro print_int(%label)
    move $a0, %label
    li $v0, 1
    syscall
.end_macro

.macro print_ln()
    li $a0, 0x0A
    li $v0, 11
    syscall
.end_macro

.macro get_input(%register)
    print_str(input_prompt)
    li $v0, 5
    syscall # take input in register v0
    move %register, $v0 # input is in now a1 register
.end_macro


# }}}


# t1 holds n

.data
    done: .asciiz "\ndone :)"
    got_input: .asciiz "got input: "
    fibonaccin: .asciiz "\nfibonacci "
    colons: .asciiz " : "

.text
main:
    get_input($t1) # get inp
    addiu $sp $sp -8
    sw $t1 0($sp)
    add $t2 $t2 $zero
    sw $t2 4($sp)
    print_str(got_input)
    print_int($t1)
    print_ln() #
loop:
    print_str(fibonaccin) # commenting to separate macros
    lw $t2 4($sp)
    print_int($t2) #
    print_str(colons) #
    # lw $t2 4($sp)
    # add $a0 $t2 $zero
    lw $a0 4($sp)
    jal fibonacci
    print_int($v0) #
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
    j clear_stk # unnecessary, but added for semantic clarity
clear_stk:
    lw $ra 0($sp)
    addiu $sp $sp 12
    jr $ra




EXIT:
    print_str(done)
    li $v0, 10              # Exit syscall
    syscall
