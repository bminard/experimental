#include <iostream>
#include <boost/variant.hpp>

using namespace std;

int main() {
  // simplest reproducer
  boost::variant< bool, string> v5("11");
  cout << "v5 (2 elements): " << v5.type().name()<<endl;
  boost::variant< bool, string> v6(string("11"));
  cout << "v6 (2 elements): " << v6.type().name() << endl;

  boost::variant<string> v3("11");
  cout << "v3 (1 element): " << v3.type().name()<<endl;
  boost::variant<string> v4(string("11"));
  cout << "v4 (1 element): " << v4.type().name() << endl;

  boost::variant< double, string> v9("11");
  cout << "v9 (2 elements): " << v9.type().name()<<endl;
  boost::variant< double, string> v10(string("11"));
  cout << "v10 (2 elements): " << v10.type().name() << endl;

  boost::variant<double, bool, string> v7("11");
  cout << "v7 (3 elements): " << v7.type().name()<<endl;
  boost::variant<double, bool, string> v8(string("11"));
  cout << "v8 (3 elements): " << v8.type().name() << endl;

  boost::variant<int, long, double, bool, string> v1("11");
  cout << "v1 (5 elements): " << v1.type().name()<<endl;//bool******************why?
  boost::variant<int, long, double, bool, string> v2(string("11"));
  cout << "v2 (5 elements): " << v2.type().name() << endl;//class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >

  return 0;
}
