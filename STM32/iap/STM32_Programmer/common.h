#ifndef __COMMON_H__
#define __COMMON_H__

#ifdef __cplusplus
 extern "C" {
#endif

int set_interface_attribs (int fd, int speed, int parity);
void set_blocking (int fd, int should_block);

#ifdef __cplusplus
}
#endif

#endif /* __COMMON_H__ */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
