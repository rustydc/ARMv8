.global log
/* Address of string to log in R1. */
log:
mov     x29, x30
mov     w4, w1

#ldr     x1, =elap    
#mov     w0, #0x30    /* SWI: elapsed  */
#hlt     #0xf000      /* R1 = &elap */

mov     w6, #140
bl      print_byte

ret     x29

print_byte:
mov     x28, x30
asr     w1, w6, #4      /* Top four bits.    */
bl      print_nibble
and     w1, w6, #15     /* Bottom four bits. */
bl      print_nibble
ret x28

print_nibble:
# R1 is a nibble.
ldr     x4, =hbyte
add     w2, w1, #0x30   /* R2 = '0' + w1 */
add     w3, w1, #0x57   /* R3 = 'a' + w1  - 10 */
cmp     x1, #9
csel    w1, w2, w3, ls
strb    w1, [x4]
mov     x1, x4
mov     w0, #0x03
hlt     #0xf000
ret


hex_byte:
ldr     b6, [x6]
ldr     x8, =hbyte

asr     w1, w6, #4      /* Top four bits. */
add     w5, w1, #0x30   /* R5 = '0' + w1 */
add     w7, w1, #0x61   /* R7 = 'a' + w1 */
cmp     w1, #9
csel    w1, w5, w7, mi

strb    w1, [x8]
mov     x1, x8
mov     w0, #0x03
hlt     #0xf000

and     x1, x6, #15
cmp     w1, #9
csel    w1, w5, w7, mi
strb    w1, [x8]
mov     x1, x8
mov     w0, #0x03
hlt     #0xf000

ret

elap:
  .word 0x00000000
  .word 0x00000000

hbyte:
  .byte 0x00
