#include <signal.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>

sig_atomic_t child_exit_status;

void clean_up_child_process (int signal_number)
{
    int status;
    wait (&status);
    child_exit_status = status;
    printf("Padre: el hijo terminó con status = %d\n", child_exit_status);
}

int main ()
{
    struct sigaction sigchld_action;
    memset (&sigchld_action, 0, sizeof (sigchld_action));
    sigchld_action.sa_handler = &clean_up_child_process;
    sigaction (SIGCHLD, &sigchld_action, NULL);

    if (fork() == 0) {
        /* Proceso hijo */
        printf("Hijo: voy a terminar con exit(42)\n");
        _exit(42);
    } else {
        /* Proceso padre */
        printf("Padre: esperando que mi hijo termine...\n");
        sleep(2);
    }
    return 0;
} 
