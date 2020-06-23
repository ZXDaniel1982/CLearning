#include "helper.hpp"

void ShowTemper(SpcTemperature_t aTemp, bool Celsius)
{
    auto dataStatus = static_cast<DataStatus>(aTemp.status);

    cout << "Heater Temp" << endl;
    if (kDataStat.find(dataStatus) != kDataStat.end()) {
        cout << kDataStat.at(dataStatus) << endl;
    } else {
        if (Celsius)
            cout << aTemp.tempc << " C" << endl;
        else
            cout << aTemp.tempf << " F" << endl;
    }
}