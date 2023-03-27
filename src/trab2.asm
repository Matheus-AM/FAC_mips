        .data

resto:	.asciiz "resto = "
quociente: .asciiz "quociente = "
divisor: .asciiz "digite o divisor: "
dividendo: .asciiz "digite o dividendo: "

fim:	.asciiz "\n" 

        .text
        
.globl main

main:


	li $v0, 4
       	la $a0, divisor 
       	syscall

        li $v0, 5
        syscall
        move $s0, $v0

	li $v0, 4
       	la $a0, dividendo 
       	syscall

        li $v0, 5
        syscall
        move $s1, $v0
	
	
	slt $t0, $s0, $zero #flag de negativo
	slt $t1, $s1, $zero #flag de negativo

	addi $sp, $sp, -8
	
	sw $t0, ($sp)
	sw $t1, 4($sp)
	
	beq $t0, $zero, else1
	sub $s0, $zero, $s0	#se for negativo, vira positivo
else1:
	beq $t1, $zero, else2
	sub $s1, $zero, $s1	#se for negativo, vira positivo
else2:	
	
	move $a0, $s0
	move $a1, $s1

	jal divfac
                 
	lw $t1, 4($sp)
	lw $t0, ($sp)
        
        addi $sp, $sp, 8
                        
        #mflo $s1;
        #mfhi $s2;
                        
	xor $t3, $t1, $t0
	                        
       	beq $t3, $zero, else3
	sub $s1, $zero, $s1
else3:
	
	li $v0, 4
        la $a0, quociente 
        syscall   
        
        li $v0, 1
        move $a0, $s1
        syscall
        
        li $v0, 4
        la $a0, fim 
        syscall

	li $v0, 4
       	la $a0, resto 
       	syscall
                        
        li $v0, 1
        move $a0, $s2
        syscall
exit:     
        li $v0, 4
        la $a0, fim 
        syscall
        
        li $v0, 10
        syscall
        
        
divfac:
	li $t0, 1 		#PASSO 1
	move $s0, $a0
	move $s1, $a1
	
	srl $t1, $s1, 31 	#PASSO 2
	add $s2, $t1, $s2	#
				#
	sll $s1, $s1, 1		#
	
passo3:
	sub $s2, $s2, $s0 	#PASSO 3
	
	slt $t8, $s2, $zero 		#PASSO 4
	beq $t8, $zero, positivo	#
					#
	add $s2, $s2, $s0		#
					#
positivo:				#
	srl $t1, $s1, 31 		#
	sll $s2, $s2, 1  		#
	add $s2, $t1, $s2		#
					#
	sll $s1, $s1, 1			#
					#
	bne $t8, $zero, passo5		#
					#
	addi $s1, $s1, 1		#

passo5:
	slti $t8, $t0, 32	#PASSO 5
	beq $t8, $zero, passo6	#
				#
	addi $t0, $t0, 1	#
	j passo3		#
	
passo6:
	srl $s2, $s2, 1		#PASSO 6
	
	#mtlo $s1;
	#mthi $s2;
	
jr $ra
