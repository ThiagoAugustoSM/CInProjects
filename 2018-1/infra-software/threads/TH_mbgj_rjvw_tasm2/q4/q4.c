/*
    Autores: mbgj, rjvw, tasm2

    A lógica para a implementação desta questão é utilizar de signal e pthread_cond_broadcast
    Enquanto estiver cheio uma estação, que é uma região crítica, todos os outros taxis
  ficam dormindo
    Até que uma vaga é aberta e o sinal é enviado para eles.
    O primeiro que conseguir entrar pega a vaga, que é avisada pelo broadcast e os que não
  conseguiram voltam a dormir.

    Depois de um tempo fica imperceptivel ver as mudanças, pq eles ficam trocando de estações entre si


    O print é colocado dentro da Thread, e não na main, pq pode existir a possibilidade de imprimir
  enquanto está existindo a troca de estações e não realmente avaliar o que está acontecendo.
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

#define QNT_ESTACOES 5
#define QNT_TAXIS 10

int contador_estacao[QNT_ESTACOES] = {0, 0, 0, 0, 0};

pthread_cond_t filled[QNT_ESTACOES] = PTHREAD_COND_INITIALIZER;
pthread_mutex_t stationMutex[QNT_ESTACOES] = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t printEstacao = PTHREAD_MUTEX_INITIALIZER;

void print();

void *estacionar(void *nThread){
    int *threadID = (int *) nThread;
    int estacaoAtual = 0;
    while(1){
        pthread_mutex_lock(&stationMutex[estacaoAtual]);
        // Lembrar que se colocar IF, todos os TAXIS entram juntos
        while(contador_estacao[estacaoAtual] == 2){
            pthread_cond_wait(&filled[estacaoAtual], &stationMutex[estacaoAtual]);
        }
        contador_estacao[estacaoAtual]++;
        pthread_mutex_unlock(&stationMutex[estacaoAtual]);

        print(*threadID);
        sleep(1);

        pthread_mutex_lock(&stationMutex[estacaoAtual]);
            contador_estacao[estacaoAtual]--;
        pthread_mutex_unlock(&stationMutex[estacaoAtual]);

        pthread_cond_broadcast(&filled[estacaoAtual]);

        estacaoAtual = (estacaoAtual + 1) % QNT_ESTACOES;
    }
}

void print(int threadID){
    int i = 0;
    pthread_mutex_lock(&printEstacao);
    system("clear");
    for(i = 0 ; i < QNT_ESTACOES; i++){
        printf("Estacao: %d Quantidade: %d\n", i, contador_estacao[i]);
    }
    printf("Recebido pela Thread: %d\n\n", threadID);
    pthread_mutex_unlock(&printEstacao);
}

int main(){

    int i = 0;
    pthread_t thread[QNT_TAXIS];

    for(i = 0; i < QNT_ESTACOES; i++)
        pthread_cond_init(&filled[i], NULL);
    for(i = 0; i < QNT_TAXIS; i++){
        // Identificador da Thread
        int *nThread = malloc(sizeof(int));
        *nThread = i;
        pthread_create(&thread[i], NULL, estacionar, (void *) nThread);
    }
    while(1){
    }
    return 0;
}
