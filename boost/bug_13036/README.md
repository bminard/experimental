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
  > export LD\_LIBRARY\_PATH=$LD\_LIBRARY\_PATH:${HOME}/install/lib
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

However, the relationship between `std::ptrdiff_t` and `std::size_t` may
point to another issue: we need a guarantee that `size_t` will always fit into `ptrdiff_t`. This is backwards to what seems intuitive as they may have the same basic type but the fact that `ptrdiff_t` is signed reduces the range by 2.

## C++ Programming Language

### [support.types](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4296.pdf)
5 The type ptrdiff_t is an implementation-defined signed integer type that can hold the difference of two subscripts in an array object, as described in 5.7.
6 The type size_t is an implementation-defined unsigned integer type that is large enough to contain the size in bytes of any object.
7 [Note: It is recommended that implementations choose types for ptrdiff_t and size_t whose integer conversion ranks (4.13) are no greater than that of signed long int unless a larger size is necessary to contain all the possible values. — end note ]

### [conv.integral](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4296.pdf)
1 A prvalue of an integer type can be converted to a prvalue of another integer type. A prvalue of an unscoped enumeration type can be converted to a prvalue of an integer type.
2 If the destination type is unsigned, the resulting value is the least unsigned integer congruent to the source integer (modulo 2n where n is the number of bits used to represent the unsigned type). [ Note: In a two’s complement representation, this conversion is conceptual and there is no change in the bit pattern (if there isnotruncation). —endnote]
3 If the destination type is signed, the value is unchanged if it can be represented in the destination type; otherwise, the value is implementation-defined.

Line 3 of this clause implies the assignment is implementation defined when the source value cannot be represented in the destination.

## References

[Seacord Book, Chapter 5](http://ptgmedia.pearsoncmg.com/images/0321335724/samplechapter/seacord_ch05.pdf)
[Working Draft, Standard for Programming Lanugage C++](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4296.pdf)
