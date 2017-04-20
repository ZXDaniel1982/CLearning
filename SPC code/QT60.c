#include "systemvalue.h"
#include "QT60.h"
#include "I2C.h"
#include "PIC18F6622.h"
#include "String_op.h"

/* DEFINES */
/*#define LEN_QT_SETUP                123
#define NUM_QT_KEYS                 9
#define NUM_QT_KEY_BYTES            3

#define QT_REV_OFFSET               0
#define QT_KEYS_OFFSET              1
#define QT_CALIBRATE_OFFSET         125
#define QT_UNLOCK_OFFSET            130
#define QT_SETUP_OFFSET             131

#define QT_COMMAND_CODE             0x55*/

/* TYPES */
struct param_def {
        UCHAR Offset;
        UCHAR Position;
        UCHAR Mask;
        };

/* LOCAL DATA */
volatile unsigned char QtSetupBlock[LEN_QT_SETUP]; /* setup image */
volatile UCHAR TestBuff[123]; /* setup image */
UCHAR QtAddress = 117;        /* assumes default device address */
UCHAR QtKeys[NUM_QT_KEY_BYTES];
UCHAR calibufer;


/* CONSTANTS */
code struct param_def ParamDef[] = {
        /* NTHR        */                { 0,          0,        0x0f        },
        /* NDRIFT      */                { 0,          4,        0x0f        },
        /* PDRIFT      */                { 24,         0,        0x0f        },
        /* NDIL        */                { 48,         0,        0x0f        },
        /* FDIL        */                { 48,         4,        0x0f        },
        /* NRD         */                { 72,         0,        0xff        },
        /* WAKE        */                { 96,         3,        0x01        },
        /* BL          */                { 96,         4,        0x03        },
        /* AKS         */                { 96,         6,        0x01        },
        /* SSYNC       */                { 96,         7,        0x01        },
        /* SLEEP       */                { 120,        0,        0x07        },
        /* MSYNC       */                { 120,        6,        0x01        },
        /* AWAKE       */                { 121,        0,        0xff        },
        /* DHT         */                { 122,        0,        0xff        }
        }; /* used to insert / extract fields in setup image */

UCHAR QtCommand = QT_COMMAND_CODE; /* used to pass command byte to I2c driver */

//==============================================================================
//Restore QT60160 as default
//input£ºnone
//output£ºflag of pass
//==============================================================================
void RestoreDefaultQtSetup ( void )
{
  UCHAR i;

  /* write default values to key parameters for all keys */
  for (i = 0; i < 24; i++)             //NUM_QT_KEYS
  {
    QtSetupBlock[i]      = QT_DEF_NTHR + (QT_DEF_NDRIFT << 4);
    QtSetupBlock[i + 24] = QT_DEF_PDRIFT;
    QtSetupBlock[i + 48] = QT_DEF_NDIL + (QT_DEF_FDIL << 4);
    QtSetupBlock[i + 72] = QT_DEF_NRD;
    QtSetupBlock[i + 96] = QT_DEF_BL << 4;
  }

  /* write global parameters */
  QtSetupBlock[120] = QT_DEF_SLEEP;
  QtSetupBlock[121] = QT_DEF_AWAKE;

  /* set DHT default by calling SetQtSetup() also writes device */
  //return ( SetQtSetup(0, QT_PARAM_DHT, QT_DEF_DHT, TRUE) );

    I2C_write (QtAddress,
             QT_UNLOCK_OFFSET,
             &QtCommand,
             1);
    I2C_write (QtAddress,
             131,
             QtSetupBlock,
             122);

}

//==============================================================================
//setting for QT60160
//input£ºkeys need to be set, Parameter to be set, data for QT60, writer flag
//output£ºflag of pass
//==============================================================================
UCHAR SetQtSetup ( UCHAR Key, UCHAR Param, UCHAR Value, UCHAR WriteFlag )
{
  UCHAR RetVal = TRUE; /* function return value */
  UCHAR Temp;
  UCHAR Index;

  /* calculate index into Setup image aarray */
  Index = ParamDef[Param].Offset;
  if ( Param <= QT_PARAM_SSYNC )
    Index += Key;

  /* only process data if a valid index has been specified */
  if ( (Index < LEN_QT_SETUP) && (Key < NUM_QT_KEYS) )
  {
    /* overwrite relevant bit-field within Setup image using ParamDef array */
    Temp = (Value & ParamDef[Param].Mask) << ParamDef[Param].Position;
    QtSetupBlock[Index] &= ~(ParamDef[Param].Mask << ParamDef[Param].Position);
    QtSetupBlock[Index] += Temp;

    if ( WriteFlag )        /* if required, write complete Setup image to QT device */
    {
      I2C_write (QtAddress, QT_UNLOCK_OFFSET, &QtCommand, 1);
      I2C_write (QtAddress, QT_SETUP_OFFSET, QtSetupBlock, LEN_QT_SETUP);
    }
  }
  else
    RetVal = FALSE; /* fail if illegal parameter was specified */

  return RetVal; /* completed */
}

