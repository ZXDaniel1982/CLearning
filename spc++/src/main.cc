#include <iostream>
#include "engin.hpp"

using namespace std;

int main(int aArgc, char** aArgs)
{
    cout << "Spc function start" << endl;

    auto engin = std::make_shared<SpcEngin>();
    return 0;
}