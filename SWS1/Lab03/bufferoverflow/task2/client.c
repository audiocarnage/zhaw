//-----------------------------------------------------------------------------
// Author:       M. Rennhard
// Date:         06.01.2011
// Description:  Client code for Task 2 of Security Lab Buffer-Overflow Attacks
//-----------------------------------------------------------------------------

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <netdb.h>
#include <arpa/inet.h>

#include "task2.h"

//------------------------------------------------------------------------
// Creates a connection to the server specifed in a command line argument.
// Sends the server a message, which wa salso received as an argument.
//------------------------------------------------------------------------
int main(int argc, char *argv[]) {

  // Check if all arguments are present
  printf("%s%s",INFO, "Starting task2-client...\n");
  if(argc < 3) {
    printf("%s%s", ERROR, "Need hostname/ip and message to send...\n");
    exit(-1);
  } else {
    printf("%s%s%s%s%s%s", INFO, "Client will connect to server '", argv[1], "' and send message '", argv[2],"' to it...\n");
  }

  // Create IP address of server from argument
  struct in_addr iaddr;
  struct hostent *server;
  if(inet_aton(argv[1], &iaddr) > 0) {
    server = gethostbyaddr((char*)&iaddr, sizeof(iaddr), AF_INET);
  } else {
    server = gethostbyname(argv[1]);
  }
  if(server == NULL) {
    printf("%s%s", ERROR, "Host not found...\n");
    exit(-1);
  } 

  // Create socket to connect to server
  struct sockaddr_in addr;
  int sfd = socket(PF_INET, SOCK_STREAM, 0);
  if(sfd < 0) {
    printf("%s%s", ERROR, "Cannot setup socket...\n");
    exit(-1);
  }
  addr.sin_family = AF_INET;
  addr.sin_port = htons(PORT);
  memcpy(&addr.sin_addr, server->h_addr_list[0], sizeof(addr.sin_addr));

  // Create connection to server 
  printf("%s%s", INFO, "Connecting to server...\n"); 
  while(connect(sfd, (struct sockaddr*)&addr, sizeof(addr)) < 0);
  printf("%s%s", INFO, "Connection established...\n");

  // Send message to server
  send(sfd, argv[2], strlen(argv[2])+1, 0);
  printf("%s%s", INFO, "Send message to server...\n");  

  // Receive response from server and print it
  printf("%s%s", INFO, "Wait for response from server...\n\n");  
  char buf[BUF_SIZE];
  int count = recv(sfd, buf, BUF_SIZE, 0);
  while(count > 0) {
    if(buf[count-1] == '\0') {
      fwrite(buf, 1, count-1, stdout);
      count = 0;
    } else {
      fwrite(buf, 1, count, stdout);
      count = recv(sfd, buf, BUF_SIZE, 0);
    }
  }
  printf("\n\n");

  // Close connection
  close(sfd);	
  printf("%s%s", INFO, "Connection closed...\n");  
  return 0;
}