//==============================================================================
//read the setting from QT60160
//input£ºnone
//output£ºnone
//==============================================================================
void ReadQtSetup ( void )
{
  I2C_get( QtAddress, 131, TestBuff, 123);
}

//==============================================================================
//read the data from QT60160
//input£ºnone
//output£ºnone
//==============================================================================
void ReadQtKeys ( void )
{
  I2C_get( QtAddress, QT_KEYS_OFFSET, QtKeys, NUM_QT_KEY_BYTES);
}

//==============================================================================
//read the data from register
//input£ºbytes of key value
//output£ºdata
//==============================================================================
UCHAR GetQtKeys(UCHAR Index)
{
  return QtKeys[Index];
}

//==============================================================================
//enable key hold function
//input£ºnone
//output£ºnone
//==============================================================================
void setkeyhold()
{
  MemeSet(QtSetupBlock, QT_HOLD_NRD, NUM_QT_KEYS);
  asm nop;

  I2C_write (QtAddress,
             QT_UNLOCK_OFFSET,
             &QtCommand,
             1);
  I2C_write (QtAddress,
             QT_SETUP_OFFSET+ParamDef[QT_PARAM_NRD].Offset,
             QtSetupBlock,
             NUM_QT_KEYS);
  /*I2C_get(QtAddress,
          QT_SETUP_OFFSET+ParamDef[QT_PARAM_NRD].Offset,
          QtSetupBlock,
          NUM_QT_KEYS);*/
  asm nop;
}

//==============================================================================
//set the sensitive of keys
//input£ºnone
//output£ºnone
//==============================================================================
void setkeysence()
{
  volatile UCHAR bufer;

  bufer = QT_SENS_NTHR + (QT_DEF_NDRIFT << 4);
  MemeSet(QtSetupBlock, bufer, NUM_QT_KEYS);
  asm nop;

  I2C_write (QtAddress,
             QT_UNLOCK_OFFSET,
             &QtCommand,
             1);
  I2C_write (QtAddress,
             QT_SETUP_OFFSET+ParamDef[QT_PARAM_NTHR].Offset,
             QtSetupBlock,
             NUM_QT_KEYS);
  /*I2C_get(QtAddress,
          QT_SETUP_OFFSET+ParamDef[QT_PARAM_NTHR].Offset,
          QtSetupBlock,
          NUM_QT_KEYS);*/
  asm nop;
}

//==============================================================================
//disable the multi keys function
//input£ºnone
//output£ºnone
//==============================================================================
void setkeysenceaks()
{
  volatile UCHAR bufer;

  bufer = (QT_SENS_AKS << 6) + (1 << 4);
  MemeSet(QtSetupBlock, bufer, NUM_QT_KEYS);
  /*QtSetupBlock[0] = (QT_SENS_AKS << 6) + (1 << 4);
  QtSetupBlock[8] = (QT_SENS_AKS << 6) + (1 << 4);*/
  asm nop;
  
  I2C_write (QtAddress,
             QT_UNLOCK_OFFSET,
             &QtCommand,
             1);
  I2C_write (QtAddress,
             QT_SETUP_OFFSET+ParamDef[QT_PARAM_AKS].Offset,
             QtSetupBlock,
             NUM_QT_KEYS);
  /*I2C_get(QtAddress,
          QT_SETUP_OFFSET+ParamDef[QT_PARAM_AKS].Offset,
          QtSetupBlock,
          NUM_QT_KEYS);*/
  asm nop;
}

//==============================================================================
//disable the keys not used
//input£ºnone
//output£ºnone
//==============================================================================
void enablekeys()
{
  UCHAR bufer;
  char i;

  bufer = QT_DEF_NDIL + (QT_DEF_FDIL << 4);
  for(i=0;i<NUM_QT_KEYS;i++)
  {
    QtSetupBlock[i] = bufer;
  }
  bufer = 0 + (QT_DEF_FDIL << 4);
  for(;i<24;i++)
  {
    QtSetupBlock[i] = bufer;
  }
  asm nop;

  I2C_write (QtAddress,
             QT_UNLOCK_OFFSET,
             &QtCommand,
             1);
  I2C_write (QtAddress,
             QT_SETUP_OFFSET+ParamDef[QT_PARAM_NDIL].Offset,
             QtSetupBlock,
             24);
  /*I2C_get(QtAddress,
          QT_SETUP_OFFSET+ParamDef[QT_PARAM_NDIL].Offset,
          QtSetupBlock,
          24);*/
  asm nop;
}

//==============================================================================
//calibrate all the keys
//input£ºnone
//output£ºnone
//==============================================================================
void calikey()
{
  calibufer = 0x55;
  asm nop;

  I2C_write (QtAddress,
             QT_UNLOCK_OFFSET,
             &QtCommand,
             1);
  I2C_write (QtAddress,
             125,
             &calibufer,
             1);
  Delay_ms(500);
  asm nop;
}