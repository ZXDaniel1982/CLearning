/*******************************************************************************
 *    (c) Copyright 2015 Aviat Networks, all rights reserved
 ******************************************************************************/

/*******************************************************************************
 *  @file acli.c
 *
 *  Aviat CLI agent.
 *  Launched by sshd to connect to an ISS CLI instance.
 *
 *
 ******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <syslog.h>
#include <errno.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <poll.h>
#include <termios.h>

#include<sys/types.h>  
#include <stddef.h>  



#define WEBSOCK_DIR  ("/tmp/iss")
#define WEBSOCK_PATH_NAME ("/tmp/iss/issWebsock")

const char *startstr = "Start";
const char *stopstr = "Stop";

int connectIss(void)
{
    // connect to ISS to authenticate
    struct sockaddr_un saddr; 
    int sock = socket(AF_UNIX, SOCK_STREAM, 0);
    socklen_t len;  

    memset(&saddr, 0, sizeof(saddr));
    saddr.sun_family = AF_UNIX;
    strcpy(saddr.sun_path, WEBSOCK_PATH_NAME);
    saddr.sun_path[0]=0; 
    len =  strlen(WEBSOCK_PATH_NAME)  + offsetof(struct sockaddr_un, sun_path); 

    if (sock < 0) {
        printf("failed to create UN socket, errno=%d\n", errno);
        return -1;
    }

    if (connect(sock, (struct sockaddr *)&saddr, len) < 0) {
        char buf[256];
        strerror_r(errno, buf, sizeof(buf));
        printf("failed to connect UN socket, errno %d (%s)\n", errno, buf);
        close(sock);
        return -1;
    }
    printf("connected to ISS\n");
    return sock;
}

int main(int argc, char **argv)
{
    int cliSock;
    struct pollfd fds[2];
    char opt;

    char revStr[256];

    char ch = 'A';  

    if ((cliSock = connectIss()) < 0) {
        printf("failed to connect to ISS CLI\n"); 
        exit(1);
    }

    printf("step 1\n"); 

    
    int sent = write(cliSock, startstr, strlen(startstr)+1);
    if (sent < 0) {
        printf("failed to send credentials to ISS CLI, errno=%d\n",errno); 
        exit(1);
    }

    printf("step 2\n");
    if (sent != (strlen(startstr)+1)) {
        printf("failed to send credentials to ISS CLI, %d sent\n", sent);
        exit(1);
    }
    printf("step 3\n");

    fds[0].fd = cliSock;
    fds[0].events = POLLIN;
    fds[0].revents = 0;

    fds[1].fd = STDIN_FILENO;
    fds[1].events = POLLIN;
    fds[1].revents = 0;

    while (1) {
        int events = poll(fds, 3, 1000);
        if (events > 0) {
            //printf("AVIAT_WEBSOCK_FD %d AVIAT_TIMER_FD %d\n", fds[0].revents, fds[1].revents);
            if (fds[0].revents) {
                if (read(fds[0].fd, revStr, 5) >= 0) {
                    printf("read from server: %s\n", revStr);
                    printf("\n");
                }
            }
            if (fds[1].revents) {
                printf("Do you want to stop it? Y/N: ");
                scanf("%c", &opt);
                /*sent = write(fds[0].fd, "book", 5);
                printf("send to server:  book \n");  
                if (sent < 0) {
                    printf("failed to send credentials to ISS CLI, errno=%d\n",errno); 
                }*/
                if ((opt == 'Y') || (opt == 'y')) {
                    sent = write(cliSock, "book", 5);
                    if (sent < 0) {
                        printf("failed to send credentials to ISS CLI, errno=%d\n",errno); 
                    }

                    /*if (sent != (sizeof(stopstr))) {
                        printf("failed to send credentials to ISS CLI, %d sent\n", sent);
                    }*/
                    //printf("\n");
                    //break;
                }

            }
        } 
    }

/*
    // Now run a full-duplex connection between SSHD and ISS CLI until one disconnects
    printf("Do you want to stop? Y/N : \n");
    while (1) {
        int events = poll(fds, 2, 1000);
        if (events > 0) {
            printf("recieve something\n");
            if (fds[0].revents) {
                if (read(fds[0].fd,revStr,256) >= 0) {
                    printf("%s\n", revStr);
                    printf("\n");
                }
            }
            if (fds[1].revents) {
                printf("Do you want to stop it? Y/N: ");
                scanf("%c", &opt);
                if ((opt == 'Y') || (opt == 'y')) {
                    sent = write(cliSock, stopstr, sizeof(stopstr));
                    if (sent < 0) {
                        printf("failed to send credentials to ISS CLI, errno=%d\n",errno); 
                    }

                    if (sent != (sizeof(stopstr))) {
                        printf("failed to send credentials to ISS CLI, %d sent\n", sent);
                    }
                    printf("\n");
                    break;
                }
            }
        }
    }
    */

    close(cliSock);
    return 0;
}


