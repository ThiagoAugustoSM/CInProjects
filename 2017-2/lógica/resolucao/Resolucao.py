# Algoritmo: Implementação do Método da Resolução
# Disciplina: Lógica para Computação
# Autor: Thiago Augusto - tasm2

inputFile = open("Expressoes.in")
outputFile = open("Expressoes.out", "w")

atomicas = ['a', 'b', 'c', 'd']

entrada = []
for line in inputFile:
    entrada.append(line)
inputFile.close()

def verificaFNC(expressao):
    #return 1 - FNC , return 0 - Não está na FNC
    count = 0
    for letra in expressao:
        if(letra == '('):
            count = count + 1
        elif(letra == ')'):
            count = count - 1
        
        elif(letra == '>'):
            return 0
        elif(letra == '.' and count != 0):
            return 0
        elif(letra == '+' and count == 0): #(a+b)+(b+c)
            return 0
            
        #significa que tem uma expressao com parenteses dentro
        #que de acordo com a saída nao está na FNC
        if(count >= 2):
            return 0
            
    return 1

def verificaHorn(result, expressao):
    
    if(result == 0):
        return 0
    
    #return 1 - FNC , return 0 - Não está na FNC
    count = 0
    countPositivo = 0
    i = 0
    
    for letra in expressao:
        if(letra == '('):
            count = count + 1
        elif(letra == ')'):
            count = count - 1
            
        elif(letra == '+' and expressao[i + 1] in atomicas):
            countPositivo = countPositivo + 1
        
        if(count == 0):
            #Cláusula de Horn Contém no máximo um literal Positivo
            if(countPositivo > 1):
                return 1
            countPositivo = 0
        i = i + 1
    # É clausula de Horn
    return 2
    
def satisfativel(result, expressao):
    
    # return 3 - Satisfativel , return 4 - Insatisfativel
    
    if(result == 0):
        return 0
    elif(result == 1):
        return 1
    
    subAtomicas = []
    subExpressoes = []
    
    # A ideia é ter uma lista de listas, onde cada lista interior conterará
    # cada elemento positivo ou negativo, e depois iterar entre cada um deles par a par
    # e analisar a lista de subExpressoes subAtomicas
    subExpAtual = []
    i = 0
    count = 0
    for letra in expressao:
        
        if(letra == '('):
            count += 1
        elif(letra == ')'):
            count -= 1
        
        if(letra == '+' or letra == '('):
            if(expressao[i + 1] == '-'):
                if(expressao[i + 1 : i + 3] not in subExpAtual):
                    subExpAtual.append(expressao[i + 1 : i + 3])
            else:
                if(expressao[i + 1] not in subExpAtual):
                    subExpAtual.append(expressao[i + 1])
        
        if(count == 0):
            if(len(subExpAtual) == 1):
                if(subExpAtual[0] not in subAtomicas):
                    subAtomicas.append(subExpAtual[0])
            if(len(subExpAtual) >= 1):
                if(subExpAtual not in subExpressoes):
                    subExpressoes.append(subExpAtual)
            subExpAtual = []
        i += 1
    
    subExpressoes.sort(key=len)
    
    # Removendo literais nas clausulas de horn do tipo a+-a
    for sub in subExpressoes:
        for item in sub:
            if(len(item) == 2 and str(item[1]) in sub):
                sub.remove(item)
                sub.remove(item[1])
    
    subAux = [] #Salvar todas as subexpressoes que serão tiradas os termos -a do TPU
    subAuxAtomicas = []
    # Utilizando o teorema da propagação unitária:
    # Tendo a, remove-se todas as clausulas que tiverem a, e 
    # mantem-se as clausulas que tem -a, só que retira-se o -a
    # Depois só analisar todas as clausulas unitarias que sobraram
    while(True):
        for item in subAtomicas:
            for subExp in subExpressoes:
                if(item in subExp):
                    pass
                if(len(item) == 1 and str('-' + str(item)) in subExp):
                    subExp.remove(str('-' + str(item)))
                    if(len(subExp) == 1):
                        subAuxAtomicas.append(subExp[0])
                    elif(len(subExp) != 0):
                        subAux.append(subExp)
                elif(len(item) == 2 and item[1] in subExp):
                    subExp.remove(item[1])
                    if(len(subExp) == 1):
                        subAuxAtomicas.append(subExp[0])
                    elif(len(subExp) != 0):
                        subAux.append(subExp)
        if(len(subAuxAtomicas) > 0):
            
            subExpressoes = subAux
            
            for item in subAuxAtomicas:
                if(item not in subAtomicas):
                    subAtomicas.append(item)
            subAuxAtomicas = []
            subAux = []
        else:
            break
    
    subAtomicas.sort(key=len)
    for atom in subAtomicas:
        if(len(atom) == 1 and str("-" + str(atom)) in subAtomicas):
            return 4
    return 3 #satisfativel


dados = []
def salvarDados(result, case):
    
    dados.append("caso #"+ str(case) + ": ")
    if(result == 0):
        dados.append("nao esta na FNC")
    elif(result == 1):
        dados.append("nem todas as clausulas sao de horn")
    elif(result == 2):
        dados.append("todas as clausulas sao de horn")
    elif(result == 3):
        dados.append("satisfativel")
    elif(result == 4):
        dados.append("insatisfativel")
    dados.append("\n")
    
for case in range(1, int(entrada[0]) + 1):
    
    expressao = entrada[case]
    result = verificaFNC(expressao)
    result = verificaHorn(result, expressao)
    result = satisfativel(result, expressao)
    salvarDados(result, case)

outputFile.writelines(dados)
outputFile.close()
