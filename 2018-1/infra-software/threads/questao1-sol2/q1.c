#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>
#include <unistd.h>

// Valores para mudar o background e cor dos textos no printf
#define ANSI_COLOR_RED     "\x1b[41m"
#define ANSI_COLOR_YELLOW  "\x1b[43m"
#define ANSI_COLOR_BLUE    "\x1b[44m"
#define ANSI_COLOR_MAGENTA "\x1b[45m"
#define ANSI_COLOR_GREEN   "\x1b[42m"
#define ANSI_COLOR_BLACK   "\x1b[40m"
#define ANSI_COLOR_CYAN    "\x1b[46m"
#define ANSI_COLOR_RESET   "\x1b[0m"
#define ANSI_COLOR_LETTER_WHITE   "\x1b[37m"
#define ANSI_COLOR_LETTER_BLACK   "\x1b[30m"

#define TAMANHO_STRING 40
#define TAMANHO_LINHAS 7

// Estrutura Para Entrada
typedef struct Modelo_Viagem{
    int linha;
    char codigoViagem[7];
    char cidade[50];
    char cidadeEHora[100];
    char horario[6]; 
    char entrada[100];
}Modelo_Viagem;

// Estrutura para Imprimir valores da linha
typedef struct Modelo_Linha{
    char codigoViagem[7];
    char cidade[50];
    char horario[6];
    char enderecoArquivo[50]; 
    char espacos[50]; // Quantidade de Espaços para serem impressos entre a cidade e o horário
    char entrada[100];
}Modelo_Linha;

Modelo_Linha tabelaViagens[TAMANHO_LINHAS];

// Mutex para controle de impressão das linhas
pthread_mutex_t mymutex[TAMANHO_LINHAS] = PTHREAD_MUTEX_INITIALIZER;
// Mutex para controle de impressão na tela
pthread_mutex_t mutexClear = PTHREAD_MUTEX_INITIALIZER;

void imprimiMatriz(){
    // int espacos, i = 0;
    // for(; i < TAMANHO_LINHAS; i++){
    //     espacos = 40 - (int)strlen(tabelaViagens[i].cidade);
    //     memset(tabelaViagens[i].espacos, 40, espacos);
    // }
    printf(ANSI_COLOR_RED ANSI_COLOR_LETTER_BLACK "%s %s %s%s" ANSI_COLOR_RESET " \t%s\n", tabelaViagens[0].codigoViagem, tabelaViagens[0].cidade, tabelaViagens[0].espacos, tabelaViagens[0].horario, tabelaViagens[0].enderecoArquivo);
    printf(ANSI_COLOR_YELLOW ANSI_COLOR_LETTER_BLACK "%s %s %s%s" ANSI_COLOR_RESET " \t%s\n", tabelaViagens[1].codigoViagem, tabelaViagens[1].cidade, tabelaViagens[1].espacos, tabelaViagens[1].horario, tabelaViagens[1].enderecoArquivo);
    printf(ANSI_COLOR_BLUE ANSI_COLOR_LETTER_BLACK "%s %s %s%s" ANSI_COLOR_RESET " \t%s\n", tabelaViagens[2].codigoViagem, tabelaViagens[2].cidade, tabelaViagens[2].espacos, tabelaViagens[2].horario, tabelaViagens[2].enderecoArquivo);
    printf(ANSI_COLOR_MAGENTA ANSI_COLOR_LETTER_BLACK "%s %s %s%s" ANSI_COLOR_RESET " \t%s\n", tabelaViagens[3].codigoViagem, tabelaViagens[3].cidade, tabelaViagens[3].espacos, tabelaViagens[3].horario, tabelaViagens[3].enderecoArquivo);
    printf(ANSI_COLOR_GREEN ANSI_COLOR_LETTER_BLACK "%s %s %s%s" ANSI_COLOR_RESET " \t%s\n", tabelaViagens[4].codigoViagem, tabelaViagens[4].cidade, tabelaViagens[4].espacos, tabelaViagens[4].horario, tabelaViagens[4].enderecoArquivo);
    printf(ANSI_COLOR_BLACK ANSI_COLOR_LETTER_WHITE "%s %s %s%s" ANSI_COLOR_RESET " \t%s\n", tabelaViagens[5].codigoViagem, tabelaViagens[5].cidade, tabelaViagens[5].espacos, tabelaViagens[5].horario, tabelaViagens[5].enderecoArquivo);
    printf(ANSI_COLOR_CYAN ANSI_COLOR_LETTER_BLACK "%s %s %s%s" ANSI_COLOR_RESET " \t%s\n", tabelaViagens[6].codigoViagem, tabelaViagens[6].cidade, tabelaViagens[6].espacos, tabelaViagens[6].horario, tabelaViagens[6].enderecoArquivo);    
}

void *readFile(void *enderecoArquivo){

    FILE *arquivo;
    arquivo = fopen(enderecoArquivo, "rt+");
    Modelo_Viagem entrada;
    // char entrada[100];
    // Ajustar Entrada de Cidades que podem ter como entrada espaços
    while(fscanf(arquivo, "%d %s %s %s", &entrada.linha, entrada.codigoViagem, entrada.cidade, entrada.horario) != EOF){
        
        // Bloco para exclusão mutua e atualização do valor de somente uma única linha
        pthread_mutex_lock(&mymutex[entrada.linha - 1]);
        
        strcpy(tabelaViagens[entrada.linha - 1].codigoViagem, entrada.codigoViagem);
        strcpy(tabelaViagens[entrada.linha - 1].cidade, entrada.cidade);
        strcpy(tabelaViagens[entrada.linha - 1].horario, entrada.horario);
        strcpy(tabelaViagens[entrada.linha - 1].enderecoArquivo, enderecoArquivo);
        
        pthread_mutex_unlock(&mymutex[entrada.linha - 1]);

        sleep(2);

        pthread_mutex_lock(&mutexClear);

        // Limpa os dados anteriores e imprimi os novos valores na tela
        system("clear");
        imprimiMatriz(enderecoArquivo);
        
        pthread_mutex_unlock(&mutexClear);

    }
    pthread_exit(NULL);
}

int main(){

    char enderecos[7][50] = {"./dados/case0", 
                            "./dados/case1",
                            "./dados/case2",
                            "./dados/case3",
                            "./dados/case4",
                            "./dados/case5",
                            "./dados/case6"};

    // Limpando os dados do vetor global criado                            
    int i = 0;
    for(; i < TAMANHO_LINHAS; i++){
        strcpy(tabelaViagens[i].codigoViagem, "");
        strcpy(tabelaViagens[i].cidade, "");
        strcpy(tabelaViagens[i].horario, "");
        strcpy(tabelaViagens[i].enderecoArquivo, "");
    }

    // Pode-se criar quantas threads quiser, de acordo com a quantidade de arquivos a serem lidos
    pthread_t thread[TAMANHO_LINHAS];
    int rc = pthread_create(&thread[0], NULL, readFile, enderecos[0]);
    int rc2 = pthread_create(&thread[1], NULL, readFile, enderecos[1]);
    pthread_join(thread[0], NULL);
    pthread_join(thread[1], NULL);
    pthread_exit(NULL);
    return 0;
}