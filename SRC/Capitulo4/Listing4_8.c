#include <stdlib.h>
#include <pthread.h>
#include <stdio.h>

/* Allocate a temporary buffer. */
void* allocate_buffer (size_t size)
{
    printf("Asignando buffer de %zu bytes\n", size);
    return malloc (size);
}

/* Deallocate a temporary buffer. */
void deallocate_buffer (void* buffer)
{
    printf("Liberando buffer\n");
    free (buffer);
}

void do_some_work ()
{
    /* Allocate a temporary buffer. */
    void* temp_buffer = allocate_buffer (1024);
    
    /* Register a cleanup handler for this buffer, to deallocate it in
    case the thread exits or is cancelled. */
    pthread_cleanup_push (deallocate_buffer, temp_buffer);
    
    /* Do some work here that might call pthread_exit or might be
    cancelled... */
    printf("Trabajando con el buffer...\n");
    
    /* Unregister the cleanup handler. Because we pass a nonzero value,
    this actually performs the cleanup by calling
    deallocate_buffer. */
    pthread_cleanup_pop (1);
}

/* Programa principal de prueba */
int main()
{
    printf("Iniciando trabajo...\n");
    do_some_work();
    printf("Trabajo completado\n");
    return 0;
}
