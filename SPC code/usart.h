#define RE LATF4_bit
#define DE LATF3_bit

void USART_send(UCHAR *bufout, char len);
void en485rx(void);
void en485tx(void);
void CommunicationErrorCheck(void);