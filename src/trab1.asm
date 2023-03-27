        .data
        
ADD:	 .asciiz "ADD: " 
SUB:	 .asciiz "\nSUB: " 
AND:	 .asciiz "\nAND: " 
OR:	 .asciiz "\nOR: " 
XOR:	 .asciiz "\nXOR: " 
SLL:	 .asciiz "\nSLL(3): " 
SRL:	 .asciiz "\nSRL(1): " 

        .text
.globl main
        
main:

	#leitura
ler1:
        li $v0, 5
        syscall
        move $s0, $v0
        
        slti $t8, $s0, 255 
        beq $t8, $zero, ler1

	#leitura
ler2:    
        li $v0, 5
        syscall
        move $s1, $v0

        slti $t8, $s1, 255 
        beq $t8, $zero, ler2        

	#operacoes
	add $t0, $s0, $s1
	sub $t1, $s0, $s1
	and $t2, $s0, $s1
	or  $t3, $s0, $s1
	xor $t4, $s0, $s1
	sll $t5, $s0, 3
	srl $t6, $s1, 1

	#prints
        li $v0, 4
        la $a0, ADD 
        syscall
        li $v0, 1
        la $a0, ($t0)
        syscall

        li $v0, 4
        la $a0, SUB 
        syscall
        li $v0, 1
        la $a0, ($t1)
        syscall
        
        li $v0, 4
        la $a0, AND 
        syscall
        li $v0, 1
        la $a0, ($t2)
        syscall
        
        li $v0, 4
        la $a0, OR 
        syscall
        li $v0, 1
        la $a0, ($t3)
        syscall
        
	li $v0, 4
        la $a0, XOR 
        syscall
        li $v0, 1
        la $a0, ($t4)
        syscall
        
        li $v0, 4
        la $a0, SLL 
        syscall
        li $v0, 1
        la $a0, ($t5)
        syscall
        
        li $v0, 4
        la $a0, SRL 
        syscall
        li $v0, 1
        la $a0, ($t6)
        syscall	
        
        li $v0, 10
        syscall
