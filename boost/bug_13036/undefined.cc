#include <cstddef>
#include <iostream>
#include <iomanip>
#include <limits>
#include <typeinfo>

int main() {
    std::ptrdiff_t f = std::numeric_limits<std::size_t>::max();
    std::cout << "std::ptrdiff_t f: " << "(" <<typeid(f).name() << ")" << std::setw(20) << f << std::endl;

    std::ptrdiff_t g = std::numeric_limits<std::ptrdiff_t>::max();
    std::cout << "std::ptrdiff_t g: " << "(" <<typeid(g).name() << ")" << std::setw(20) << g << std::endl;

    std::ptrdiff_t h = std::numeric_limits<std::ptrdiff_t>::max() + 1;
    std::cout << "std::ptrdiff_t h: " << "(" <<typeid(h).name() << ")" << std::setw(20) << h << std::endl;

    std::cout << "std::ptrdiff_t: " << "(" <<typeid(std::ptrdiff_t).name() << ")" << std::setw(20) << std::numeric_limits<std::ptrdiff_t>::max() << std::endl;
    std::cout << "std::size_t:    " << "(" <<typeid(std::size_t).name() << ")" << std::numeric_limits<std::size_t>::max() << std::endl;
    return 0;
}
