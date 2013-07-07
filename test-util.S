.section .text, "ax"
.global _start
_start:
# Attempt to initialize the stack?
#adr     x1, stack_addr
#ldr     x1, [x1]
#mov     sp, x1

ldr     w1, =hello
bl      log
movz    w0, #0x18    /* SWI: Exit     */
hlt     #0xf000
b       .            /* Infinite loop */

hello:
  .ascii "\nHello, world!\n"

stack_addr:
  .quad  0x0000000088000000
