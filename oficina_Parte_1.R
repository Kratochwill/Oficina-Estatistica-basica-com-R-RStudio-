#==================================================================================================
# Script 01 para oficina Introducao a Estatistica Basica e R(RStudio)
# WHSP- CCAR/GIMAG, Janeiro 2016
# arquivos de dados usados:dados1.txt, dados2.txt, tabelar.txt

## 0 Explorando o RStudio
# Menu principal: 
# File: new project/new file (script)
#       Session/Set working directory
#       Tools/Global options/Packages

# Inicio ------------------------------------------------------------------


# Janelas:
# 1- Janela script
# 2- Janela ambiente/histórico
#    Tarefa: importar arquivo "dados1.txt"
#    ver histórico
# 3- janela comandos: 
#    prompt, comandos a ser executados com enter em azul, respostas em preto

#    executar..
# onde estou?
getwd()

# mudando o diretorio
setwd( "C:/Users/humberto.pina/Documents/R/treinamento/DGC/R")

## 1 Aritmética simples
1+3+5+7 # soma de quatro números
#
2+6+5^2 # incluindo potencias
# 
sin(pi)
#
4/0 # Inf
#
sqrt (35) # raiz
#
sqrt(-35) # NAN

# procurar ajuda:
?as.complex
# impor ou forçar o tipo de dado (coerce)
as.complex(-35)
sqrt(as.complex(-35))
# Mais ajuda
?sqrt
help(mean)
?sd

# 4 - janela gráficos, pacotes e ajuda..
# instalar pacote "ggvis"

# na janela 2, importamos dados1.txt usando Import Dataset, janela 2
# usando read.delim ou read.delim2
read.delim('dados1.txt', sep="")

dados1 <- read.delim('dados1.txt', sep="",header=F)

# Examen do arquivo ..ver primeiras ou ultimas linhas do arquivo
head(dados1)
head(dados1, n=10)
tail(dados1)
# Estrutura do arquivo
str(dados1)
# tamanho
dim(dados1)
length(dados1) # length(dados1$V1)

# na janela 3, executar:
hist(dados1$V2)

## 2 Criando objetos
# objeto x:
x   <-  sqrt(35) # ALT + "-"

x # mostra o valor da variavel "x"

(x   <-  sqrt(20)) # outra forma de atribuir e mostrar o valor atribuido

y = sin(3) # outra forma de atribuir valores, o valor da direita va para a variável a esquerda

z <- tan(pi)

# apagando objetos
rm(x)
rm(y,z)

# cuidado com o seguinte comando!!
rm(list = ls())

# Nomes de variáveis
b1_1 = 10 # underscore permitido

b1.1 = 5  # ponto permitido

#2bis = 1  # não pode come?ar com n?mero

a-1 = 3   # não pode ter hifen

# comandos adicionais, explicar a sa?da..
dados1
dados1$V3

# algumas funcoes matematicas uteis...
# abs()  : calcula o valor absoluto
# sum()  : ... a suma de todos os valores nos dados de entrada
# mean() : ... a media aritmetica
# sd()   : ... o desvio padr?o 
# max()  : ... o maximo valor 
# min()  : ... o minimo valor 
# range(): retorna o valor minimo e maximo 
# round(): arredonda os valores decimas, por padao 0, ver ?round

# calculara media de dados1$V3
mean(dados1$V3)
# e a suma?
sum(dados1$V3)
# e a soma dos valores absolutos
sum(abs(dados1$V3))
# e arrendondados a duas casas decimais?
round(sum(abs(dados1$V3)), 2)

#
# FIM PRIMEIRA PARTE CALCULOS SIMPLES CONTINUA CONCEITOS DE ESTATISTICA
#=================================================================================================
# importar dados, ver R-data Import - Export na documentacao

# Pr?tica em R: frequencias, caule e folhas
# 
stem(dados1$V3, scale=1)
# experimentar com diferentes escalas

# importar arquivo dados2.txt

# experimentar com diferentes escalas
stem(dados2$resp)
# experimentar com diferentes escalas

# Tabelas
table(dados2$bloco, dados2$resp)

# importar tabelar.txt
View(tabelar)

