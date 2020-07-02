#pragma once

#include <memory>
#include <functional>
#include <iostream>
#include "data.hpp"

using namespace std;

const std::unordered_map<RdtStat, std::string>  kRdtStat = {
    {RdtStat::Off,    "Heater is Off"},
    {RdtStat::On,     "Heater is On"},
    {RdtStat::ManOff, "Heater is ManOn"},
    {RdtStat::ManOn,  "Heater is ManOff"},
};

const std::unordered_map<int, Opt> kKeys = {
    {7, Opt::Actual},
    {9, Opt::Prog},
    {5, Opt::Enter},
    {8, Opt::Up},
    {2, Opt::Down},
    {4, Opt::Left},
    {6, Opt::Right},
};

class IState
{
public:
    virtual ~IState() = default;
    virtual std::shared_ptr<IState> Update(std::shared_ptr<SpcData_t>, Opt) = 0;
};

class StateInit : public IState {
public:
    std::shared_ptr<IState> Update(std::shared_ptr<SpcData_t>, Opt) override;
};

class StateDefStatus : public IState {
public:
    StateDefStatus(std::shared_ptr<SpcData_t>, DefInfo);
public:
    std::shared_ptr<IState> Update(std::shared_ptr<SpcData_t>, Opt) override;
private:
    DefInfo                     iDefInfo;
    std::unordered_map<DefInfo, std::function<void()>>     iInterFuncs;
};

class StateActual : public IState {
public:
    StateActual(std::shared_ptr<SpcData_t>);
public:
    std::shared_ptr<IState> Update(std::shared_ptr<SpcData_t>, Opt) override;
};

class StateHeatStatus : public IState {
public:
    StateHeatStatus(std::shared_ptr<SpcData_t>);
public:
    std::shared_ptr<IState> Update(std::shared_ptr<SpcData_t>, Opt) override;
};

class StateActualStatistic : public IState {
public:
    StateActualStatistic(std::shared_ptr<SpcData_t>);
public:
    std::shared_ptr<IState> Update(std::shared_ptr<SpcData_t>, Opt) override;
};

class StateProg : public IState {
public:
    StateProg(std::shared_ptr<SpcData_t>);
public:
    std::shared_ptr<IState> Update(std::shared_ptr<SpcData_t>, Opt) override;
};
