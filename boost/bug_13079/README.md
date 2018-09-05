# Bug #13079 boost::variant(const char\*->bool)

## Problem Description

The type name (obtained using `type().name()`) depends upon how `boost::variant`
is initialized.

Reported against Boost 1.64.

Variants:

  1. `boost::variant<int, long, double, bool, string> v1("11")`

  2. `boost::variant<int, long, double, bool, string> v2(string("11"))`

### Related Issues

Searched for description containing boost::variant. One unassigned ticket: 13079.

## Reproducer

Variances from ticket description.

  1. Execute reproducer.
  
  2. Simplify reproducer.
  
  Two element templates produce the same result as the original reproducer. For example:

```
boost::variant< bool, string> v5("11");
cout << "v5 (2 elements): " << v5.type().name()<<endl;
boost::variant< bool, string> v6(string("11"));
cout << "v6 (2 elements): " << v6.type().name() << endl;
```

Further testing shows that the problem is tied to the bool. Template argument ordering is irrelevant.

## References

### Tickets

  - [Ticket 13079](https://svn.boost.org/trac10/ticket/13079)

### Module Documentation

 - [Boost Variant (Module)](http://www.boost.org/doc/libs/1_64_0/doc/html/variant.html)

 - [Boost Variant (Source)](https://github.com/boostorg/variant)

 - [Class template boost::variant](http://www.boost.org/doc/libs/1_64_0/doc/html/boost/variant.html)

### Language Standard [n4296](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4296.pdf)

n4296 covers C++14 plus a little extra.

 - [expr.dynamic.cast]; a failed dynamic cast to a pointer type is null pointer
   value of the required type. A failed cast to reference throws an exception of
   a type matching a handler for `std::bad_cast`.

 - [expr.typeid]

 - [support.rtti]

 - [type.info]
