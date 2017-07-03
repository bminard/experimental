all: a.out undefined

a.out: bug_13036.cc
	g++ -O0 -ggdb -Wall -Werror -L${HOME}/install/lib -lboost_regex -I${HOME}/install/include -o $@ $<

undefined: undefined.cc
	g++ -O0 -ggdb -Wall -Werror -o $@ $<

clean:
	-rm a.out undefined
