#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define PORT 12345

int main(){

	FILE *fp;
   	char buff_out[1024];

	int sockfd, ret,status;
	 struct sockaddr_in serverAddr;

	int newSocket;
	struct sockaddr_in newAddr;

	socklen_t addr_size;

	char buffer[1024];
	pid_t childpid;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if(sockfd < 0){
		printf("[-]Error in connection.\n");
		exit(1);
	}
	printf("[+]Server Socket is created.\n");

	memset(&serverAddr, '\0', sizeof(serverAddr));
	serverAddr.sin_family = AF_INET;
	serverAddr.sin_port = htons(PORT);
	serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");

	ret = bind(sockfd, (struct sockaddr*)&serverAddr, sizeof(serverAddr));
	if(ret < 0){
		printf("[-]Error in binding.\n");
		exit(1);
	}
	printf("[+]Bind to port %d\n", 12345);

	if(listen(sockfd, 10) == 0){
		printf("[+]Listening....\n");
	}else{
		printf("[-]Error in binding.\n");
	}


	while(1){
		newSocket = accept(sockfd, (struct sockaddr*)&newAddr, &addr_size);
		if(newSocket < 0){
			exit(1);
		}
		printf("PID: %d, Connection accepted from %s:%d\n",getpid(), inet_ntoa(newAddr.sin_addr), ntohs(newAddr.sin_port));

		if((childpid = fork()) == 0){
			close(sockfd);

			while(1){
				recv(newSocket, buffer, 1024, 0);

				if(strcmp(buffer, ":exit\n") == 0){
					printf("PID: %d, Disconnected from %s:%d\n",getpid(), inet_ntoa(newAddr.sin_addr), ntohs(newAddr.sin_port));
					break;
				}else{
					int i = 0;
					while(buffer[i]!='\0') i++;
					
					buffer[i-3] = '\0';

					printf("PID: %d, Client: %s\n",getpid(), buffer);
					int c;
					fp = fopen(buffer, "r");
					if(fp){
						  while ((c = getc(fp)) != EOF){
						        //putchar(c);
						        buff_out[0] = c;
						        buff_out[1] = '\0';
						        send(newSocket, buff_out, strlen(buff_out), 0);
								
								bzero(buff_out, sizeof(buff_out));
						  }
						  fclose(fp);
					}
					
					bzero(buffer, sizeof(buffer));
					
				}
			}
		}else{
			
		}

	}
	
	close(newSocket);


	return 0;
}