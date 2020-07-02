#include "state.hpp"
#include "helper.hpp"

// Init state
std::shared_ptr<IState>
StateInit::Update(
    std::shared_ptr<SpcData_t>      aData,
    Opt                             aOpt)
{
    auto mod = static_cast<DefInfo>(aData->config.system.bytes.defInfo);
    return std::make_shared<StateDefStatus>(aData, mod);
}

// Show default info
StateDefStatus::StateDefStatus(
    std::shared_ptr<SpcData_t>      aData,
    DefInfo                         aDefInfo)
    : iDefInfo      (aDefInfo)
{
    // Internal action
    iInterFuncs.try_emplace(DefInfo::SysStatus, [&]() {
        int alarmNum = 2;
        cout << alarmNum << " Alarms" << endl;
    });
    iInterFuncs.try_emplace(DefInfo::HeaterStatus, [&]() {
        auto rdtStat = static_cast<RdtStat>(aData->config.system.bytes.rdtStat);
        ShowHeatStatus(rdtStat);
    });
    iInterFuncs.try_emplace(DefInfo::HeaterTemp, [&]() {
        auto unit = static_cast<bool>(aData->config.system.bytes.unit);
        ShowTemper(aData->config.MaintainTemp, unit);
    });

    Update(aData, Opt::Empty);
}

std::shared_ptr<IState>
StateDefStatus::Update(
    std::shared_ptr<SpcData_t>      aData,
    Opt                             aOpt)
{
    switch (aOpt) {
    case Opt::Empty:
        if (iInterFuncs.find(iDefInfo) != iInterFuncs.end()) {
            auto func = iInterFuncs.at(iDefInfo);
            if (func) func();
        }
        return {};
    case Opt::Actual:
        return std::make_shared<StateActual>(aData);
    case Opt::Prog:
        return std::make_shared<StateProg>(aData);
    default:
        return {};
    }
}

// Actual
StateActual::StateActual(std::shared_ptr<SpcData_t> aData)
{
    Update(aData, Opt::Empty);
}

std::shared_ptr<IState>
StateActual::Update(
    std::shared_ptr<SpcData_t>      aData,
    Opt                             aOpt)
{
    switch (aOpt) {
    case Opt::Empty:
        cout << "Actual" << endl;
        cout << endl;
        return {};
    case Opt::Actual:
        return std::make_shared<StateActualStatistic>(aData);
    case Opt::Prog:
        return std::make_shared<StateProg>(aData);
    case Opt::Right:
        return std::make_shared<StateHeatStatus>(aData);
    default:
        return {};
    }
}

// StateHeatStatus
StateHeatStatus::StateHeatStatus(std::shared_ptr<SpcData_t> aData)
{
    Update(aData, Opt::Empty);
}

std::shared_ptr<IState>
StateHeatStatus::Update(
    std::shared_ptr<SpcData_t>      aData,
    Opt                             aOpt)
{
    RdtStat rdtStat;
    switch (aOpt) {
    case Opt::Empty:
        rdtStat = static_cast<RdtStat>(aData->config.system.bytes.rdtStat);
        ShowHeatStatus(rdtStat);
        return {};
    case Opt::Actual:
        return std::make_shared<StateActualStatistic>(aData);
    case Opt::Prog:
        return std::make_shared<StateProg>(aData);
    default:
        return {};
    }
}

// Actual statistic
StateActualStatistic::StateActualStatistic(std::shared_ptr<SpcData_t> aData)
{
    Update(aData, Opt::Empty);
}

std::shared_ptr<IState>
StateActualStatistic::Update(
    std::shared_ptr<SpcData_t>      aData,
    Opt                             aOpt)
{
    switch (aOpt) {
    case Opt::Empty:
        cout << "Statistics" << endl;
        cout << endl;
        return {};
    case Opt::Actual:
        return std::make_shared<StateActual>(aData);
    case Opt::Prog:
        return std::make_shared<StateProg>(aData);
    default:
        return {};
    }
}

// Programme
StateProg::StateProg(std::shared_ptr<SpcData_t> aData)
{
    Update(aData, Opt::Empty);
}

std::shared_ptr<IState>
StateProg::Update(
    std::shared_ptr<SpcData_t>      aData,
    Opt                             aOpt)
{
    switch (aOpt) {
    case Opt::Empty:
        cout << "Program" << endl;
        cout << endl;
        return {};
    case Opt::Actual:
        return std::make_shared<StateActual>(aData);
    default:
        return {};
    }
}
