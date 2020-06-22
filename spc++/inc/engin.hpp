#pragma once

#include <memory>
#include "state.hpp"

class IEngine
{
public:
    virtual ~IEngine() = default;
};

class SpcEngin : public IEngine {
public:
    SpcEngin();
private:
    std::unique_ptr<IState>         iCurrentState;
};
