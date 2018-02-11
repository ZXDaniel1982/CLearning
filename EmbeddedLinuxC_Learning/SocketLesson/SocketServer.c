/**
 * @addtogroup AviatIntefaceStats
 * @{
 * @file    ais_main.c
 * @author  Shreyas.Joshi@aviatnet.com
 * @date    05/10/2017
 * @brief   Main ISS thread for the Aviat Interface Status (ais_main) on the CTR
 *
 */
#include <stdbool.h>
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

#include <sys/stat.h>

#include<sys/types.h>  
#include <stddef.h>  

#define WEBSOCK_DIR  ("/tmp/iss")
#define WEBSOCK_PATH_NAME ("/tmp/iss/issWebsock")

#define AVIAT_WEBSOCK_FD 0
#define AVIAT_TIMER_FD    1
#define AVIAT_NODE_CLIENT_FD 2

#define USER_CTRL_BUFF_SIZE (256)

char *startstr = "Start";

bool gAviatIntStatsDebugEnabled = true;

struct sockaddr_un client_addr;
int client_sockfd;
socklen_t client_len;

int ais_createServerSocket(void)
{

    struct sockaddr_un saddr;
    socklen_t server_len;
    char buf[128];

    int sock = socket(AF_UNIX, SOCK_STREAM, 0);
    if (sock < 0)
    {
        printf("failed to create UN socket, errno=%d\n", errno);
        return -1;
    }

    //memset(&saddr, 0, sizeof(saddr));
    saddr.sun_family = AF_UNIX;
    // strncpy(saddr.sun_path, WEBSOCK_PATH_NAME, sizeof(saddr.sun_path));
    strcpy(saddr.sun_path, WEBSOCK_PATH_NAME);
    saddr.sun_path[0]=0;
    server_len = strlen(WEBSOCK_PATH_NAME)  + offsetof(struct sockaddr_un, sun_path); 

    //int opt = 1;
    //setsockopt(sock,SOL_SOCKET,SO_REUSEADDR,&opt,sizeof(opt));

    if (bind(sock, (struct sockaddr *)&saddr, server_len) < 0) {
        strerror_r(errno, buf, sizeof(buf));
        printf("failed to bind address %s errno=%d: %s\n",
                WEBSOCK_PATH_NAME, errno, buf);
        close(sock);
        return -1;
    }

    if (listen(sock, 5) != 0) {
        strerror_r(errno, buf, sizeof(buf));
        printf("listen failed for %s errno=%d: %s\n",
                WEBSOCK_PATH_NAME, errno, buf);
        close(sock);
        perror("listen failed: ");
        return -1;
    }

    printf("Created WebIntStat Server ISS\n");
    return sock;
}

/*
static int acceptClient(int sock, struct pollfd *fds)
{
    int sd = accept(sock, (struct sockaddr*)&client_addr, &client_len);

    printf("step 10\n");

    if (sd < 0) {
        printf("Failed to accept client connection\n");
    } else {
        // add a new client
        fds->fd = sd;
        fds->events = POLLIN;
        fds->revents = 0;
    }
    return sd;
}
*/

void handleStatSockets(struct pollfd *fds, nfds_t *numfds, int events, bool *enableStat)
{
    char usrCtrlData[USER_CTRL_BUFF_SIZE];
    char revStr[256];
    int res = 0;
    int nread;
    int sent;

    //memset(usrCtrlData,0,USER_CTRL_BUFF_SIZE);

    printf("step 3\n");

    // Client Connection
    //if (fds[AVIAT_WEBSOCK_FD].revents & POLLIN)
    //{
        printf("step 4\n");
        // got a connect request
        if (client_sockfd = accept(fds[AVIAT_WEBSOCK_FD].fd, (struct sockaddr*)&client_addr, &client_len) >= 0)
        {
            /*if(client_sockfd == -1){  
                client_sockfd = accept(fds[AVIAT_WEBSOCK_FD].fd,(struct sockaddr*)&client_addr, &client_len);  
            } */
            printf("step 4.1\n");
            printf("client.%d connected\n", (int)*numfds);

            if (client_sockfd == -1) {
                printf("Fail to accept\n");
            }

            nread = read(client_sockfd, revStr, 5);
            //int nread = read(client_sockfd, usrCtrlData, 5);
            if(nread == 0){//client disconnected  
                printf("client %d disconnected\n",client_sockfd);  
                client_sockfd = -1;  
            }  
            else{  
                printf("read from client %d: %s\n",client_sockfd,revStr);  
            }  

            sent = write(client_sockfd, "vbbn", 5);
            if (sent < 0) {
                printf("failed to send credentials to ISS CLI, errno=%d\n",errno); 
            }

            /*if (sent != (sizeof(startstr))) {
                printf("failed to send credentials to ISS CLI, %d sent\n", sent);
            }*/
            printf("\n");

            *numfds += 1;
        }
        else
        {
            printf("step 4.2\n");
            printf("Failed client connection\n");
        }
        events--;
    //}
    if (fds[AVIAT_TIMER_FD].revents & POLLIN) {

    }

    printf("step 5 %d\n", (int)*numfds);

    // A connection exists read from the socket connection
 /*   if(*numfds > AVIAT_TIMER_FD)
    {
        printf("step 6\n");
        if (fds[AVIAT_NODE_CLIENT_FD].revents)
        {
            printf("step 7\n");
            if (fds[AVIAT_NODE_CLIENT_FD].revents & POLLERR)
            {
                // client disconnect - this should never happen
                printf("Node got disconnected!!!");
                printf("step 8\n");
                events--;
            }
            else if (fds[AVIAT_NODE_CLIENT_FD].revents & POLLIN)
            {
                printf("step 9\n");
                // data from client
                res = read(fds[AVIAT_NODE_CLIENT_FD].fd,usrCtrlData,USER_CTRL_BUFF_SIZE);
                if( res < 0)
                {
                    printf("Error in Reading Usr Ctrl word!!!\n");
                }
                else
                {
                    if(!strcmp(usrCtrlData,"Start"))
                    {
                        printf("Got Ctrl Word Start\n");
                        *enableStat = true;
                    }
                    else if (!strcmp(usrCtrlData,"Stop"))
                    {
                        printf("Got Ctrl Word Stop\n");
                        *enableStat = false;
                    }
                }

                events--;
            }
            fds[AVIAT_NODE_CLIENT_FD].revents = 0;
        }
    }*/
}

