
// Pointer-free version using valarray template.
// LLVM: clang++ -O3 -std=c++0x A3-Microrun.cpp -o mb; ./mb
// Visual 2010 C++: cl /Ox /Ob2 /Oi /Ot /Oy- /Ox /Ob2 /Oi /Ot /Oy- /EHsc A3-Microrun.cpp

#include <cstdlib>
#include <cmath>
#include <ctime>
#include <valarray>
#include <iostream>

using namespace std;

inline double rand01() {
    return static_cast<double>(rand()) /
           static_cast<double>(RAND_MAX);
}

void test() {
    clock_t start = clock();

    static const size_t N = 1000000;
    valarray<double> a(N);
    for (size_t i = 0; i < N; ++i)
        a[i] = rand01();

    double s = a.sum();
    double t = sqrt((a*a).sum());

    double duration = (clock() - start) /
        static_cast<double>(CLOCKS_PER_SEC);
    cout << "N: " << N << " in " << duration << "s" << endl;
    cout << "Result: " << s << " and " << t << endl;    
}

int main() {
    srand(static_cast<unsigned int>(time(NULL)));
    test();
    return 0;
}
