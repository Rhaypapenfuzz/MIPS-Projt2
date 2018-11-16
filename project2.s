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
