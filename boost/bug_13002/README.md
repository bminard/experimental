# Bung #13002 boost::prior does not compile when used with std::set reverse_iterator

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

The C++ language standard requires a random access iterator to support the
expression `r += n`. See [random.access.iterators].

std::sets support bidirectional iterators. They do not support random access iterators.
