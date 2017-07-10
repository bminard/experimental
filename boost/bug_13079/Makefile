TEST_CASE=bug_13079.cc
TEST=a.out
INCLUDES=$(basename ${TEST_CASE}).i
CXX_FLAGS=

all: ${INCLUDES} ${TEST}

${INCLUDES}: ${TEST_CASE}
	g++ ${CXX_FLAGS} -E -Wall -Werror -L${HOME}/install/lib -I${HOME}/install/include -o $@ $<

${TEST}: ${TEST_CASE}
	g++ ${CXX_FLAGS} -ggdb -Wall -Werror -L${HOME}/install/lib -I${HOME}/install/include -o $@ $<

clean:
	-rm ${TEST}
	-rm ${INCLUDES}
