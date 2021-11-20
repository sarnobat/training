/**************************************************************************/
/* Header files                                                           */
/**************************************************************************/
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

/**************************************************************************/
/* Constants used by this program                                         */
/**************************************************************************/
#define BUFFER_LENGTH  256
#define MAX_PORT_SIZE    6     // take into account the possible Null
#define FALSE            0
#define TRUE             1
#define ERROR           -1
#define RETURN_MSG      "Server got your message\n"

void cleanup_and_close(int clntfd) {
    /***********************************************************************/
    /* Shutdown and close down any open socket descriptors                 */
    /***********************************************************************/
    if (clntfd != -1) {
        shutdown(clntfd, SHUT_RDWR);
        close(clntfd);
    }
}

int main(int argc, char *argv[]) {
    /***********************************************************************/
    /* Variable and structure definitions.                                 */
    /***********************************************************************/
    int    clientfd = -1, bytesRcvd = 0;
    int    portnum = -1;
    int    valid_addr = FALSE;
    int    rtrn_msg_size = sizeof(RETURN_MSG);
    int    rc;
    char   buffer[BUFFER_LENGTH] = "This is a message from the client!\n";
    char   server[NI_MAXHOST];
    char   srvport[MAX_PORT_SIZE];
    struct in6_addr serveraddr;
    struct addrinfo hints, *res = NULL;

    if (argc < 3) {
        fprintf(stderr, "Usage: %s <server_name_or_addr> <portnum> \n", argv[0]);
        return(ERROR);
    }

    memset(srvport, 0x0, sizeof(srvport));
    portnum = atoi(argv[2]);
    if (portnum > 0) {
        if (strlen(argv[2]) <= MAX_PORT_SIZE) {
            strncpy(srvport, argv[2], strlen(argv[2]));
        } else {
            perror("Invalid port number... Exiting\n");
            return (ERROR);
        }
    } else {
        perror("Invalid port number... Exiting\n");
        return (ERROR);
    }

    printf("\nIPv6 TCP Client Started...\n");

    /********************************************************************/
    /* Argument 1 is the hostname/addr                                  */
    /********************************************************************/
    memset(server, 0x0, sizeof(server));
    if (strlen(argv[1]) <= NI_MAXHOST) {
        strncpy(server, argv[1], strlen(argv[1]));
    } else {
        perror("Invalid host name... Exiting\n");
        return (ERROR);
    }

    memset(&hints, 0x0, sizeof(hints));
    hints.ai_flags    = AI_NUMERICSERV;
    hints.ai_family   = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    /********************************************************************/
    /* Use inet_pton to see if we were passed a valid address and       */
    /* convert the text form of the address to binary.  If it's an      */
    /* address, then tell getaddrinfo() call it's numeric               */
    /********************************************************************/
    rc = inet_pton(AF_INET, server, &serveraddr);
    if (rc == 1) {    /* valid IPv4 text address? */
        hints.ai_family = AF_INET;
        hints.ai_flags |= AI_NUMERICHOST;
    } else {
        rc = inet_pton(AF_INET6, server, &serveraddr);
        if (rc == 1) { /* valid IPv6 text address? */
            hints.ai_family = AF_INET6;
            hints.ai_flags |= AI_NUMERICHOST;
        }
    }

    /********************************************************************/
    /* If argv[1] wasn't an address, then we will use getaddrinfo() to  */
    /* resolve the name to and address                                  */
    /********************************************************************/
        rc = getaddrinfo(server, srvport, &hints, &res);
        if (rc != 0) {
            printf("Host not found --> %s\n", gai_strerror(rc));
            if (rc == EAI_SYSTEM) perror("getaddrinfo() failed");
            return(ERROR);
        }

    /********************************************************************/
    /* Create a clientfd socket using the info from the getaddrinfo()   */
    /* an endpoint.  The statement also identifies the address family,  */
    /* socket type, and protocol using the information returned from    */
    /* getaddrinfo().                                                   */
    /********************************************************************/
    clientfd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (clientfd < 0) {
        perror("socket() failed");
        return(ERROR);
    }
    /********************************************************************/
    /* connect() to the server                                          */
    /********************************************************************/
    rc = connect(clientfd, res->ai_addr, res->ai_addrlen);
    if (rc < 0) {
        /*****************************************************************/
        /* Note: the res is a linked list of addresses found for server. */
        /* If the connect() fails to the first one, subsequent addresses */
        /* (if any) in the list can be tried if required.                */
        /*****************************************************************/
        perror("connect() failed");
        /* no connection, so we don't need to close */
        return(ERROR);
    }

    /********************************************************************/
    /* Free any results returned from getaddrinfo                       */
    /********************************************************************/
    if (res != NULL) freeaddrinfo(res);

    /********************************************************************/
    /* Send the client buffer to the server                             */
    /********************************************************************/
    rc = send(clientfd, buffer, sizeof(buffer), 0);
    if (rc < 0) {
        perror("send() failed");
        cleanup_and_close(clientfd);
    }

    /********************************************************************/
    /* zero out the return buffer                                       */
    /********************************************************************/
    memset(buffer, 0, 256);

    /********************************************************************/
    /* In this example we know that the server is going to respond with */
    /* with the message "Server got your message\n".  Since we know how */
    /* much will be sent back, we just read until we get than number of */
    /* bytes.  Otherwise, the student would need to check to make sure  */
    /* the whole message was received.                                  */
    /********************************************************************/
    while (bytesRcvd < rtrn_msg_size) {
        rc = recv(clientfd, &buffer[bytesRcvd],
                  rtrn_msg_size - bytesRcvd, 0);
        if (rc < 0) {
            perror("recv() failed");
            cleanup_and_close(clientfd);
            return(ERROR);
        } else if (rc == 0) {
            printf("The server closed the connection\n");
            cleanup_and_close(clientfd);
            return(ERROR);
        }

        /*****************************************************************/
        /* Increment the number of bytes that have been received so far  */
        /*****************************************************************/
        bytesRcvd += rc;
    }

    printf("Message from server: %s\n", buffer);

    cleanup_and_close(clientfd);
}

