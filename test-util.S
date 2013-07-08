.section .text, "ax"

.global _start
_start:
	bl	init_stack

test:	ldr	x1, =hello
	bl	log

exit:	movz	w0, #0x18	/* Exit */
	hlt	#0xf000
	b	.

init_stack:
	adr	x29, stack
	ldr	x29, [x29]
	mov	sp, x29
	ret

hello:	.ascii "Hello, world!\n\0"
 
.align 2
stack:	.quad 0x0000000088000000
