inputFile = open("EntradaTabela.in")

expressoes = []

def findSub(exp):
    count = 0
    index = 0
    if(exp[0] == '-'):
        return exp[2: len(exp) - 3]
    
    for char in exp:
        if(char == '(')
            count++
        elif(char == ')')
            count--
        
        #Find charAt somePoint 
        if(count == 0)
            index = exp.
def subExpressao(a):
    findSub()
    subExpressao()



def valorar():
    pass

def printTabela():
    pass

for line in inputFile:
    print(line)
    if(line in expressoes):
        pass
        #already inside the list
    else:
        expressoes.append(line)

for x in range(0, expressoes[0]):
    subExpressoes()
    valorar()
    printTabela()
    expressoes = []
    

inputFile.close()