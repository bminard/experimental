boost::variant<int, long, double, bool, string> v1("11");
cout << v1.type().name()<<endl;//bool******************why?
boost::variant<int, long, double, bool, string> v2(string("11"));
cout << v2.type().name() << endl;//class std::basic_string<char,struct std::char_traits<char>,class std::allocator<char> >
return 0;
