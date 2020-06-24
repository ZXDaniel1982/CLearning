#include "engin.hpp"

SpcEngin::SpcEngin()
    :   iData           (new SpcData_t())
    ,   iCurrentState   (new StateInit())
{
    Update(Opt::Empty);
}

void
SpcEngin::Update(Opt aOpt)
{
    auto state = iCurrentState->Update(iData, aOpt);

    if (state != nullptr) {
        iCurrentState = std::move(state);
    }
}