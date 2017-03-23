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

#2bis = 1  # não pode começar com número

a-1 = 3   # não pode ter hifen

# comandos adicionais, explicar a saída..
dados1
dados1$V3

# algumas funcoes matematicas úteis...
# abs()  : calcula o valor absoluto
# sum()  : ... a suma de todos os valores nos dados de entrada
# mean() : ... a media aritmetica
# sd()   : ... o desvio padrão 
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

# Prática em R: frequencias, caule e folhas
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
vec5 <- vetor1*2
vec6 <- vetor1+vec2

# veja os componentes e a extensão de cada vetor
vetor1
vetor2
vec6

# amostras aleatorias, funcao distribuicao normal
# Ver anexo da distribuição normal. 
# Cada distribuição de probabilidades tem as seguintes funções:
  
# q-  para quantís
# p-  para probabilidade
# r-  para gerar dados da distribuição
# d-  para a densidade acumulada da distribuição

# No seguinte exemplo, vamos gerar 500 dados da distribuição normal, 
# com media e desvio padrão especificado:
  
set.seed(1234)  # a semente garante a repetibilidade dos dados

vetor7 = rnorm(500, mean=2.5, sd=0.8)

plot(vetor7)   # plotagem dos dados, veja a aleatoridade

hist(vetor7)   # histograma, note a forma

mean(vetor7)   # média da amostra, compare com a média especificada

sd(vetor7)     # desvio padrão da amostra


## Matrizes
# Matrizes são objetos em R que _devem todos ter o mesmo número de dados por coluna.

m1 <- matrix(1:12, ncol=3) # visualizar usando mouse
View(m1)                # atencao `!!

# Criar matriz de 100 numeros em 5 colunas (ncol)
m2  <- matrix(1:100, ncol=5)

# pesquisando a matriz
# Criar matriz de 100 numeros em 3 linhas (nrow)
(m1 <- matrix(1:12, ncol = 3)) # visualizar usando mouse na janela 2
(m2 <- matrix(1:12, ncol = 3, byrow =T))             

# Criar matriz de 100 numeros em 5 colunas (ncol)
m3  <- matrix(1:100, ncol=5)


# pesquisando a matriz

dim(m3)            # dimensao 

length(m3)         # comprimento

dimnames(m3)       # nomes das colunas ou linhas??

colnames(m3) <- c("Valor1","Valor2","Valor3","Valor4","Valor5") # atribue nomes

dimnames(m3)

str(m3)

# acessando valores
m4 = matrix(rnorm(32, mean=1, sd=3.5), ncol=4)  # crio uma matriz de distribuição normal em quatro colunas

m4[,2]      # segunda coluna

m4[1,]      # primeira linha

m4[2,3]     # valor especifico da segunda linha, terceira coluna

# operações em matrizes
mean( m4[,1] )   # valor medio da coluna 1

mean( m4 )       # e da matriz?

range( m4 )

sd( m4[,2] )

#ADICIONAR LINHAS OU COLUNAS A UMA MATRIZ
# Calculo e adicao de uma coluna
m4 <- cbind(m4, m4[,4]^2)

# Dataframes e listas
# O Dataframe é um tipo especial de matriz, que tem a vantagem de que as 
# colunas (variáveis) podem ter diferente tipo de dados (numérico, 
# lógico, fatorial..)
# Importar bloco1 com read.csv2

bloco1 <- read.csv2("bloco1.csv")

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

### Gravação de arquivos
Consulte ?write e veja no diretório de trabalho se gravou o arquivo "dado_gravado.csv"

write.table(dado2, file='dado_gravado.csv', sep=";", dec=",", col.names=T)

#praticar com as funções mostradas, usar dados1 quando necessário
  

#=============================================================================================
# FIM DE TREINAMENTO DE MANHA- DIA 01

# Esse trabalho é parte da Oficia de Introdução a Estatística Básica com R (RStudio) - 2017