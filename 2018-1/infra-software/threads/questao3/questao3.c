/*
    Projeto Threads - questao 3
    Disciplina: Infraestrutura de Software - IF677
    Professor: Eduardo Tavares
    Atividade realizada por Michael Barney, Ramon Wanderley e Thiago Augusto.
*/

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <time.h>
/*
pedra = 0;
papel = 1;
tesoura = 2;
*/
int T = 0;
int N = 0;
int *jogadas;
int *listaPontuacao;
pthread_barrier_t fimJogadas;
pthread_barrier_t fimPontuacao;

void *jogador();
int pontuar(int a , int b);

int main(){
    
    srand(time(NULL));
    printf("Digite a quantidade de jogadores:\n");
    scanf("%d", &T);
    printf("Digite a quantidade de rodadas:\n");
    scanf("%d", &N);
    pthread_t jogadores[T];
    int *ids[T];
    int i;
    jogadas = (int *) malloc(sizeof(int)*T);
    listaPontuacao = (int *) malloc(sizeof(int)*T);
    
    pthread_barrier_init(&fimJogadas, NULL, T);
    pthread_barrier_init(&fimPontuacao, NULL, T);
    for(i = 0; i < T; i++){
        jogadas = (int *) malloc(sizeof(int)*T);
        ids[i] = (int *) malloc(sizeof(int));
        *ids[i] = i;
        pthread_create(&jogadores[i], NULL, jogador, (void *) ids[i]);
        
    }
    
    for(i = 0; i < T; i++){
        pthread_join(jogadores[i], NULL);
    }
    for(i = 0; i < T; i++){
       printf("Jogador %d fez %d pontos\n", i ,listaPontuacao[i]);
    }
    pthread_barrier_destroy(&fimJogadas);
    pthread_barrier_destroy(&fimPontuacao);
    pthread_exit(NULL);
     
    return 0;    
    
}

void *jogador(void *threadid) {
    int i,j, jogada;
    int pontuacao = 0;
    for(i = 0; i < N; i++){
        jogada = rand() % 3;
        jogadas[*((int*) threadid)] = jogada;
        pthread_barrier_wait(&fimJogadas); //Barreira de espera do fim da rodada
        for(j = 0; j < T; j++){
            pontuacao = pontuacao + pontuar(jogada, jogadas[j]);
        }
        printf("Rodada %d - Pontuação Jogador %d = %d\n", i, *((int*) threadid), pontuacao);
        listaPontuacao[*((int*) threadid)] = pontuacao;
        pontuacao = 0;
        pthread_barrier_wait(&fimPontuacao); //Barreira de espera do fim do calculo da pontuacao
    }
    
    pthread_exit(NULL);
    
}

int pontuar(int a , int b){//Função responsável por computar as pontuações
    int ponto;
    if(a == (b+1)%3){ 
        ponto = -1; //a perdeu
    }
    else if(a == (b-1)%3){
        ponto = 1; // a ganhou
    }
    else{
        ponto = 0; // a e b empataram
    }
    return ponto;
}