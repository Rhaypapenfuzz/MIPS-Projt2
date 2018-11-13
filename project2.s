.data
	char_array: .space 1000
	#Invalid Messages
	not_valid: .asciiz "Invalid base-31 number."
	empty: .asciiz "Input is empty."
	too_long: .asciiz "Input is too long."
.text
.globl main
