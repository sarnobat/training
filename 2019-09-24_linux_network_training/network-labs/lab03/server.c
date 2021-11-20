/**************************************************************************/
/* Header files                                                           */
/**************************************************************************/
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

/**************************************************************************/
/* Constants                                                              */
/**************************************************************************/
#define BUFFER_LENGTH 256
#define ERROR          -1

void cleanup_and_close(int svrfd, int clntfd) {
    /***********************************************************************/
    /* Shutdown and close down any open socket descriptors                 */
    /***********************************************************************/
    if (svrfd != -1) {
        shutdown(svrfd, SHUT_RDWR);
        close(svrfd);
    }
    if (clntfd != -1) {
        shutdown(clntfd, SHUT_RDWR);
        close(clntfd);
    }
}

int main(int argc, char *argv[]) {
    /***********************************************************************/
    /* Variable and structure definitions.                                 */
    /***********************************************************************/
    /* data segment*/
    int server_sockfd = -1, client_sockfd = -1;
    int num_recvd = -1,     num_sent = -1;
    int portnum = 0,        enable = 1;
    int  addrlen = sizeof(struct sockaddr_in6);

    /* BSS segment*/
    struct sockaddr_in6 serveraddr, clientaddr;
    char buffer[BUFFER_LENGTH];
    char str[INET6_ADDRSTRLEN];

    if (argc < 2) {
        fprintf(stderr, "Usage: %s <portnum>\n", argv[0]);
        exit(0);
    }

    printf("\nIPv6 TCP Server Started...\n");

    /********************************************************************/
    /* The socket() function returns a socket descriptor, which represents   */
    /* an endpoint.  Get a socket for address family AF_INET6 to        */
    /* prepare to accept incoming connections on.                       */
    /********************************************************************/

    // ###FIXME - put the appropriate address family for IPv6 and stream socket
    if ((server_sockfd = socket(PF_INET6, SOCK_STREAM, 0)) < 0) {
        perror("socket() failed");
        return(ERROR);
    }

    /********************************************************************/
    /* Allow local address to be reused immediately on server exit      */
    /********************************************************************/

    // ###FIXME - use the socket option for the server to reuse addresses
    if (setsockopt(server_sockfd, SOL_SOCKET, SO_REUSEADDR,
                   (char *)&enable, sizeof(enable)) < 0) {
        perror("setsockopt(SO_REUSEADDR) failed");
        cleanup_and_close(server_sockfd, client_sockfd);
        return(ERROR);
    }

    /********************************************************************/
    /* Bind the address                                                 */
    /********************************************************************/
    memset(&serveraddr, 0, sizeof(serveraddr));

    // ###FIXME - enter in the IPv6 address family
    serveraddr.sin6_family = AF_INET6;
    portnum = atoi(argv[1]);

    // ###FIXME - make sure the port number is in the correct endianness
    serveraddr.sin6_port   = htons(portnum);
    /********************************************************************/
    /* Accept the connection from any interface and bind the address    */
    /********************************************************************/
    serveraddr.sin6_addr   = in6addr_any;
    if (bind(server_sockfd, (struct sockaddr *)&serveraddr,
             sizeof(serveraddr)) < 0) {
        perror("bind() failed");
        cleanup_and_close(server_sockfd, client_sockfd);
        return(ERROR);
    }

    /********************************************************************/
    /* Set the listen backlog to 10                                     */
    /********************************************************************/

    // ###FIXME - set the listen() backlog to 10
    if (listen(server_sockfd, 10) < 0) {
        perror("listen() failed");
        cleanup_and_close(server_sockfd, client_sockfd);
        return(ERROR);
    }
    printf("Ready for client connect().\n");

    /********************************************************************/
    /* accept the connection                                            */
    /********************************************************************/
    if ((client_sockfd = accept(server_sockfd,
                                (struct sockaddr *)&clientaddr,
                                &addrlen)) < 0) {
        perror("accept() failed");
        cleanup_and_close(server_sockfd, client_sockfd);
        return(ERROR);
    } else {
        /*****************************************************************/
        /* Display the client address.  If address is IPv4 show it as an */
        /* IPv4-mapped IPv6 Address                                      */
        /*****************************************************************/
        if (inet_ntop(AF_INET6, &clientaddr.sin6_addr, str, sizeof(str))) {
            printf("Client address is %s\n", str);
            printf("Client port is %d\n", ntohs(clientaddr.sin6_port));
        }
    }

    memset(buffer, 0, 256);

    /*****************************************************************/
    /* recv() for the client                                         */ 
    /*****************************************************************/
    num_recvd = recv(client_sockfd, buffer, 255, 0);
    if (num_recvd < 0) error("ERROR reading from socket");

    printf("Message from client: %s\n", buffer);

    /*****************************************************************/
    /* send() response                                               */
    /*****************************************************************/
    num_sent = send(client_sockfd, "Server got your message\n", 24 + 1, 0);
    if (num_sent < 0) error("ERROR writing to socket");

    cleanup_and_close(server_sockfd, client_sockfd);

}

