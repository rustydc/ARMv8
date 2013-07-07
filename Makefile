hello.axf: hello.o
	ld -Ttext=0x80000000 hello.o -o hello.axf

hello.o: hello.S
	as hello.S -o hello.o

clean:
	rm -f hello.o hello.axf
