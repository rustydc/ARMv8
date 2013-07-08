.global log
log:
# Address of string to log is in R1.
	mov	x29, x30
	mov	w25, w1

	ldr	x1, =elap	
	mov	w0, #0x30	/* elapsed instructions */
	hlt	#0xf000

	ldr	x7, =testdata
	ldr	w6, [x7]
	bl	print_quad
	ldr	w6, [x7, #4]
	bl	print_quad

	# Print the string
	mov	x1, x25
	mov	w0, #0x04
	hlt	#0xf000


	ret	x29

.global print_quad
print_quad:
# [0 1 2 3 4 6 26 27 28 30]
	mov	x27, x30
	rev	w6, w6
	mov	w26, #0
	pq_loop:
	 bl	print_byte
	 add	w26, w26, #1
	 cmp	w26, #4
	 asr	w6, w6, #8
	 blt	pq_loop
	ldr	x1, =hbyte
	mov	x2, #0x7c
	strb	w2, [x1]
	mov	x0, #0x03
	hlt	#0xf000
	ret	x27

print_r5:
	mov	x24, x30
	ret	x24

print_byte:
# R6 is a byte.
# [0 1 2 3 4 6 28 30]
	mov	x28, x30
	asr	w1, w6, #4      /* Top four bits.    */
	and	w1, w1, #0x0000000f
	bl	print_nibble
	and	w1, w6, #0x0000000f     /* Bottom four bits. */
	bl	print_nibble
	ret	x28

print_nibble:
# R1 is a nibble.
# [0 1 2 3 4 30]
	ldr	x4, =hbyte
	add	w2, w1, #0x30   /* R2 = '0' + w1 */
	add	w3, w1, #0x57   /* R3 = 'a' + w1  - 10 */
	cmp	x1, #9
	csel	w1, w2, w3, ls
	strb	w1, [x4]
	mov	x1, x4
	mov	w0, #0x03
	hlt	#0xf000
	ret

elap:
	.word 0x00000000
	.word 0x00000000

hbyte:
	.byte 0x00

.align 8
testdata:
	.word 0x01234567
	.word 0xdeadbeef

newline:
	.byte '\n'
