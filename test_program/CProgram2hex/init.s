
.section .text
.global _start
_start:
	lui sp,0x100
	lui s0,0x100
	call main