table(tabelar$Regiao_Procedencia,tabelar$Est_Civil)

table(tabelar$Regiao_Procedencia,tabelar$Est_Civil, tabelar$Grau_Inst )


# frequencias
prop.table(table(tabelar$Grau_Inst))

# e pelo estado civil?
prop.table(table(tabelar$Est_Civil))

stem(tabelar$Salario, scale=2)

# FIM DE FREQUENCIAS, CAULE E FOLHAS -  INTERVALO
#=================================================================================================
# OBJETOS EM R: VETORES, MATRIZES, LISTAS

# Funcoes uteis para tratamento de dados:
#   
# seq(): gera uma sequencia, especificando comeco, fim e incremento
# rep(): repete os elementos de vetores ou listas
# sort(): ordena um vetor, trabalha com numeros, carateres ou valores logicos
# rev():  inverte os elementos da estrutura de dados para os quais se especifica
# str():  mostra a estrutura dos dados
# append(): junta vetores o listas
# is.*(): verifica a classe de um objeto R.
# as.*(): Converte um objeto R em outra classe.
# unlist(): separa listas para produzir vetores.


## vetores
vetor1 <- c(1,3,5,7,9,13) # comando concatene
str(vetor1)               # que contem o vetor1?

vetor2 = seq(3, 30, 2)   # comando sequencia
# ver vetor2

## visualizando resultados:
vetor2
print(vetor2)


(vetor3  <-  rep(1,5))     # 

vetor4 <-  rep (c(3,2,1), c(5, 4, 3))
vetor4

# operacoes com vetores, Produto, soma...
vec2 <- vetor1*2
vec3 <- vetor1+vec2


# amostras aleatorias, funcao distribuicao normal
vetor5 = rnorm(50, mean=2.5, sd=0.8)
vetor5
mean(vetor5)
sd(vetor5)

## Matrizes
m1 <- matrix(1:12, ncol=3) # visualizar usando mouse
View(`m1`)                # atencao `!!

# Criar matriz de 100 numeros em 5 colunas (ncol)
m2  <- matrix(1:100, ncol=5)

# pesquisando a matriz
dim(m2)            # dimensao 
length(m2)         # comprimento
dimnames(m2)       # nomes das colunas ou linhas??
colnames(m2) <- c('Valor1','Valor2','Valor3','Valor4','Valor5') # atribue nomes
dimnames(m2)
str(m2)

m3 = matrix(rnorm(60, mean=1, sd=3.5), ncol=4)

# acessando valores
m3[,2]      # segunda coluna
m3[1,]      # primeira linha
m3[2,3]     # valor especifico da segunda linha, terceira coluna


# operacoes em matrizes
mean(m3[,1])   # valor medio da coluna 1
mean(m3)       # e da matriz?
range(m3)

sd(m3[,1])

#ADICIONAR LINHAS OU COLUNAS A UMA MATRIZ
# Calculo e adicao de uma coluna
m4 <- cbind(m3,m3[,4]^2)


# Dataframes e listas
# importar dados_est1

d1 <- bloco1   #  mudar nome de objeto para trabalho
dim(d1)           # dimensoes linha/col
class(d1)         # clase
str(d1)           # estrutura
summary(d1)       # resumo ver os fatores

# Listas sao estruturas genericas e flexiveis que permitem armazenar diversos 
# formatos(incluindo outras listas!), em um unico objeto.
lista1 <- list(A=1:20, B="Texto mensagem", C=matrix(1:15, ncol=3))
lista1$B              # acessando um dos objetos armazenados
lista1$C[1,3]         # acessando um elemento da matriz C

# outras forma de entrar dados, ver ?scan primeiro
x4  <- scan()

df1 <- edit(data.frame()) #criar dataframe com 4,3 linhas colunas

# leitura de arquivos
?read.table # ver especificamente cvs2

dado1 <- read.csv ('bloco1.csv')
dado2 <- read.csv2('bloco1.csv')

# gravacao de arquivos
?write
write.table(dado2, file='dado2.csv', sep=";", dec=",", col.names=T)


#praticar com as fun??es mostradas, usar dados1 quando necess?rio

#=============================================================================================
# FIM DE TREINAMENTO DE MANHA- DIA 01

