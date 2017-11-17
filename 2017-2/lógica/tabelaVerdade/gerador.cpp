// Caracteristicas do projeto: http://cin.ufpe.br/~mlogica/tabela.html

#include <bits/stdc++.h>
#define DEBUG cout << "DEBUGGING" << endl;

// #include <cstdio>
// #include <cstdlib>
// #include <iostream>
// #include <string>
// #include <cstring>
// #include <vector> 
// #include <cmath>

using namespace std;

set <string> atomica;
set <string> operador;

set < string > subExpressoes;

void subExpressao(string expressao);
pair <string, string> procuraParenteses(string a);

void subExpressao(string expressao){
	
	subExpressoes.insert(expressao);

	set <string>::iterator itSetChar;
	
	itSetChar = atomica.find(expressao);
	
	
	// Significa que não é atomica e nem um espaço em branco
	if(expressao.length() > 1){
		// cout << "Expressao" << expressao << "OLA" << endl;
		// DEBUG
		pair <string, string> exp = procuraParenteses(expressao);
		// cout << "First: " << exp.first << " Second: " << exp.second << endl;
		subExpressoes.insert(exp.first);
		subExpressoes.insert(exp.second);
		subExpressao(exp.first);
		subExpressao(exp.second);
	}
}

pair <string, string> procuraParenteses(string a){
	pair < string, string > exp;
	vector <int> posicao;

	set <string>::iterator itSetChar;

	int count = 0, i;
	// Significa que a recursao deve ser feita na função de aridade 1, negação
	if(a[1] == '-'){
		exp.first = a.substr(2, a.length() - 3);
		exp.second = "";
		return exp;
	}
	
	for(i = 1; i < a.length(); i++){
		// string(1, char type), makes 1 char to string
		itSetChar = operador.find(string(1, a[i]));
		
		
		if(a[i] == '(')
			count++;
		else if(a[i] == ')')
			count--;
		// cout << "Letra: " << a[i] << " count = " << count << " i = "<< i << endl;
		
		if(count == 0)
			break;
		
		//Saber se o char atual é um operador
		if(itSetChar != operador.end()){
			posicao.push_back(i);
		}else if(count == 0){
			break;
		}
	}
	// A subexpressao a esquerda é dada pelo inicio ao operador que estiver no meio
	// A subexpressao a direita é dada pelo operador do meio ao final da string
	// susbstr(position , length)
	
	exp.first = a.substr(1, i);
	exp.second = a.substr(i + 2, a.length() - (i + 3) );
	// cout << "length " << a.length() << " asdsa:" << a.length() - (i + 3) << endl;
	// cout << "second :" << exp.second << endl; 
	return exp;
}

void imprimiTabela(){
	
	//Lembrar de usar o Qsort ! :D
	
	// Imprimindo a primeira linha da tabela
	printf("|");
	set <string>::iterator itString;
	for(itString = subExpressoes.begin(); itString != subExpressoes.end(); itString++){
		if(*itString != "")
			cout<< *itString << "|" ;
	}
	cout << endl;
}

int main(){

	ifstream inputFile;
	ofstream outputFile("Expressoes.out");
	int n;
	string expressao;

	inputFile.open("EntradaTabela.in", ios::in);

	atomica.insert("x"); atomica.insert("y"); atomica.insert("z"); atomica.insert("t");
	operador.insert("+"); operador.insert("."); operador.insert(">"); operador.insert("-");

	if(inputFile.is_open()){
		inputFile >> n;
		cout << n;
		//n = stoi(expressao);
		while(n--){
			inputFile >> expressao;
			//cout << expressao << endl;
			subExpressao(expressao);
			// subExpressoes.insert(expressao);
			imprimiTabela();
			subExpressoes.clear();
		}
		// Imprimir as subexpressoes
		// O set começar a imprimir do último elemento adicionado
		set <string>::iterator itString;
		for(itString = subExpressoes.begin(); itString != subExpressoes.end(); itString++){
			outputFile << *itString << endl;
		}
		
		
	}
	
	inputFile.close();
	outputFile.close();
}