# Bung #13002 boost::prior does not compile when used with std::set reverse_iterator

## To Do's

  - fix the bug reported against std::set

  - fix the issue discovered against std::list

## Background

Variances over bug report text: 

  1. header file name used in ticket is incorrect.

    Action: fixed.

  2. test environment header file versions use 4.8.2; ticket uses 4.8.3.

    Action: ignored.

    Compiler messages generated in the test environment are identical (same file,
    line and line position) as the messages in the ticket.

The [std::reverse_iterator](http://en.cppreference.com/w/cpp/iterator/reverse_iterator)
provides the `rbegin()` method used in the reproducer.

Compiler error (generated with 4.8.2):

```
g++ -ggdb -Wall -Werror -std=c++11 -L/home/bminard/install/lib -I/home/bminard/install/include -o a.out bug_13002.cc
In file included from /usr/include/c++/4.8.2/iterator:63:0,
                 from /home/bminard/install/include/boost/next_prior.hpp:15,
                 from bug_13002.cc:1:
/usr/include/c++/4.8.2/bits/stl_iterator.h: In instantiation of ‘std::reverse_iterator<_Iterator>& std::reverse_iterator<_Iterator>::operator-=(std::reverse_iterator<_Iterator>::difference_type) [with _Iterator = std::_Rb_tree_const_iterator<int>; std::reverse_iterator<_Iterator>::difference_type = long int]’:
/home/bminard/install/include/boost/next_prior.hpp:138:11:   required from ‘static T boost::next_prior_detail::prior_impl1<T, Distance, true>::call(T, Distance) [with T = std::reverse_iterator<std::_Rb_tree_const_iterator<int> >; Distance = int]’
/home/bminard/install/include/boost/next_prior.hpp:160:68:   required from ‘T boost::prior(T, Distance) [with T = std::reverse_iterator<std::_Rb_tree_const_iterator<int> >; Distance = int]’
bug_13002.cc:7:36:   required from here
/usr/include/c++/4.8.2/bits/stl_iterator.h:265:10: error: no match for ‘operator+=’ (operand types are ‘std::_Rb_tree_const_iterator<int>’ and ‘std::reverse_iterator<std::_Rb_tree_const_iterator<int> >::difference_type {aka long int}’)
  current += __n;
          ^
make: *** [a.out] Error 1
```

## Compiler Trace

```
/usr/include/c++/4.8.2/bits/stl_iterator.h:265:10: error: no match for ‘operator+=’
```

The underlying iterator must be a Random Access Iterator. `std::set`
iterators are bidirectional. Bidirectional iterators are random access
iterators.

```
/home/bminard/install/include/boost/next_prior.hpp:160:68: required from ‘T boost::prior(T, Distance) [with T = std::reverse_iterator<std::_Rb_tree_const_iterator<int> >; Distance = int]’
```

```
/home/bminard/install/include/boost/next_prior.hpp:138:11:   required from ‘static T boost::next_prior_detail::prior_impl1<T, Distance, true>::call(T, Distance) [with T = std::reverse_iterator<std::_Rb_tree_const_iterator<int> >; Distance = int]’
```

```
/usr/include/c++/4.8.2/bits/stl_iterator.h: In instantiation of ‘std::reverse_iterator<_Iterator>& std::reverse_iterator<_Iterator>::operator-=(std::reverse_iterator<_Iterator>::difference_type) [with _Iterator = std::_Rb_tree_const_iterator<int>; std::reverse_iterator<_Iterator>::difference_type = long int]’
```

## Observations

  * The forward iterator, using the `begin()` method compiles without any compiler messages.

  * The preprocessor produces identical include files for the forward and reverse iterators.

  * Utility test cases exist for forward iterators on std::lists and std::vector
    (both sequence containers). Reproducer uses std::set (an associative container).

    Only std::vector passes the reproducer.

## Relevant Source Files

Last commit 651a869d4f9479dd3dfdd0293305a60b8c8d0e1c. Introduces support for integral distances and tests.

  * include/boost/next_prior.hpp (modified to support distance parameters)
  * test/next_prior_test.cpp (introduced to test above)

## References

Boost Devel mailing list discussions:

  - Andrey Semashev, Daryle Walker, and David Abrahams

  - [[boost] [utility] prior(it, n) for n being an unsigned type](https://lists.boost.org/Archives/boost/2014/06/214788.php)
  - [[boost] Re: Patch for next() and prior()](https://lists.boost.org/Archives/boost/2003/12/58074.php)

Documentation:

  - [Header boost/utility.hpp](http://www.boost.org/doc/libs/1_64_0/libs/utility/utility.htm)
  - [Function templates next() and prior()](http://www.boost.org/doc/libs/1_64_0/libs/utility/utility.htm#functions_next_prior)
  - [Bug #13002 boost::prior does not compile when used with std::set reverse_iterator](https://svn.boost.org/trac10/ticket/13002)
  - [Working Draft, Standard for Programming Language C++, N4296](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2014/n4296.pdf)
