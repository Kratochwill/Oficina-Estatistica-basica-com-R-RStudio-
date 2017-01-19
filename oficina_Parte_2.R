  
# title: "Introdução a Estatística Básica e R(RStudio) -2a. Parte"
# author: "Walter Humberto Subiza Pina"
# date: "10 de janeiro de 2017"

## Estatistica Basica

###Importando dados 
#   A forma mais fácil é importar dados ascii é a partir do formato csv ou txt. O formato csv 
# pode ser facilmente gerado a partir de planilhas de cálculo, tipo Excel ou Calc. 
# 
# Lendo arquivos de texto
# 
# Podemos usar a função genérica _read.table_, ver ?read.table, que apresenta além dos parâmetros 
# padrão, funções de leitura derivadas, como _read.csv2_ e _read.delim2_, adequados a nosso 
# sistema métrico decimal.
# 
# Vejamos alguns exemplos. O arquivo "dados1.txt", tem a seguinte estrutura:
#   
#   | 1 | 1 | -15.15487 |
#   | 2 | 1 | -12.69161 |
#   | 3 | 1 | -15.34216 |
#   | 4 | 1 | -16.99144 |
#   | 5 | 1 | -10.41146 |
#   | 6 | 1 | -18.15309 |
#   
#   Vamos ver como fica a sua leitura com _read.table_:

 
exerc01 <- read.table('dados1.txt')
head(exerc01)


# A função _read.table_, tem como padrão de importação o separador de colunas como "," e o separador 
# decimal como ".", padrão inglês.
# 
# Vamos importar agora dois arquivos de dados, "dados2.txt", é um arquivo com cabeçalho e separador 
# decimal de ".";
# o arquivo "dados3.txt", tem cabeçalho mas o separador decimal é ",", pelo que vamos detalhar essas 
# opções na importação.

exerc02 <- read.table('dados2.txt', 
                      header=T) # adicionar via Import dataset
head(exerc02)

exerc03 <- read.csv(file  = 'dados3.txt', 
                    header= T, 
                    sep   = ";", 
                    dec   = ",") # adicionar via Import dataset
head(exerc03)
 

# O seguinte arquivo é um arquivo csv, gerado a partir de uma planilha Calc do LibreOffice e além do 
# cabeçalho, o separador decimal é "," e o separador de variáveis é";". Ele tem o seguinte aspecto:
#   
#   
#   |Bloco| Sub-Bloco| Camp  | Est | Municip | H      | DTM-H | DSM-H | DSM-DTM |
#   | 1   | 01A      | LC415 | 180 | Barras  | 100,51 | 0,77  | 2,72  | 1,95    |
#   | 1   | 01A      | LC415 | 181 | Barras  | 96,82  | -0,38 | -0,1  | 0,28    |
#   | 1   | 01A      | LC415 | 182 | Barras  | 113,49 | -0,51 | 0,11  | 0,62    |
#   | 1   | 01A      | LC415 | 183 | Barras  | 87,13  | 2,41  | 1,46  | -0,95   |
#   | 1   | 01A      | LC415 | 184 | Barras  | 75,99  | -2,74 | -0,81 | 1,93    |
#   | 1   | 01A      | LC415 | 185 | Barras  | 105,31 | 0,39  |       |         |
#   | 1   | 01A      | LC415 | 186 | Barras  | 96,44  | -0,24 | 4,21  | 4,45    |
#   
#   
#   
#   Note que na quinta linha tem dados faltantes em duas colunas. A importação será feita com a 
# função _read.cvs_, especificando as particularidades e com a versão adaptada _read.csv2_. 

est1 <- read.csv('bloco1.csv', 
                 header = T, 
                 sep    = ";", 
                 dec    = ",")
head(est1)

est2 <- read.csv2('bloco1.csv', 
                  header=T)
head(est2)
 
#Tem diferencas entre est1 e est2?...as duas formas são equivalentes. Ver a estrutura e o resumo de est1 

str(est1)         # notar que Bloco não esta considerado fator

summary(est1)     # Analisar fatores, valores e NAs
 
# Forcar variável "Bloco" como fator, ver novamente estrutura e resumo, tem diferenças??

