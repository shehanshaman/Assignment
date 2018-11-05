

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
int main(int argc, char *argv[])
{
	char str1[20];

    printf("PID of process = %d\n", getpid());

    pid_t p;
    int status;

    p = fork();
    
    if(p==-1)
    {
        printf("There is an error while calling fork()");
    }
    if(p==0)
    {
    	printf("We are in the child process\n");
    	execl("./server3", "", NULL);

    }
    else
    {
    	wait(&status);
        printf("We are in the parent process\n");
		execl("./exc3", str1, NULL);
		puts("Program ls has terminated");

    }
    return 0;
}