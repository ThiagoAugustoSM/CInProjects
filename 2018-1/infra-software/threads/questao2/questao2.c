/*
    Projeto Threads - questao 2
    Disciplina: Infraestrutura de Software - IF677
    Professor: Eduardo Tavares
    Atividade realizada por Michael Barney, Ramon Wanderley e Thiago Augusto.
*/
#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#define TAM_X 3
/* CASO 1 - Lembrar de modificar o TAM_X para 3
double A[TAM_X][TAM_X] = { 
            { 3, 2, 4},
            { 0, 0.333, 0.666},
            { 0, 0.333, -7.333}
            };
            
double b[TAM_X] = { 1, 1.666, 1.666};
double x[TAM_X] = { 1, 1, 1};
*/

// CASO 2 - Lembrar de modificar o TAM_X para 3
double A[TAM_X][TAM_X] = { 
            { 8, 1, -1},
            { 1, -7, 2},
            { 2, 1, 9}
            };
            
double b[TAM_X] = { 8, -4, 12};
double x[TAM_X] = { 1, 1, 1};

/*CASO 3 - Lembrar de modificar o TAM_X para 2
double A[TAM_X][TAM_X] = { 
            { 2, 1},
            { 1, 7}
            };
            
double b[TAM_X] = { 11, 13};
double x[TAM_X] = { 1, 1};
*/
double next_x[TAM_X]; //guarda o valor de x nas threads

int N = 2; //número de threads
int P = 20; //número de repeticoes
int impar = 0; //flag utilizada quando TAM_X/N != 0
pthread_barrier_t barrier; //barramento

typedef struct { //estrutura utilizada para armazenar o valor de qual linha a thread vai começar e quantas linhas
    int quantX;
    int inicio;
}parametroThreads;


void *exec(void *threadid);

int main(){
    int i, j, k;
    pthread_t thread[N];
    parametroThreads * parametro[N];
    i = 0;
    j = (int)TAM_X/N;
    k = 0;
    for(i = 0; i < TAM_X; i++){
         next_x[i] = 1;
    }
    i = 0;
    if(TAM_X % N != 0){//verifica se as threads vao pegar a mesma quantidade de linhas
          while(i < TAM_X-1){
          parametro[k] = malloc(sizeof(parametroThreads));
          parametro[k]->inicio = i;
          parametro[k]->quantX = j;
          i = i + j;
          k++;
        }
        impar = 1;
        parametro[k-1]->quantX = j + 1;
        printf("%d e k = %d\n", parametro[k-1]->quantX, k);
    }
    else{
        while(i < TAM_X){
          parametro[k] = malloc(sizeof(parametroThreads));
          parametro[k]->inicio = i;
          parametro[k]->quantX = j ;
          i = i + j ;
          k++;
        }
    }
   
    pthread_barrier_init(&barrier, NULL, N);
    
    for(i = 0; i < N; i++){
        pthread_create(&thread[i], NULL, exec,(void *) parametro[i]);
    }
    for(i = 0; i < N; i++){
        pthread_join(thread[i], NULL);
    }
    for(i = 0; i < TAM_X; i++){
      printf("x%d = %.4lf\n", i, x[i]);
    }
    
    pthread_barrier_destroy(&barrier);
    pthread_exit(NULL);
    return 0;
};

void *exec(void *threadid) {
    int i, j, k;
    k = 0;
    parametroThreads * parametro = (parametroThreads *) threadid;
    i = parametro->inicio;
    printf("Eu %d comecei! devo fazer %d linhas\n", parametro->inicio, parametro->quantX);
    double somatorio = 0;
    while(i < parametro-> inicio + parametro->quantX ){
        while(k < P){
            for(j = 0; j < TAM_X; j++){
                if(i != j) somatorio  = somatorio + A[i][j]*x[j];
            }
            next_x[i] = (b[i] - somatorio)/A[i][i] ;
            if(impar == 1 && i + parametro->quantX != TAM_X ) pthread_barrier_wait(&barrier);
            else if(impar == 0 )pthread_barrier_wait(&barrier);
            /*
            como deixa a ultima thread criada com mais uma linha quando impar = 1
            entao nao usa barramento quando a ultima linha estiver sendo executada!
            */
            for(j = 0; j < TAM_X; j++){
			    x[j] = next_x[j];
	        }
	         if(impar == 1 && i + parametro->quantX != TAM_X ) pthread_barrier_wait(&barrier);
            else if(impar == 0 )pthread_barrier_wait(&barrier);
	        k++;
	        somatorio = 0;
        }
        k = 0;
        i++;
    }
   printf("Eu %d terminei!\n", parametro->inicio);
};

