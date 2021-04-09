CCC = g++
CCFLAGS = -c -ggdb -Wall
LDFLAGS = -ggdb

parser: parse.tab.cpp scan.cpp
	$(CCC) $(LDFLAGS) parse.tab.cpp -o parser

parse.tab.cpp: parse.y
	bison -v parse.y; /bin/mv parse.tab.c parse.tab.cpp

scan.cpp: scan.l
	flex -t scan.l > scan.cpp

clean:
	/bin/rm -f scan.cpp parser parse.tab.cpp parse.output test.out

test: parser
	./parser -1 < test.py > test.out
