#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <pthread.h>


#define ANSI_COLOR_GREY    "\x1b[40m"
#define ANSI_COLOR_RED     "\x1b[41m"
#define ANSI_COLOR_GREEN   "\x1b[42m"
#define ANSI_COLOR_YELLOW  "\x1b[43m"
#define ANSI_COLOR_BLUE    "\x1b[44m"
#define ANSI_COLOR_MAGENTA "\x1b[45m"
#define ANSI_COLOR_CYAN    "\x1b[46m"
#define ANSI_COLOR_LGREY   "\x1b[47m"

//só pode no máximo 8 linhas, por causa das cores
#define N 3 //nũmero de arquivos
#define L 8 //nũmero de linhas

#define ANSI_COLOR_RESET   "\x1b[0m"


pthread_mutex_t linemutex[L];  //mutexes para cada linha
pthread_mutex_t printLock = PTHREAD_MUTEX_INITIALIZER;

char lines[L][200];


//the threading function
void *arquiveThread(void *threadid){
    int arquive = *((int *)threadid); //a linha a ser alterada
    char str[200];
    int num = arquive;
    char snum[5];
    sprintf(snum, "%d", num);
    char fileName[20] = "";
    strcat(fileName,"cases/case");
    strcat(fileName, snum);
    printf("%s\n", fileName);
    
    FILE * file = fopen(fileName, "r"); //init the new file
        
    if (file) {
        int isLineNum = 1;
        int lineNum = 0;
        while( fgets (str, 60, file)!=NULL ) {
            strtok(str, "\n");
            //printf("%s\n",str);
            
            if (isLineNum == 1){
                lineNum = atoi(str);
                //printf("lineNum: %d\n", lineNum);
            }
            
            else{
                //hora de atualizar uma linha
                pthread_mutex_lock(&linemutex[lineNum]);
                
                strcpy(lines[lineNum], str);

                pthread_mutex_lock(&printLock);
                //printf("Arquive %d: Add to line %d\n", arquive, lineNum);
                int line = 0;
                printf("\n\n\n\n\n");
                for (line = 0; line < L; line++){
                    printf("\x1b[%dm%s\n", 40 + line, lines[line]);
                }
                pthread_mutex_unlock(&printLock);
                
                //delay
                int delay = 0;
                //for (delay = 0; delay < 500000000; delay++){}
                sleep(2);
                
                
                pthread_mutex_unlock(&linemutex[lineNum]); 
            }
            isLineNum =  1 - isLineNum;
        }
        fclose(file);
    }
    else{
        printf("error reading file: %d\n", arquive);
    }
        
    pthread_exit(NULL);
}



int main (int argc, char const *argv[]) {
    printf("start main\n");
    //inicializar mutexes
    int i;
    

    for (i = 0; i < L; i++){
        linemutex[i] = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
    }
    
          //THREAD TEST
          pthread_t threads[N];
          long *taskids[N];
          
          int rc; 
          int t;
          for (t = 0; t < N; t++){
            taskids[t] = (long *) malloc(sizeof(long));
            *taskids[t] = t;
            
            rc = pthread_create(&threads[t], NULL, arquiveThread , (void *) taskids[t]);
            if (rc){
                printf("ERRO; código de retorno é %d\n", rc); 
                exit(-1);
            }
          }
          printf("Fim do Main\n");
          pthread_exit(NULL); //Espera acabar todos os threads
    
  //ANSI TEST
  
  /*
  printf(ANSI_COLOR_RED     "This text is RED!"     ANSI_COLOR_RESET "\n");
  printf(ANSI_COLOR_GREEN   "This text is GREEN!"   ANSI_COLOR_RESET "\n");
  printf(ANSI_COLOR_YELLOW  "This text is YELLOW!"  ANSI_COLOR_RESET "\n");
  printf(ANSI_COLOR_BLUE    "This text is BLUE!"    ANSI_COLOR_RESET "\n");
  printf(ANSI_COLOR_MAGENTA "This text is MAGENTA!" ANSI_COLOR_RESET "\n");
  printf(ANSI_COLOR_CYAN    "This text is CYAN!"    ANSI_COLOR_RESET "\n");
  int i;
  for (i = 0; i < 100; i++){
      printf("\x1b[%dm   %d\n", i, i);
  }
  */
}