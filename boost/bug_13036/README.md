# [Bug 13036 Boost.Regex: Integer overflow during calculation of max\_state\_count](https://svn.boost.org/trac10/ticket/13036)

## Problem Description

Data type involved in the calculation is `std::ptrdiff_t`. `std::ptrdiff_t` is
a signed integer type whose declaration is implementation dependent.

The `states` variable declared in `max_state_count()` is initialized with the
value of a function returning type `std::size_t`. `std::size_t` is an unsigned
integer type whose declaration is implementation dependent.

Signed integer representations contain a sign bit. Thus, a 32-bit type is
capable of holding at most 2^31 values.

Overflow on CentOS 7-1611 i386 occurs whenever there are 46,341 (sqrt(2^31)) or
more states.  CentOS 7-1611 x86\_64 requires 3,037,000,500 or more states.

The test case forces overflow on i386 architectures.

No other architectures were tested.

To run:

```shell
  > export LD\_LIBRARY\_PATH=$LD\_LIBRARY\_PATH:<path to installed libraries>
  > make
  > a.out
  > gdb a.out
  (gdb) source script.gdb
  (gdb) r
```

## Investigation

Signed integer overflow can be detected using [INT32-C. Ensure that operations on signed integers do not result in overflow](https://www.securecoding.cert.org/confluence/display/c/INT32-C.+Ensure+that+operations+on+signed+integers+do+not+result+in+overflow).
This check simplifies to the unsigned integer overflow check
`a > max(type(a)) / b`, when `a` and `b` are both positive. In this case,
`a` and `b` are positve and the same variable.

However, the a relationship between `std::ptrdiff_t` and `std::size_t`
that may point to another issue in this method: we need a guarantee that
`size_t` will always fit into `ptrdiff_t`. This is backwards to what
seems intuitive as they may have the same basic type but the fact that
`ptrdiff_t` is signed reduces the range by 2.
