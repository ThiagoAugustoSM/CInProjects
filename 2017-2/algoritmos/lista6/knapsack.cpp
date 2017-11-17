// Question http://www.spoj.com/problems/KNAPSACK/
// Find the total maximum value from the best choice of items for your trip.
// Author: Thiago Augusto

#include<bits/stdc++.h>

using namespace std;

// The first column is always filled with '0', because the capacity of the bag is 0

// Example of Matrix in the case
// 0 | 1 | 2 | 3 | 4 | 5
// 0 | 0 | 0 | 0 | 0 | 0
// 0 | 0 | 0 | 8 | 8 | 8

int main(){
    
    int i, j, s, n, size, value, result = 0;
    // s - total capacity of the bag
    cin >> s >> n;
    int checkBag[n + 1][s + 1];
    
    for(j = 0; j < s; j++) checkBag[0][j] = 0;
    
    for(i = 1; i <= n; i++){
        cin >> size >> value;
        
        // Run until <=size and <=n because of the representation in the matrix
        // Fill with the same amout of the previous line
        for(j = 0; j <= size && j <= s; j++){
            checkBag[i][j] = checkBag[i - 1][j];
        }
        
        for(j = size; j <= s; j++){
            if(checkBag[i - 1][j - size] + value > checkBag[i - 1][j])
                checkBag[i][j] = checkBag[i - 1][j - size] + value;
            else
                checkBag[i][j] = checkBag[i - 1][j];
        }
    }
    for(j = s; j >= 0; j--){
        if(checkBag[n][j] != 0)
            break;
    }
    cout << checkBag[n][j];  
    return 0;
}