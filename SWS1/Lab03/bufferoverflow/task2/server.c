//-----------------------------------------------------------------------------
// Author:       M. Rennhard
// Date:         06.01.2011
// Description:  Server code for Task 2 of Security Lab Buffer-Overflow Attacks
//-----------------------------------------------------------------------------

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <netinet/in.h>
#include <unistd.h>
#include <arpa/inet.h>

#include "task2.h"

// Function prototypes
static void waitForConnection(int sfd, struct sockaddr_in *addr);
static int createSocket(struct sockaddr_in *addr);
static void handleClientRequest(int cfd, struct sockaddr_in *addr);
static char fpub[] = "/tmp/public.txt";
static char fsec[] = "/tmp/secret.txt";

//-----------------------------------------------------
// Main function of server. 
// Creates a socket and waits for incoming connections.
//-----------------------------------------------------
int main(void) {
  int sfd = -1;
  struct sockaddr_in addr = {AF_INET, htons(PORT), INADDR_ANY};
  
  printf(HEAD);

  printf("%s%s", INFO, "Starting task2-server...\n");
  printf("%s%s%d%s", INFO, "Communication up. Listen on port ", PORT, "...\n");
  sfd = createSocket(&addr);
  printf("%s%s", INFO, "Wait for clients...\n");
  waitForConnection(sfd, &addr);
  
  return 0;
}

//-----------------------------------------------------------------------------
// This function waits for a connection. If the DEBUG flag is set, a single
// process is used and the next connection can only be accepted after the
// first one has been handled.
//
// If the DEBUG flag is not set and when a client establishes a connection,
// a "fork" is done. The child process handles the request of the client and
// the parent process is ready for further connection attempts. In addition, 
// this makes the server robust against buffer overflow attacks as clients can 
// only crash the child process. The child process does another fork and the 
// new child process handles the actual request and the first child teminates
// immediately. This prevents that zombies are created where the parent process
// has to wait unnecessarily long for the child process to be terminated and 
// removed from the process table.
//-----------------------------------------------------------------------------
void waitForConnection(int sfd, struct sockaddr_in *addr) {
  int debug = DEBUG;
  pid_t pid;
  int cfd, addrlen = sizeof(*addr);

  while((cfd = accept(sfd, (struct sockaddr*)addr, (unsigned*)&addrlen)) > 0) {
    if(!debug) {
      pid = fork();
      switch(pid) {
        case -1:
          printf("%s%s", ERROR, "Could not fork\n");
        break;
        case 0:          // Child process and parent process of the next fork
          pid = fork();
          switch(pid) {
            case -1:
              printf("%s%s", ERROR, "Could not fork\n");
            break;
            case 0:      // Child process, handle requesa and exit
              handleClientRequest(cfd, addr);
              exit(0);
            break;
            default:     // Parent process, exit right away
              exit(0);
          }
        break;
        default:         // Parent process, handle next request 
          wait(NULL);
      }
    } else {
      handleClientRequest(cfd, addr);
    }
  }
}

//--------------------------------------------------------------------------------
// This function handles a request by a client. First, the message from the client
// is read. Then, a response is sent back to the client. A part of the response
// is read from a file (fpub). Finally, the connection is closed.
//--------------------------------------------------------------------------------
void handleClientRequest(int cfd, struct sockaddr_in *addr) {
  char *host = (char*)inet_ntoa(addr->sin_addr); // Gets IP address of client
  char *file = fpub;
  char message[MSG_SIZE];

  // Print that a connection was established
  printf("%s%s%s%s", INFO, "Client ", host, " connected...\n");

  // Read message from client
  char buf[BUF_SIZE];
  int pos = 0, count = recv(cfd, buf, BUF_SIZE, 0);
  while(count > 0) {
    if(memccpy(message+pos, buf, '\0', count) == NULL) {
      pos += count;
      count = recv(cfd, buf, BUF_SIZE, 0);
    } else {
      count = 0;
    }
  }
  printf("%s%s%s%s", INFO, "Message received from client ", host,"...\n");

  // Send response to client (content of file + message)
  FILE *pubfd = fopen(file, "r");
  if(pubfd != NULL) {
    while((count = fread(buf, 1, BUF_SIZE, pubfd)) > 0 ) {
      send(cfd, buf, count, 0);
    }
    fclose(pubfd);
  } else {
    printf("%s%s", ERROR, "Error opening file...\n");
  }
  send(cfd, message, strlen(message)+1, 0);
  printf("%s%s%s%s", INFO, "Response sent to client ", host, "...\n");

  // Close connection 
  close(cfd);
  printf("%s%s%s%s", INFO, "Client ", host, " disconnected...\n");
}

//-------------------------------------------------------------
// Creates a blocking socket and returns the socket descriptor.
//-------------------------------------------------------------
int createSocket(struct sockaddr_in *addr) {
  int sfd=-1, z=1;
  if((sfd = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
    printf("%s%s",ERROR, "Cannot setup socket.\n");
    exit(-1);
  }

  setsockopt(sfd, SOL_SOCKET, SO_REUSEADDR, NULL, 0);
  if(bind(sfd, (struct sockaddr*)addr, sizeof(*addr)) < 0) {
    printf("%s%s", ERROR, "Bind failed.\n");
    close(sfd);
    exit(-1);
  }

  if(listen(sfd, 20) < 0) {
    printf("%s%s", ERROR, "Listen failed.\n");
    close(sfd);
    exit(-1);
  }
  return sfd;
}
