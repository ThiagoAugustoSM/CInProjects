//Questão http://www.spoj.com/problems/KNAPSACK/
// Find the total maximum value from the best choice of items for your trip.


#include<bits/stdc++.h>

typedef vector<int> vi;
typedef vector<vi> matrix;
using namespace std;

// The first column is always filled with '0', because the capacity of the bag is 0

int main(){
    
    int i, s, n, size, value, result = 0;
    // s - total capacity of the bag
    cin >> n >> s;
    int checkBag[n][s];
    
    for(int j = 0; j < s; j++) checkBag[0][j] = 0;
    
    for(i = 1; i < n; i++){
        cin >> size >> value;
        
        for(j = 0; j < size && j < s; i++){
            checkBag[i][j] = checkBag[i - 1][j];
        }
        
        for(j = size; j < s; j++){
            if(checkBag[i][j - size] + value > checkBag[i - 1][j])
                checkBag[i][j] = checkBag[i][j - size] + value;
            else
                checkBag[i][j] = checkBag[i - 1][j];
        }
    
        for(i = s - 1; i >= 0; i--){
            if(checkBag[n - 1][i] != 0)
                break;
        }
        cout << checkBag[n - 1][i];    
    }
    return 0;
}