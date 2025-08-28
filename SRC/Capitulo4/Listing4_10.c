#include <malloc.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>

struct job {
 /* Link field for linked list. */
 struct job* next;
 /* Other fields describing work to be done... */
 int job_id;
 char* job_data;
};

/* A linked list of pending jobs. */
struct job* job_queue;

void process_job(struct job* job);

/* Process queued jobs until the queue is empty. */
void* thread_function (void* arg)
{
 while (job_queue != NULL) {
 /* Get the next available job. */
 struct job* next_job = job_queue;
 /* Remove this job from the list. */
 job_queue = job_queue->next;
 /* Carry out the work. */
 process_job (next_job);
 /* Clean up. */
 free (next_job->job_data);
 free (next_job);
 }
 return NULL;
}

void process_job(struct job* job) {
    printf("Procesando trabajo %d: %s\n", job->job_id, job->job_data);
}

void add_job(int id, const char* data) {
    struct job* new_job = (struct job*)malloc(sizeof(struct job));
    new_job->job_id = id;
    new_job->job_data = strdup(data);
    new_job->next = job_queue;
    job_queue = new_job;
}

int main() {
    pthread_t thread;
    
    add_job(1, "Procesar archivo A");
    add_job(2, "Generar reporte B");
    add_job(3, "Enviar email C");
    add_job(4, "Backup de datos");
    
    pthread_create(&thread, NULL, &thread_function, NULL);
    pthread_join(thread, NULL);
    
    printf("Todos los trabajos procesados\n");
    return 0;
}
