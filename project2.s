.data           #Data declaration section
#Invalid Messages
char_array:			.space 4000
too_long:			.asciiz "Input is too long."
not_valid:			.asciiz "Invalid base-31 number."
empty_string_error: .asciiz "Input is empty."

.text           #Assembly language instruction
.globl main

main:
