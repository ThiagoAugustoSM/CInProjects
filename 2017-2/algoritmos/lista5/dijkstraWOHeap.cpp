/*
    Algoritmo: Dijkstra - Lista de Adjacencia sem Heap
    Questão: Highways - SPOJ
    
    Feito por: Thiago Augusto(tasm2)
    CIn - UFPE

    Algoritmos Gulosos:
    1. feasible, i.e., it has to satisfy the problem’s constraints
    2. locally optimal, i.e., it has to be the best local choice among all feasible choices
       available on that step
    3. irrevocable, i.e., once made, it cannot be changed on subsequent steps of the
       algorithm
*/

#include <bits/stdc++.h>

#define INF 1001

using namespace std;

class Graph{
    int V; // Num Vertices
    // Lista de Adjacência em relação ao elemento final e o peso
    list < pair<int, int> > *adj; // first: no final, second: peso
    vector <int> distancias; // Distancias de v[i] até src
    vector <bool> shortPath; // True se o menor caminho até v[i] já
                                 // foi computado
                                 
    public:
        Graph(int V){
            this->V = V;
            adj = new list< pair<int, int> >[V];
            
            vector<int>::iterator it;
            it = distancias.begin();
            distancias.insert (it , V, INF); // Inicializa todos os valores com INF
            
            vector<bool>::iterator itB;
            itB = shortPath.begin();
            shortPath.insert (itB , V, false);//Inicializa todos os valores com false
        };
        
        void showDistance(int src, int end){
            dijkstra(src);
            if(distancias[end] != INF)
                cout << distancias[end] << endl;
            else
                cout << "NONE" << endl;
        }
        
        void addEdge(int v, int w, int weight){
            adj[v].push_back(make_pair(w, weight));
            adj[w].push_back(make_pair(v, weight));
        }
        
        void printaGrafo(){
            int i;
            list< pair<int, int> >::iterator it;   
            for(i = 0; i < V; i ++){
                cout << "Elemento " << i << " - Ligado a:"<< endl;
                for(it = adj[i].begin(); it != adj[i].end(); it++)
                    cout << "indice: " << (*it).first << " - Peso: "<< (*it).second << endl;    
            }
        }
        
        int minDistancia(){
            int min = INF, min_index;
            
            // list< pair <int, int > >::iterator it;
            // for(it = adj[i].begin(); it != adj[i].end(); it++){
            //     if(shortPath[(*it).first] == false && distancias[(*it).first] <= min)
            //         min = distancias[(*it).first], min_index = (*it).first;
            // }
            
            for (int v = 0; v < V; v++)
                if (shortPath[v] == false && distancias[v] <= min)
                    min = distancias[v], min_index = v;
          
           return min_index;
        };
        
        void dijkstra(int src){
            
            // Distancia do nó inicial para ele mesmo é sempre 0
            distancias[src] = 0;
            
            // Achar o menor caminho de src até cada vértice
            for(int i = 0; i < V - 1; i++){
                
                // u sempre será igual a src na primeira instancia
                int u = minDistancia();
                
                // Marca u como processado
                shortPath[u] = true;
                
                // Varrendo a lista de Adjancência do vertice u;
                list< pair<int, int> >::iterator it;
                for(it = adj[u].begin(); it != adj[u].end(); it++){
                    
                    // Atualiza o valor de distancias[*it.pair] só se o valor 
                    // não tiver sido computado antes, ou seja shorPath[it] = true
                    // Atualiza os valores dos caminhos dos vertices que sao adjacentes a u
                    // Se o peso do caminho de src para v por u
                    // for menor que o valor atual de distancia[v], atualizar esse valor    
                    if(shortPath[(*it).first] == false 
                        && distancias[u] + (*it).second < distancias[(*it).first]){
                        distancias[(*it).first] = distancias[u] + (*it).second;
                    }
                }
                
            }
        }
              
};

int main(){
    
    int qntCases, n, m, s, e, c1, c2, w;
    cin >> qntCases;
    while(qntCases--){
        cin >> n >> m >> s >> e;
        // cout << "OI1321" << endl;
        Graph estrada(n);
        // cout << "OI1" << endl;
        while(m--){
            cin >> c1 >> c2 >> w;
            // cout << "O2" << endl;
            estrada.addEdge(c1 - 1, c2 - 1, w);
            estrada.addEdge(c2 - 1, c1 - 1, w);
            // cout << "O3" << endl;
        }
        // cout << "OI" << endl;
        // estrada.printaGrafo();
        estrada.showDistance(s - 1, e - 1);
    }
    
    return 0;
}