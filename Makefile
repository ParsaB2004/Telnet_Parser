CC       = gcc
CFLAGS   = -Wall -Wextra -pedantic -std=c99
LDFLAGS  =
FLEX     = flex
BISON    = bison

.PHONY: all clean distclean

all: telnet_parser

telnet.tab.c telnet.tab.h: telnet.y
	$(BISON) -d telnet.y

lex.yy.c: telnet.l telnet.tab.h
	$(FLEX) telnet.l

telnet_parser: telnet.tab.c lex.yy.c
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

clean:
	rm -f telnet_parser telnet_parser.exe

distclean: clean
	rm -f lex.yy.c telnet.tab.c telnet.tab.h

run: telnet_parser
	./telnet_parser < input.text
