.data           #Data declaration section
#Invalid Messages
char_array:			.space 4000
too_long:			.asciiz "Input is too long."
not_valid:			.asciiz "Invalid base-31 number."
empty_string_error: .asciiz "Input is empty."

.text           #Assembly language instruction
.globl main

main:
        li $v0, 8
        la $a0, char_array
        syscall
        la $t0, char_array			#loading address of userInput
	lb $t1, 0($t0)					#get string character
	li $t2, 0					#initializing counter i as zero
        li $t3, 32					#storing space char into $t3
        li $s0, 0					#counter to help keep track of previous character. initialized as 0
        li $t5, 0					#initialized number of chracters
        li $t6, 10					#loaded new line into $t6
	li $t7, 0					#another counter to help with number of spaces in front of actual input

loop:
        lb $t1, 0($t0)					#get string character
        beq $t1, $t6, break_loop        #break when character is a newline char
	#if statements for different conditions and actions
        beq $t1, $t3, dont_print_invalid_spaces         #if character is_not a space &
        bne $s0, $t3, dont_print_invalid_spaces         #if the previous_character is a space &
        beq $t5, $0, dont_print_invalid_spaces          #if the number_of_previously_seen_characters is not zero &
        beq $t1, $0, dont_print_invalid_spaces          #if the character is_not_null &
       	beq $t1, $t6, dont_print_invalid_spaces         #if the character is_not_new_line then print invalid
        li $v0, 4
        la $a0, not_valid
        syscall	
	
	#print invalid spaces
	li $v0, 10
	syscall
	
	dont_print_invalid_spaces:
        beq $t1, $t3, dont_incr_num_of_characters       #increase number of characters counter if character is not a space
        addi $t5, $t5, 1
	
	dont_incr_num_of_characters:
        bne $t1, $t3, dont_count_space          #if current character is a space and
        bne $t5, $0, dont_count_space           #if num of previous character is equal to 0 then count space
        addi $t7, $t7, 1
	dont_count_space:
        move $s0, $t1           #set previous character with current one
        addi $t0, $t0, 1        #incremented the address
        addi $t2, $t2, 1        #incremented i
        j loop
	break_loop:
        li $t1, 4
        ble $t5, $t1, dont_print_too_long       #checks if userInput is more than 4
        li $v0, 4
        la $a0, too_long
	syscall					#print too_long_error if char>4
	li $v0, 10
	syscall
	dont_print_too_long:
        bne $t5, $zero, dont_print_empty_string_error   #if user input is empty, and
        beq $t1, $t6, dont_print_empty_string_error     #if user input is a newline print invalid
        li $v0, 4
        la $a0, empty_string_error
        syscall
