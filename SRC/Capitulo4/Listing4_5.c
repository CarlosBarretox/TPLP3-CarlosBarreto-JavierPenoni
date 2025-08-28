#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

void* thread_function (void* thread_arg)
{
    printf("Hilo detached ejecutándose\n");
    sleep(2);  // Simular trabajo
    printf("Hilo detached terminado\n");
    return NULL;
}

int main ()
{
    pthread_attr_t attr;
    pthread_t thread;
    
    pthread_attr_init (&attr);
    pthread_attr_setdetachstate (&attr, PTHREAD_CREATE_DETACHED);
    pthread_create (&thread, &attr, &thread_function, NULL);
    pthread_attr_destroy (&attr);
    
    printf("Hilo principal trabajando...\n");
    sleep(3);  // Dar tiempo al hilo detached de terminar
    
    printf("Programa terminado\n");
    return 0;
}
