#define QT_HOLD_NRD 0
#define QT_SENS_NTHR 15
#define QT_SENS_AKS 1


#define                QT_DEF_NTHR              6
#define                QT_DEF_NDRIFT            10
#define                QT_DEF_PDRIFT            4
#define                QT_DEF_NDIL              2
#define                QT_DEF_FDIL              5
#define                QT_DEF_NRD               20
#define                QT_DEF_WAKE              0
#define                QT_DEF_BL                2
#define                QT_DEF_AKS               0
#define                QT_DEF_SSYNC             0
#define                QT_DEF_SLEEP             3
#define                QT_DEF_MSYNC             0
#define                QT_DEF_AWAKE             255
#define                QT_DEF_DHT               10

#define        QT_PARAM_NTHR 0
#define        QT_PARAM_NDRIFT 1
#define        QT_PARAM_PDRIFT 2
#define        QT_PARAM_NDIL 3
#define        QT_PARAM_FDIL 4
#define        QT_PARAM_NRD 5
#define        QT_PARAM_WAKE 6
#define        QT_PARAM_BL 7
#define        QT_PARAM_AKS 8
#define        QT_PARAM_SSYNC 9
#define        QT_PARAM_SLEEP 10
#define        QT_PARAM_MSYNC 11
#define        QT_PARAM_AWAKE 12
#define        QT_PARAM_DHT 13

#define LEN_QT_SETUP                123
#define NUM_QT_KEYS                9
#define NUM_QT_KEY_BYTES        3

#define QT_REV_OFFSET                0
#define QT_KEYS_OFFSET                1
#define QT_CALIBRATE_OFFSET        125
#define QT_UNLOCK_OFFSET        130
#define QT_SETUP_OFFSET                131

#define QT_COMMAND_CODE                0x55

void RestoreDefaultQtSetup ( void );
UCHAR SetQtSetup ( UCHAR Key, UCHAR Param, UCHAR Value, UCHAR WriteFlag );
void ReadQtSetup ( void );
void ReadQtKeys ( void );
UCHAR GetQtKeys(UCHAR Index);
void setkeyhold(void);
void setkeysence(void);
void setkeysenceaks(void);
void enablekeys(void);
void calikey(void);