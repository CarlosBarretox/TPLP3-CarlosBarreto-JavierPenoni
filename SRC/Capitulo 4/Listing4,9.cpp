#include <pthread.h>
#include <iostream>

class ThreadExitException
{
public:
    /* Create an exception-signaling thread exit with RETURN_VALUE. */
    ThreadExitException(void* return_value)
        : thread_return_value_(return_value)
    {
    }
    
    /* Actually exit the thread, using the return value provided in the constructor. */
    void* DoThreadExit()
    {
        pthread_exit(thread_return_value_);
        return NULL; // Nunca se ejecuta, pero evita warning
    }
    
private:
    /* The return value that will be used when exiting the thread. */
    void* thread_return_value_;
};

// Función simulada que determina si debe salir
bool should_exit_thread_immediately()
{
    // Simulación: salir después de un tiempo
    static int count = 0;
    return ++count > 5;
}

void do_some_work()
{
    while (1) {
        /* Do some useful things here... */
        std::cout << "Trabajando..." << std::endl;
        
        if (should_exit_thread_immediately())
            throw ThreadExitException(/* thread's return value = */ NULL);
    }
}

void* thread_function(void*)
{
    try {
        do_some_work();
    }
    catch (ThreadExitException ex) {
        /* Some function indicated that we should exit the thread. */
        ex.DoThreadExit();
    }
    return NULL;
}

/* Programa principal */
int main()
{
    pthread_t thread;
    pthread_create(&thread, NULL, &thread_function, NULL);
    pthread_join(thread, NULL);
    std::cout << "Hilo terminado exitosamente" << std::endl;
    return 0;
}
