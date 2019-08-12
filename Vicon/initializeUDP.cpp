
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <iostream>

int initializeUDP(int *handle) {


    *handle = socket( AF_INET, SOCK_DGRAM, 0 );
    if(*handle < 0){
       perror("socket");
       return(-1);
    } else {
      //printf("test\n");
    }

    struct sockaddr_in servaddr;
    servaddr.sin_family = AF_INET;
    servaddr.sin_port=htons(51001);
    servaddr.sin_addr.s_addr=htonl(INADDR_ANY);

    if ( bind( *handle, (struct sockaddr*)&servaddr, sizeof(servaddr) ) < 0 ){
	perror("bind");
	return(-1);
    }

    return 0;
}

