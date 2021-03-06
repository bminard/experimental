#include <boost/next_prior.hpp>
#include <set>
#include <list>
#include <vector>

int main(int argc, char *argv[])
{
    std::vector<int> vmyints { 1, 2, 3, 4, 5 }; // next_prior contains tests for vector, but not this case; works; vector supports random access iterators
    boost::prior(vmyints.rbegin(), 1);

    std::set<int> myints { 1, 2, 3, 4, 5 };
    boost::prior(myints.rbegin(), 1); // reproducer in ticket; fails; does not support random access iterators

    std::list<int> lmyints { 1, 2, 3, 4, 5 }; // next_prior contains tests for list, but not this case; fails; does not support random access iterators
    boost::prior(lmyints.rbegin(), 1);

    return 0;
}
