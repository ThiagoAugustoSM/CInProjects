inputFile = open("Expressoes.in")
outputFile = open("Expressoes.out", "w")

expressoes = [] #Salvar todas as expressoes lidas no arquivo de entrada
subExp = [] #subExpressoes Atual
marcados = [] #vetor para saber quais '(' ')' já foram visualizados
expAtual = ""
atomicas = ['x', 'y', 'z', 't']
atomicasAtual = []
valorTabela = [] #Matriz, que é inicilizada depois, para salvar os valores da tabela
################################################################################

## Funcoes Para Valoração
def Fand(sub1, sub2):
    return sub1 and sub2
    
def For(sub1, sub2):
    return sub1 or sub2
    
def Fnot(sub):
    return not sub
    
def Fimp(sub1, sub2):
    if(sub1 == 1 and sub2 == 0):
        return 0
    return 1
################################################################################

## Funções Para definir se é "satisfativel" ou "insatisfativel" | "tautologia" ou "refutavel"
def satisfativel():
    ultimaColuna = len(subExp) - 1
    sat = 0
    tautologia = 1
    for x in range(2 ** countAtomicas):
        if(valorTabela[x][ultimaColuna] == 1):
            sat = 1
        else:
            tautologia = 0
    return [sat, tautologia]

################################################################################

## Achar quais atômicas presentes nas subexpressoes
def findAtomica():
    countAtomicas = 0
    for x in expAtual:
        if (x in atomicas) and (x not in subExp):
            subExp.append(x)
            countAtomicas += 1
            atomicasAtual.append(x)
            atomicasAtual.sort()
    return countAtomicas
################################################################################

## Achar todas as subexpressões            
def findSub(pointer):
    # Pointer vai ficar indo até o final da string para achar as subexpressões
    # Enquanto i, vai voltar para achar os '(' que abrem a subexpressão
    while(expAtual[pointer] != ')' and marcados[pointer] != 1 
            and pointer < len(expAtual)):
        pointer += 1
        if(pointer >= len(expAtual)):
            break
        
    i = pointer
    while(i >= 0):
        # Resolver o problema de string out of range
        while(i >= len(expAtual)):
            i -= 1
            
        if(expAtual[i] == '(' and marcados[i] == 0):
            break
        i -= 1;
        
    if(i <= -1):
        return 0
    
    # Se a subexpressao ainda não estiver contida no conjuto
    if(expAtual[i:pointer + 1] not in subExp):    
        subExp.append(expAtual[i:pointer + 1])
    
    # Marcando Os parênteses lidos para não serem testados nas próximas
    # subexpressões
    marcados[pointer] = 1
    marcados[i] = 1
    
    if(pointer < len(expAtual)):
        findSub(pointer + 1)
################################################################################

## Valorar cada subexpressão
def valorar(expressao, linha, begin, end):
    count = 0
    if(begin == end):
        atom = expressao[end] 
        if (atom in atomicas):
            return valorTabela[linha][atomicasAtual.index(atom)]
    for x in range(begin, end):
        if(expressao[x] == '('):
            count += 1
        elif(expressao[x] == ')'):
            count -= 1
        else:
            if(count == 1):
                if(expressao[x] == '-'):
                    return Fnot(valorar(expressao, linha, x + 1, end - 1))
                elif(expressao[x] == '.'):
                    return Fand(valorar(expressao, linha, begin + 1, x - 1),
                                valorar(expressao, linha, x + 1, end - 1))
                elif(expressao[x] == '+'):
                    return For(valorar(expressao, linha, begin + 1, x - 1),
                                valorar(expressao, linha, x + 1, end - 1))
                elif(expressao[x] == '>'):
                    return Fimp(valorar(expressao, linha, begin + 1, x - 1),
                                valorar(expressao, linha, x + 1, end - 1))
    if(expressao[begin] in atomicas):
        return valorTabela[linha][atomicasAtual.index(expressao[begin])]
################################################################################

dadosSalvar = []
## FUNÇÕES PARA SALVAR A TABELA NUM ARQUIVO .OUT
def saveLine():
    for x in range(len(subExp)):
        for y in range(len(subExp[x])):
            dadosSalvar.append("-")
    for x in range(len(subExp) + 1):
        dadosSalvar.append("-")
    dadosSalvar.append("\n")