void handle(struct pollfd *fds, int events)
{
    int nread;  

    char revStr[256];

    printf("AVIAT_WEBSOCK_FD %d AVIAT_TIMER_FD %d events %d\n", fds[AVIAT_WEBSOCK_FD].revents, fds[AVIAT_TIMER_FD].revents, events);
    //if (fds[AVIAT_WEBSOCK_FD].revents & POLLIN) {
    printf("event\n");  
    if(client_sockfd == -1){  
        client_sockfd = accept(fds[AVIAT_WEBSOCK_FD].fd,(struct sockaddr*)&client_addr, &client_len);  
    } 
    //handleStatSockets(fds, &numfds, events,&interaceStat);

    nread = read(client_sockfd, revStr, 5);

    if(nread == 0){//client disconnected  
        printf("client %d disconnected\n",client_sockfd);  
        client_sockfd = -1;  
    }  
    else{  
        printf("read from client %d: %s\n",client_sockfd,revStr);  
        //ch ++;  
        write(client_sockfd, "vbbn", 5);  
    } 
}

void main (int argc, char **argv)
{
    struct pollfd fds[2];
    memset(fds, 0, sizeof(fds));
    nfds_t numfds;
    int webSock = -1;
    bool interaceStat = false;

    char ch;  
    int nread;  

    char revStr[256];

    webSock = ais_createServerSocket();

    if( webSock == -1)
    {
        printf("Failed to Create AIS Socket\n");
        return;

    }

    client_sockfd = -1;  
    client_len = sizeof(client_addr);  

    // make the CLI socket usable by everyone
    //chmod(WEBSOCK_PATH_NAME, 0777);

    numfds = AVIAT_NODE_CLIENT_FD; //  WEBSOCK_FD, TIMER_FD

    fds[AVIAT_WEBSOCK_FD].fd = webSock;
    fds[AVIAT_WEBSOCK_FD].events = POLLIN;
    fds[AVIAT_WEBSOCK_FD].revents = 0;

    fds[AVIAT_TIMER_FD].fd = STDIN_FILENO;
    fds[AVIAT_TIMER_FD].events = POLLIN;
    fds[AVIAT_TIMER_FD].revents = 0;

    while (1) {
        // printf("server waiting...\n");

        int events = poll(fds, 3, 1000);
        if (events > 0) {
            handle(fds, events);
            /*printf("AVIAT_WEBSOCK_FD %d AVIAT_TIMER_FD %d events %d\n", fds[AVIAT_WEBSOCK_FD].revents, fds[AVIAT_TIMER_FD].revents, events);
            //if (fds[AVIAT_WEBSOCK_FD].revents & POLLIN) {
                printf("event\n");  
                if(client_sockfd == -1){  
                    client_sockfd = accept(fds[AVIAT_WEBSOCK_FD].fd,(struct sockaddr*)&client_addr, &client_len);  
                } 
                //handleStatSockets(fds, &numfds, events,&interaceStat);

                nread = read(client_sockfd, revStr, 5);

                if(nread == 0){//client disconnected  
                    printf("client %d disconnected\n",client_sockfd);  
                    client_sockfd = -1;  
                }  
                else{  
                    printf("read from client %d: %s\n",client_sockfd,revStr);  
                    //ch ++;  
                    write(client_sockfd, "vbbn", 5);  
                } */
                //fds[AVIAT_WEBSOCK_FD].events = POLLIN | POLLERR;
                //fds[AVIAT_WEBSOCK_FD].revents = 0;
            //}
        }

/*
        if(client_sockfd == -1){  
            client_sockfd = accept(fds[AVIAT_WEBSOCK_FD].fd,(struct sockaddr*)&client_addr, &client_len);  
        } 

        nread = read(client_sockfd, revStr, 5);

        if(nread == 0){//client disconnected  
            printf("client %d disconnected\n",client_sockfd);  
            client_sockfd = -1;  
        }  
        else{  
            printf("read from client %d: %s\n",client_sockfd,revStr);  
            //ch ++;  
            write(client_sockfd, "vbbn", 5);  
        }  
        usleep(100);//1000 miliseconds = 1 second  
*/
    }

/*
    while (1) {
        int events = poll(fds, 2, 1000);
        if (events > 0) {
            printf("step 1\n");
            handleStatSockets(fds, &numfds, events,&interaceStat);
            printf("step 2\n");
            if(interaceStat == true )
            {
                printf("AIS connected with the client\n");
                //AviatIntStatsPostMan(fds);
                // do the job
            }
        }
    }
    */
}