est1$Bloco <- as.factor(est1$Bloco)

str(est1)

summary(est1)
 

# Note que quando o summary encontra um fator, ele faz a contagem de elementos por categoria
# Vamos conhecer agora uma base de dados que está incluída no R para testes e estudos (tem várias). 
# A base de dados é a **mtcars** (Motor Trend Car Road Tests), para mais informação, como 
# sempre: ?mtcars na janela de console


# Veja o seguinte exemplo do comando with. O código em r do exemplo pode ser lido como:
#   
#   _"Com a os dados de mtcars, me faça uma impressão das estatísticas da variável mpg, e 
# adiciona dois gráficos, um da variável mpg com disp e um outro com mpg e wt"_. 

# Em R é:
 
with(mtcars, {
  print(summary(mpg))
  
  plot(mpg, disp)
  
  plot(mpg, wt)
})
 

  # Vamos conhecer uma função da biblioteca pysch, muito útil porque nos fornece de uma vez 
  # só as principais estatísticas de nossos dados. A função é "_describe_"

library(psych) # carregamos a biblioteca, se ela não estiver, tem que instalar primeiro (veja Parte 1)
describe(est1)
resumo <- round(describe (est1), 2 ) # guardamos os resultados da função na variável "resumo"
 

# Agora vamos gravar um arquivo csv com tabela já simplificada de estatisticas. Verificar linhas 
# (a variável "vars" nos dá o número da linha) e colunas em "resumo" para imprimir!!! 
#   
# neste caso, estamos gravando as **linhas 7:9** e as **colunas  2:5,8:10** . 
# Confira no fragmento de código a seguir.
# 
# O arquivo pode ser importado numa planilha Calc ou Excel, atentar para o deslocamento da 
# primeira linha no arquivo de saída.

# crio uma variável para guardar os nomes que desejo nas colunas
nomes <- c("n", "Média", "DesvioPad", "Mediana", "Mín", "Máx", "Amplitude")

write.table (resumo[c(7:9),c(2:5,8:10)], 
             file = "estacoes.csv", 
             sep  = ";", 
             dec  = ",",
             col.names = nomes)

  
  
  ### Funções estatísticas de posicão
  
#   **Média**
#   A média está definida como a soma de todas as observações, dividida a quantidade de observações
# 
# $$\bar{x} = \frac{1}{n} \sum_{i=1}^{n}x_{i}$$ 
#
#   Vamos calcular a média  da variável H de "est1", passo a passo? 

attach(est1)  # Para trabalhar com os nomes das variáveis diretamente..

# Como obtemos o total de observações de um vetor?
n <- length(H)

#E o somatório das observações??
total <- sum(H)

#A média assim fica determinada por:
( H.bar <- total/n )
 
# Muitas vezes temos operações que queremos transformar em funções para poupar tempo e código. 
# 
# No menú principal "Code/Extract Function Ctrl+Alt+X" nos facilita construir a função, uma vez 
# que o código está pronto. 
# 
# O código neste caso pode ser: **sum(x)/length(x)**.
# 
# Basta selecionar o código e ir no caminho do menú principal e teremos um resultado com esse:

media.aritmetica <- function(x) sum(x)/length(x)

# E comparando com a função "mean" do R
media.aritmetica(H)

mean(est1$H)

mean(H)

  
#   **moda**
#   A moda é aquela observação que mais se repete nas no conjunto de dados, como já vimos, 
# pode não existir, tem apenas uma ou muitas..
# 
# Vamos construir nossa função passo a passo...
#... funcao moda, basicamente criamos uma tabela com as frequências de cada clase e logo 
# tomamos a de maior frequência

moda <- function(x) {
  z <- table(as.vector(x)) 
  names(z)[z == max(z)]
}

# calculo de H com nossa moda
moda(H)

# Verificação
sort(H)  

#library modeest apenas para variaveis quantitativas
library ("modeest")

(mfv(H))