def saveSpace(qnt):
    for x in range(qnt):
        dadosSalvar.append(" ")

def saveTabela(num, sat):
    dadosSalvar.append("Tabela #"+str(num)+"\n")
    saveLine()
    for x in range(len(subExp)):
        dadosSalvar.append("|")
        dadosSalvar.append(subExp[x])
    dadosSalvar.append("|\n")
    saveLine()
    for x in range(2 ** countAtomicas):
        for y in range(len(subExp)):
            dadosSalvar.append("|")
            saveSpace(len(subExp[y]) - 1)
            if(valorTabela[x][y]):
                dadosSalvar.append("1")
            else:
                dadosSalvar.append("0")
        dadosSalvar.append("|\n")
        saveLine()
    if(sat[0] == 0):
        dadosSalvar.append("insatisfativel")
    else:
        dadosSalvar.append("satisfativel")
    dadosSalvar.append(" e ")
    if(sat[1] == 0):
        dadosSalvar.append("refutavel")
    else:
        dadosSalvar.append("tautologia")
    dadosSalvar.append("\n\n")
###############################################################################

## FUNÇÕES PARA IMPRESSÃO DA TABELA
def printLine():
    for x in range(len(subExp)):
        for y in range(len(subExp[x])):
            print("-", end="")
    for x in range(len(subExp) + 1):
        print("-", end="")
    print("")

def printSpace(qnt):
    for x in range(qnt):
        print(" ", end = "")

def printTabela():
    printLine()
    for x in range(len(subExp)):
        print("|", end="")
        print(subExp[x], end = "")
    print("|")
    printLine()
    for x in range(2 ** countAtomicas):
        for y in range(len(subExp)):
            print("|", end="")
            printSpace(len(subExp[y]) - 1)
            if(valorTabela[x][y]):
                print("1", end="")
            else:
                print("0", end="")
        print("|")
        printLine()
###############################################################################

## Organizando os valores em ordem lexicográfica    
def sorting():
    for a in range(0, len(subExp)):
        for b in range(0, len(subExp)):
            if(len(subExp[a]) < len(subExp[b])):
                subExp[b], subExp[a] = subExp[a], subExp[b]
            elif(len(subExp[a]) == len(subExp[b])):
                for x in range(0, len(subExp[a])):
                    if(subExp[a][x] != subExp[b][x]):
                        if(subExp[a][x] < subExp[b][x]):
                            subExp[b], subExp[a] = subExp[a], subExp[b]
                        break
###############################################################################

## Preenchendo os valores iniciais da tabela para as atomicas de 0 a 2^n
def setTabela():
    aux = 2 ** (countAtomicas - 1)
    for a in range(2 ** countAtomicas):
        for b in range(countAtomicas):
            if(int(a) & int(aux)):
                valorTabela[a][b] = 1
            else:
                valorTabela[a][b] = 0
            aux = aux / 2
        aux = 2 ** (countAtomicas - 1)
###############################################################################

## Lendo os valores de Entrada
for line in inputFile:
    expressoes.append(line)
inputFile.close()

###############################################################################

#################### MAIN #####################################################
for k in range(1, int(expressoes[0])):
    
    expAtual = expressoes[k]
    
    #Inicializando valores com 0
    marcados = [0 for x in range(len(expAtual))]
    dadosSalvar = []
    subExp = []
    atomicasAtual = []
    countAtomicas = findAtomica()
    findSub(0)
    sorting()
    
    # Inicializando a Matriz com valores 0
    valorTabela = [[0 for x in range(len(expAtual))] for y in range(2 ** countAtomicas)]
    setTabela()
    for x in range(2 ** countAtomicas):
        for y in range(countAtomicas, len(subExp)):
            valorTabela[x][y] = valorar(subExp[y], x, 0, len(subExp[y]))
            
    sat = satisfativel()
    printTabela()
    saveTabela(k, sat)
    
    outputFile.writelines(dadosSalvar)

outputFile.close()