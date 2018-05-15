#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <pthread.h>

#define CLIENTS   5
#define SERVERS   10
#define PPP 5 //Packets Per Client


//**********The Data Packet Structure********
struct Packet {
    int clientId;
    int serverId;
};

//***********SERVER*************
struct Server {
    struct Packet serverPackets[10];
    pthread_mutex_t serverMutex; 
    
    int serverRunning;
    int packets;
};
struct Server servers[SERVERS];
void *runServer(void * threadid){
    int i;
    int serverId = *((int *)threadid); //our ID
    while (servers[serverId].serverRunning == 1){
         //iterate between all 10 channels of the buffer
        if (servers[serverId].packets > 0){
            struct Packet selectedPacket = servers[serverId].serverPackets[servers[serverId].packets];
            printf("Server %d received message from %d.\n", selectedPacket.serverId, selectedPacket.clientId);
            servers[serverId].packets--;
        }
    }
    pthread_exit(NULL);
}

//**************ROUTER*************
struct Packet routerPackets[5];
pthread_mutex_t routerMutex; 
int routerRunning = 1;
int numRouterPackets = 0;

void *runRouter(void * threadid){
    int i;
    for (i = 0; i < 5; i++){
        servers[i].serverRunning = 1;
        servers[i].packets= 0;
    } 
    
    while (routerRunning == 1){
        //iterate between all 5 channels of the buffer
        if(numRouterPackets > 0){
            struct Packet selectedPacket = routerPackets[numRouterPackets]; //the selected packet
            while (servers[selectedPacket.serverId].packets > 10){}
            //LOCK
            pthread_mutex_lock(&servers[selectedPacket.serverId].serverMutex);
            servers[selectedPacket.serverId].serverPackets[servers[selectedPacket.serverId].packets] = selectedPacket;
            servers[selectedPacket.serverId].packets++;
            printf("Updated server %d with the packet of client %d\n", selectedPacket.serverId, selectedPacket.clientId);
            //UNLOCK
            pthread_mutex_unlock(&servers[selectedPacket.serverId].serverMutex);
            
            numRouterPackets--;
        }
    }
    printf("router ended\n");
    for (i = 0; i < 5; i++){
        servers[i].serverRunning = 0;
        printf("Server %d ended\n", i);
    } 
    pthread_exit(NULL);
}

//**************CLIENT***************
void *clientThread(void * threadid){
    int clientId = *((int *)threadid); //our ID
    //generate the server ID
    int i;
    for (i = 0; i < PPP; i++){
        int serverId = rand()%SERVERS;
        
        //prepare the Packet to send
        struct Packet clientPacket;
        clientPacket.clientId = clientId;
        clientPacket.serverId =serverId;
        
        while (numRouterPackets > 5){}
        pthread_mutex_lock(&routerMutex); //lock the router buffer line
        routerPackets[numRouterPackets] = clientPacket;
        numRouterPackets++;
        pthread_mutex_unlock(&routerMutex); //lock the router buffer line
    }
    pthread_exit(NULL);
}


/************MAIN**********/
int main (int argc, char const *argv[]) {
    printf("start main\n");
    int rc;
    
    //CREATE ROUTER MUTEX
    routerMutex = (pthread_mutex_t) PTHREAD_MUTEX_INITIALIZER;
    pthread_t routerThread;

    int t;
    
    
    //CREATE SERVERS
    printf("create servers\n");
    pthread_t servers[SERVERS];
    long *serverids[SERVERS];
    for (t = 0; t < SERVERS; t++){
        serverids[t] = (long *) malloc(sizeof(long));
        *serverids[t] = t;
        int rc = (int) pthread_create(&servers[t], NULL, runServer ,  (void *) serverids[t]);
        if (rc){
            printf("ERRO; código de retorno é %d\n", rc); 
            exit(-1);
        }
    }
    
    //CREATE CLIENTS
    printf("create clients\n");
    pthread_t clients[CLIENTS];
    long *clientids[CLIENTS];
    for (t = 0; t < CLIENTS; t++){
        clientids[t] = (long *) malloc(sizeof(long));
        *clientids[t] = t;
        int rc = (int) pthread_create(&clients[t], NULL, clientThread ,  (void *) clientids[t]);
        if (rc){
            printf("ERRO; código de retorno é %d\n", rc); 
            exit(-1);
        }
    }
    
      //Create Router
    printf("create router\n");
    pthread_t routers[1];
    long *routerids[1];
    for (t = 0; t < 1; t++){
        routerids[t] = (long *) malloc(sizeof(long));
        *routerids[t] = t;
        int rc = (int) pthread_create(&routers[t], NULL, runRouter ,  (void *) routerids[t]);
        if (rc){
            printf("ERRO; código de retorno é %d\n", rc); 
            exit(-1);
        }
    }
    
    //JOIN ALL CLIENTS
    for (t = 0; t < CLIENTS; t++){
        pthread_join(clients[t], NULL);
    }
    
    //FINISH
    printf("done\n");
    routerRunning = 0; //finish the router
    pthread_exit(NULL); //Espera acabar todos os threads
}