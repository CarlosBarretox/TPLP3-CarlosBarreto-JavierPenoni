#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
int main ()
{
 pid_t child_pid;
 /* Create a child process. */
 child_pid = fork ();
 if (child_pid > 0) {
     printf("Padre: he creado un hijo con PID = %d\n", child_pid);
 /* This is the parent process. Sleep for a minute. */
     printf("Padre: me voy a dormir 60 segundos...\n");
     sleep (60);
     printf("Padre: terminé mi ejecución.\n");
 }
 else {
     printf("Hijo: soy el hijo con PID = %d y mi padre es PID = %d\n", getpid(), getppid());
 /* This is the child process. Exit immediately. */
     printf("Hijo: voy a terminar inmediatamente.\n");
     exit (0);
 }
 return 0;
}