#  nos dados de est1 qual o Município mais frequente?
moda(Municip)

 
#   **mediana**
#   
#   A mediana é aquela observação que ocupa a posição central após ser ordenado o vetor, ou 
# seja 50% das observações é menor do que ele e 50% é maior.
# 
# A função "_median_" do R faz o cálculo da mediana em qualquer vetor. Vejamos a função do 
# R e vejamos como construir uma função semelhante.

median(H)

# Construimos a mediana como função..
# como achar oponto medio do conjunto??... ordenar o vetor e encontrar o valor da posição média
# num vetor de elementos ímpares é fácil já que temos um único elemento central...
sort(H)[ceiling(length(H)/2)] # ordenamos o vetor e extraemos o que ocupa a posição central

# e se o número de elementos é par?? a variável exerc01$V3 tem 100 observações..
# como achar o médio? temos que achar a posição o anterior e o posterior
ceiling(length(exerc01$V3)/2) 

# e a posição posterior
ceiling (length(exerc01$V3)/2 + 1)

#  e finalmente vamos separar os dois valores e promediar
(sort(exerc01$V3)[ceiling(length(exerc01$V3)/2)] + sort(exerc01$V3)[ceiling (length(exerc01$V3)/2) + 1])/2

# Para construir a função, temos de considerar os dois casos.
# como verificar se o vetor tem número par ou ímpar de dados??
# função "modulo" de R: %%, módulo de um número par tem um resto 0 e de um número impar, o resto é 1

# criar uma função com o procedimento descrito

mediana <- function(x) {
  modulo <- length(x)%%2                                # verificar se é par ou ímpar
  if (modulo == 0) (sort(x)[ceiling(length(x)/2)] +     # se par...
                      sort(x)[ceiling (1+length(x)/2)])/2
  
  else sort(x)[ceiling(length(x)/2)]                    # se ímpar...
}

# comparemos...
median(H)

mediana(H)

median(exerc01$V3)

mediana(exerc01$V3)

# **ponto medio**
#   
#   O ponto médio, é aquele valor que se encontra na metade entre o valor máximo e mínimo do 
# conjunto analisado. A diferença da mediana, aqui o que interessa é o valor do dado e não sua posição.
# 
# É um parâmetro muito afetado pelos valores extremos e pelas assimetrias nas distribuição das observações.

 
(pmedio <- (max(H)-min(H))/2) # pontos extremos!!

# Compare com a média do conjunto
media.aritmetica(H)

# e com a mediana
mediana(H)
 

### MEDIDAS DE DISPERSAO
# 
# **amplitude**
range(H) # Amplitude da variável DTM.H

range(H)[1] # podemos acessar ao minimo ou ao máximo [2]

#Funcoes diferenca e suma da amplitude
diff(range(H))

sum(range(H))
 
#   **variancia e desvio padrao**
#   
#   A fórmula para a variância é:
#   
#   $$\sigma^{2} = \frac{\sum_{i=1}^{n} 
#     \left(x_{i} - \bar{x}\right)^{2}} {n-1}$$
  
#   Ela é expressa por um somatório de residuos ao quadrado, divida pelo número de 
# observações $n-1$. A razão da divisão por $n-1$, vem de ter perdido um grau de 
# liberdade quando o cálculo da média usada, $\bar{x}$ .
# 
# O R tem a função "_var_", que calcula diretamente a variância

# construção da função variância 
variancia <- function (x) 
  sum((x-mean(x))^2)/(length(x)-1)

variancia(DTM.H)

# comparando
var(DTM.H) # variancia
 
# O desvio padrão $\sigma$, vem expresso pela raíz quadrada da variância:
#   
#   $$\sigma = \sqrt{\frac{\sum\limits_{i=1}^{n} \left(x_{i} - \bar{x}\right)^{2}} {n-1}}$$
#   
#   O R tem a função "_sd_", que calcula diretamente o desvio padrão.

# construção da função desvio padrão 
desv.pad <- function (x) 
  sqrt(sum((x-mean(x))^2)/(length(x)-1))

# comparando... 
desv.pad(DTM.H)  # função própia

sd(DTM.H)       # função R

sqrt(variancia(DTM.H))

sqrt(var(DTM.H)) #desvio padrao atraves da variancia
 

#  FIM DA SEGUNDA PARTE

  
  