// Compiled using g++ (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11) on CentOS 7-1611
// using 3.10.0-514.21.2.el7.x86_64 and 3.10.0-514.21.2.el7.centos.plus.i686.

#include <cstddef>
#include <string>
#include <iostream>
#include <limits>

using namespace std;

// this includes perl_matcher_common.hpp, the file containing the templated method with the overflow.
#include <boost/regex.hpp>


// Example 8.2. Searching strings with boost::regex_search() from https://theboostcpplibraries.com/boost.regex.
int main()
{
  std::string s = "Boost Libraries";
  boost::regex expr(std::string(46341, '.')); // force overflow; use 3,037,000,500 on 64-bit architectures
  //boost::regex expr("(\\w+)\\s(\\w+)");
  boost::smatch what;
  if (boost::regex_search(s, what, expr))
  {
    std::cout << what[0] << '\n';
    std::cout << what[1] << "_" << what[2] << '\n';
  }
}
