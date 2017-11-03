#include <iostream>
#include <vector>

using namespace std;

int main(){
    
    vector <int> distancias(10);
    vector <bool> shortPath(10);
    // distancias.insert(0);
    distancias[1] = 3;
    shortPath[1] = false;
    
    cout << distancias[1];
    
    return 0;
}