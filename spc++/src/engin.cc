#include "engin.hpp"

SpcEngin::SpcEngin()
{
    iCurrentState = std::make_unique<StateInit>();
}