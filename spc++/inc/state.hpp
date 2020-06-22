#pragma once

class IState
{
public:
    virtual ~IState() = default;
};

class StateInit : public IState {
};
