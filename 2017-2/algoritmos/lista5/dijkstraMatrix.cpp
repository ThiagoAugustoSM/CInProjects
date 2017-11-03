// A C / C++ program for Dijkstra's single source shortest path algorithm.
// The program is for adjacency matrix representation of the graph
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <limits.h>
#include <cstring>
  
// Number of vertices in the graph
#define MAX (n > m ? n : m)
using namespace std;
// A utility function to find the vertex with minimum distance value, from
// the set of vertices not yet included in shortest path tree
int minDistance(int dist[], bool sptSet[], int V)
{
   // Initialize min value
   int min = INT_MAX, min_index;
  
   for (int v = 0; v < V; v++)
     if (sptSet[v] == false && dist[v] <= min)
         min = dist[v], min_index = v;
  
   return min_index;
}
  
// A utility function to print the constructed distance array
int printSolution(int dist[], int n, int e)
{
   if(dist[e] != INT_MAX)
    printf("%d\n", dist[e]);
    else
        printf("NONE\n");
}
  
// Funtion that implements Dijkstra's single source shortest path algorithm
// for a graph represented using adjacency matrix representation
void dijkstra(int V, int graph[100001][100001], int src, int end)
{
     int dist[V];     // The output array.  dist[i] will hold the shortest
                      // distance from src to i
  
     bool sptSet[V]; // sptSet[i] will true if vertex i is included in shortest
                     // path tree or shortest distance from src to i is finalized
  
     // Initialize all distances as INFINITE and stpSet[] as false
     for (int i = 0; i < V; i++)
        dist[i] = INT_MAX, sptSet[i] = false;
  
     // Distance of source vertex from itself is always 0
     dist[src] = 0;
  
     // Find shortest path for all vertices
     for (int count = 0; count < V-1; count++)
     {
       // Pick the minimum distance vertex from the set of vertices not
       // yet processed. u is always equal to src in first iteration.
       int u = minDistance(dist, sptSet, V);
  
       // Mark the picked vertex as processed
       sptSet[u] = true;
  
       // Update dist value of the adjacent vertices of the picked vertex.
       for (int v = 0; v < V; v++)
  
         // Update dist[v] only if is not in sptSet, there is an edge from 
         // u to v, and total weight of path from src to  v through u is 
         // smaller than current value of dist[v]
         if (!sptSet[v] && graph[u][v] && dist[u] != INT_MAX 
                                       && dist[u]+graph[u][v] < dist[v])
            dist[v] = dist[u] + graph[u][v];
     }
  
     // print the constructed distance array
     printSolution(dist, V, end);
}
  
// driver program to test above function
int main()
{       
    int graph[100001][100001] = {0};
    // memset (graph, 0, 100001 * 100001 * sizeof(int));
       int qntCases, n, m, s, e, c1, c2, w;
    cin >> qntCases;
    while(qntCases--){
        cin >> n >> m >> s >> e;
        // cout << "OI1321" << endl;
        int graph[n][n] = {0};
        // cout << "OI1" << endl;
        while(m--){
            cin >> c1 >> c2 >> w;
            // cout << "O2" << endl;
            graph[c1 - 1][c2 - 1] = w;
            graph[c2 - 1][c1 - 1] = w;
        }
        // cout << "OI" << endl;
        // estrada.printaGrafo();
        dijkstra(n, graph, s - 1, e - 1);
    }   
  
    
  
    return 0;
}