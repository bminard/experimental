all: a.out

a.out: bug_13036.cc
	g++ -O0 -ggdb -Wall -Werror -L${HOME}/install/lib -lboost_regex -I${HOME}/install/include -o $@ $<

clean:
	-rm a.out
