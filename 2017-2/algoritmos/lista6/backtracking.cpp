// Problem: https://uva.onlinejudge.org/external/7/p750.pdf
// Backtrack a possible eight queen problem on a board

// The ideia is to create a Board with Q's and marked markSpots
// where a number 0, 1, 2, 3, mark how many Queens attack that spot

#include <bits/stdc++.h>
#define SIZE_BOARD 8

void bt(int row, int column, char board[SIZE_BOARD][SIZE_BOARD]){
	markSpots(row, column, board);
}

char checkBoard(char board[SIZE_BOARD][SIZE_BOARD]){
	int i, j;
	for(i = 0; i < SIZE_BOARD; i++){
		for(j = 0; j < SIZE_BOARD; j++){
			if()
		}
	}
}

// Function to mark spots from some Queen
void markSpots(int row, int column, char board[SIZE_BOARD][SIZE_BOARD]){
	int i, j;
	// marking row
	for(j = 0 ; j < SIZE_BOARD; j++){
		if(board[row][j] != 'Q')
			board[row][j]++;
		else if(board[row][j] == 'Q')
			return 'E'; //error
	}

	// marking column
	for(i = 0; i < SIZE_BOARD; i++){
		if(board[i][column] != 'Q')
			board[i][column];
		else if(board[i][column] == 'Q')
			return 'E';
	}

	// marking Principal diagonal
	for(i = 1; i < SIZE_BOARD; i++){
		if(row - i >= 0 && column - i >= 0){
			if(board[row - i][column - i] != 'Q')
				board[row - i][column - i]++;
			else
				return 'E';
		}else{
			break;
		}
	}
	for(i = 1; i < SIZE_BOARD; i++){
		if(row + i < SIZE_BOARD && column + i < SIZE_BOARD){
			if(board[row + i][column + i] != 'Q')
				board[row + i][column + i]++;
			else
				return 'E';
		}else{
			break;
		}
	}

	// marking second diagonal
	for(i = 1; i < SIZE_BOARD; i++){
		if(row - i >= 0 && column + i < SIZE_BOARD){
			if(board[row - i][column + i] != 'Q')
				board[row - i][column + i]++;
			else
				return 'E';
		}else{
			break;
		}
	}
	for(i = 1; i < SIZE_BOARD; i++){
		if(row + i < SIZE_BOARD && column - i >= 0){
			if(board[row + i][column - i] != 'Q')
				board[row + i][column - i]++;
			else
				return 'E';
		}else{
			break;
		}
	}
}

int main(){

    int n, row, column;
	char board[SIZE_BOARD][SIZE_BOARD];
    cin >> n;

	// Erasing every space at the board before using it
	memset(&board,'0',sizeof(board[0][0]) * SIZE_BOARD * SIZE_BOARD);

	for(i =)

    for(i = 0; i < n; i++){
        cin >> row >> column;
		board[row - 1][column - 1] = 'Q';
		if(row - 1 == 0)
			bt(1, 0, board);
		else
			bt(0, 0, board);
		memset(&board,'0',sizeof(board[0][0]) * SIZE_BOARD * SIZE_BOARD);
    }
    return 0;
}
