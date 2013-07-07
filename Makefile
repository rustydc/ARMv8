default: hello.axf test-util.axf

test-util.axf: test-util.o swi-util.o
	ld -Ttext=0x80000000 test-util.o swi-util.o -o test-util.axf

hello.axf: hello.o
	ld -Ttext=0x80000000 hello.o -o hello.axf

%.o: %.S
	as $< -o $@

clean:
	rm -f *.o hello.axf test-util.axf
