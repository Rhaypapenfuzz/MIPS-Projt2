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
