/*
  Autores: mbgj, rjvw, tasm2

    A ideia principal para solucionar este problema é ter threads para as filas e
  threas para cada um dos taxis
    Acordando a thread do taxi, que serve so para reiniciar a contagem.
*/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

#define QNT_TAXIS 2
#define QNT_FILAS 3
#define CAPACIDADE_TAXI 4
#define CAPACIDADE_FILA 12

typedef struct {
  int taxi[QNT_TAXIS];
}Estacao;

int filas[QNT_FILAS] = {};

Estacao estacaoPrincipal;

pthread_cond_t cheio[QNT_TAXIS] = PTHREAD_COND_INITIALIZER;
pthread_mutex_t stationMutex[QNT_TAXIS] = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t printEstacao = PTHREAD_MUTEX_INITIALIZER;

// Escopo das funções
int maisVaga();
void print();
void liberaTaxis();

void *fila(void* nFila){
  int *filaID = (int *) nFila;
  while(1){
    filas[*filaID]++;
    usleep(200 * 1000);

    int taxiEscolhido = maisVaga();

    if(taxiEscolhido == -1){
    }else{
      // Ao entrar nesse teste logico, garantimos que existe pelo menos 1 taxi
      // que possa receber mais uma pessoa
      pthread_mutex_lock(&stationMutex[taxiEscolhido]);
      liberaTaxis();
      estacaoPrincipal.taxi[taxiEscolhido]++;
      filas[*filaID]--;
      pthread_mutex_unlock(&stationMutex[taxiEscolhido]);
    }
    print();
  }
}

// Função que acorda a thread do taxi, para que ele saia da estação
// sabendo que esse Taxi já está cheio
void liberaTaxis(){
  int i = 0;
  for(; i < QNT_TAXIS; i++){
    if(estacaoPrincipal.taxi[i] >= 4){
      pthread_cond_broadcast(&cheio[i]);
    }
  }
}

// Thread do taxi, baseada nas instruções da questão
void *taxi(void * nTaxi){

  int *taxiID = (int *) nTaxi;

  while(1){
    pthread_mutex_lock(&stationMutex[*taxiID]);
    // Lembrar que se colocar IF, todos os TAXIS entram juntos
    pthread_cond_wait(&cheio[*taxiID], &stationMutex[*taxiID]);
      estacaoPrincipal.taxi[*taxiID] = -1;
    pthread_mutex_unlock(&stationMutex[*taxiID]);

    usleep(500 * 1000);

    pthread_mutex_lock(&stationMutex[*taxiID]);
      estacaoPrincipal.taxi[*taxiID] = 0;
    pthread_mutex_unlock(&stationMutex[*taxiID]);
  }
}

// Função que retorna se existem taxis a espera e com maiorQntVagas
// Retornar -1 significa que não existe nenhum taxi vazio
// Se não, retorna o taxi com a maior quantidade de vagas
int maisVaga(){
  int i = 0;
  int maiorQntVagas = 0;
  int cheios = 1;
  for(; i < QNT_TAXIS; i++){
    // - 1 significa que não tem taxi no patio no momento
    if(estacaoPrincipal.taxi[i] == -1){
    }else if(estacaoPrincipal.taxi[i] <= estacaoPrincipal.taxi[maiorQntVagas]){
      maiorQntVagas = i;
      cheios = 0;
    }
  }
  if(cheios == 1)
    return -1;
  return maiorQntVagas;
}

void print(int filaID){
    int i = 0;
    pthread_mutex_lock(&printEstacao);
    system("clear");
    for(i = 0 ; i < QNT_FILAS; i++){
        printf("Fila: %d Quantidade: %d\n", i, filas[i]);
    }
    printf("\n");
    for(i = 0 ; i < QNT_TAXIS; i++){
        printf("Taxis: %d Quantidade: %d\n", i, estacaoPrincipal.taxi[i]);
    }
    printf("\n");
    pthread_mutex_unlock(&printEstacao);
}

int main(){

  int i = 0;
  pthread_t thread[QNT_FILAS];
  pthread_t threadTaxi[QNT_TAXIS];

  for(i = 0; i < QNT_TAXIS; i++){
    estacaoPrincipal.taxi[QNT_TAXIS] = 0;
    int *nTaxi = malloc(sizeof(int));
    *nTaxi = i;
    pthread_create(&threadTaxi[i], NULL, taxi, (void *) nTaxi);
  }
  for(i = 0; i < QNT_FILAS; i++){
    int *nFila = malloc(sizeof(int));
    *nFila = i;
    pthread_create(&thread[i], NULL, fila, (void *) nFila);
  }
  while(1){
  };

  return 0;
}
