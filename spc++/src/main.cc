#include "engin.hpp"

using namespace std;

int key = 0;

int main(int aArgc, char** aArgs)
{
    cout << "Spc function start" << endl;

    auto engin = std::make_shared<SpcEngin>();

    while (1) {
        int key = 0; cin >> key;
        if (kKeys.find(key) != kKeys.end()) {
            engin->Update(kKeys.at(key));
        } else {
            engin->Update(Opt::Empty);
        }
    }
    return 0;
}