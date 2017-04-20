#define CURRENTGFI_MEASURE 0
#define INITIAL_COMMAND 1
#define FINISH_COMMAND 2
#define CURRENT_CALIBRATION_STEP 3
#define GFI_CALIBRATION_STEP 4

   #define GFIPOINT1 4
   #define GFIPOINT2 5
   #define GFIPOINT3 6
   #define GFIPOINT4 7
   #define GFIPOINT5 8
   #define GFIPOINT6 9
   
   #define CURRENTPOINT1 10
   #define CURRENTPOINT2 11
   #define CURRENTPOINT3 12
   #define CURRENTPOINT4 13
   #define CURRENTPOINT5 14
   
   #define CALIBRATERTDALOW 0
   #define CALIBRATERTDAHIGH 1
   #define CALIBRATERTDBLOW 2
   #define CALIBRATERTDBHIGH 3

typedef struct tagSPCCALIBRATIONREG
{
  int CalibartionActural;
  int CalibartionSetpoint;
}SPCCALIBRATIONREG;

typedef struct tagSPCCALIBRATIONSTRTCTURE
{
  SPCCALIBRATIONREG GFICalibrationNod1;
  SPCCALIBRATIONREG GFICalibrationNod2;
  SPCCALIBRATIONREG GFICalibrationNod3;
  SPCCALIBRATIONREG GFICalibrationNod4;
  SPCCALIBRATIONREG GFICalibrationNod5;
  SPCCALIBRATIONREG GFICalibrationNod6;
  SPCCALIBRATIONREG CurrentCalibrationNod1;
  SPCCALIBRATIONREG CurrentCalibrationNod2;
  SPCCALIBRATIONREG CurrentCalibrationNod3;
  SPCCALIBRATIONREG CurrentCalibrationNod4;
  SPCCALIBRATIONREG CurrentCalibrationNod5;
  SPCCALIBRATIONREG TempCalibrationNodLowA;
  SPCCALIBRATIONREG TempCalibrationNodHighA;
  SPCCALIBRATIONREG TempCalibrationNodLowB;
  SPCCALIBRATIONREG TempCalibrationNodHighB;
}SPCCALIBRATIONSTRTCTURE;

typedef struct tagSPCCALIBRATIONBOX
{
  char CalibartionType;
  char CalibartionAddress;
  int CalibartionData;
}SPCCALIBRATIONBOX;


void SPCCalibration(void);
void SetCommand(char CommandType, char CommandData);
char GetCommand(char CommandType);
int GetCalibrationData(SPCCALIBRATIONREG *Ptr,char Location, char ActualReq);
void InitialCalibrationReg(void);

extern char CalibrationCount;
extern char SPCCalibrationEN;
extern char SPCTestingEN;
//extern SPCCALIBRATIONREG SPCCalibrationReg[15];
extern SPCCALIBRATIONSTRTCTURE SPCCalibrationStructure[2];
extern SPCCALIBRATIONBOX SPCCalibrationBox;