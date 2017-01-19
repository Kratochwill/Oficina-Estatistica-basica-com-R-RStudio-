# ---
#   title: "Introdução a Estatística Básica e R(RStudio) - 4a. Parte"
# author: "Walter Humberto Subiza Pina"
# date: "12 de janeiro de 2017"
# output: html_document
# ---
#   
 


## Trabalhando gráficos, Correlação e Regressão
# Vamos importar um conjunto de dados para trabalhar mais um pouco com gráficos

 
est1 <- read.csv('bloco1.csv', header=T, sep=";", dec=",")

# conhecendo os dados
summary(est1)

# trabalhando com as variáveis diretamente
attach(est1)
 

###Histogramas

 
hist(DTM.H) # histograma
 

 
hist(DTM.H, breaks=20) # mudar intervalos
 

 
hist(DTM.H, breaks=20, prob=T, xlim=c(-6,6)) # mudar escala x e aprentar a densidade da probabilidade em vez das frequencias
 


# Exercicio 01_**: fazer o histograma da variável (H), adicionar títulos e nomes nos eixos. 
# Adequar os eixos e os intervalos

###Boxplot
   
boxplot(DTM.H, DSM.H, DSM.DTM)
 
# Exercicio 02: mude a orientação do boxplot, coloque cores diferentes nos três e adicione uma linha 
# transversal de valor 0, cor vermelha e espessura 2. 
# Adicione o título:"Comparação das três variáveis" e o nome das variáveis no eixo Y 
# (dica, vai ter de suprimir o eixo Y e usar _axis_)

  
###Diagrama de dispersão ou scatterplot
# Diagrama de dispersão com três variáveis de amplitude semelhante.

plot(DTM.H)
points(DSM.H)
points(DSM.DTM) 

# Exercicio 03:  Ajustar limites eixo y, mudar o tipo e cor de cada conjunto de pontos 
# ver (?points). Coloque nomes nos eixos e no gráfico. Adicione uma legenda (?legend).
# Dica: Os valores de cada conjunto podem ser conferidos com _range_ (cuidado com valores "NA"!).

  # Diagrama de dispersão com duas variáveis, uma em cada eixo para ver a correlação entre elas.


 
with(est1, plot(DTM.H, H))
 


# Exercicio 04:  Colocar titulo principal e em cada eixo, mudar o tipo, cor e tamanho dos pontos. 
# Adicionar duas linhas verticais nos valores de -2.5 e + 2.5 (ajustar eixo de valores). Adicionar um subtítulo.
# Finalmente, repita o script mas desta vez salve o gráfico com imagem png.

###correlacao e correlação de Pearson
  
# A correlação busca quantificar a forma em que duas ou mais variáveis interagem, 
# ou seja procura pela tendência em que a variação conjunta ocorre. Por exemplo, 
# se quando uma variável cresce, uma outra também cresce, podemos dizer que existe 
# uma correlação positiva. No caso de não existir correlação no comportamento das duas, 
# não será encontrado nenhum padrão de relação e as variáveis se dizem de independentes. 

with(est1, plot(DTM.H, DSM.H, ylim=c(-5,5), xlim=c(-5,5)))
title(main="Correlação entre DTM.H e DSM.H")

# Que impressão nos dá o gráfico? existe correlação? se existe de que tipo?
# A forma mais simples de quantificar a correlação é através da função _cor_ do R, ver ?cor.
# Existem diversas formas de calcular a correlação, a mais usada é a chamada de "Pearson", 
# que consiste em dividir a covariância das duas variáveis pelo produto do seu respectivo desvio padrão.

# \rho_{XY} =  \frac{ cov(X,Y)} {\sigma_X \sigma_Y}

cor(DTM.H,DSM.H, use="complete.obs")

# Observe que incluimos o argumento **_use="complete.obs"_** já que existe ausência de valores no 
# conjunto dos dados (NAs)
# 
# Se desejamos ver o **intervalo de confiança** da correlação calculada, usamos a função cor.test 
# (padrão = 95%, ver ?cor.test):
 
cor.test(DTM.H, DSM.H)

# Vamos analisar a correlação das seguintes três variáveis X, Y, Z.

set.seed(123)
par(oma  = c(4,7,4,1),  # parâmetro que estabelece a margem exterior da janela comum
    mar  = c(3,2,2,2),  # parâmetro que estabelece a margem exterior de cada gráfico
    mfrow= c(3,3))      # parâmetro que determina a quantidade e posição dos gráficos

x <- sample(1:30,30) + 
  rnorm(5,sd=2)

y <- -x - 
  rnorm(30,sd=4)

z <- (sample(1:30,30)/2) + 
  rnorm(30,sd=5)

df <- data.frame(x,y,z)
plot(df[,1:3], pch=19)

# O cálculo da correlação é:

cor(df)
cor.test(df$x,df$y)

cor.test(df$x, df$z)

cor.test(df$y, df$z)

# Note que nos testes de confiança, a correlação positiva foi confirmada pelo pequeno valor de p, 
# que fez aceitar a hipótese alternativa H1, enquanto nas duas últimas correlações o valor grande 
# de p (maior a 0.05), fez aceitar a hipótese H0 de que a correlação é igual a zero, ou seja 
# são independentes. 
# 
# Nesses últimos casos observe que o intervalo de 95%, contém o valor zero, indicando fortemente 
# a probabilidade de serem independentes.

###Regressao linear
  
# A regressão, diferente da correlação, procura exprimir a relação entre variáveis por meio de uma equação. 
# É um método estatístico que usamos sempre que temos a variável resposta e as explicativas coomo variáveis 
# numéricas contínuas. O objetivo da regressão é estimar os valores dos parâmetros e os seus erros.

# A mais simples de todas é a equação linear, que representa uma reta e é expressa como:

# y=ax + b + \epsilon

# A equação indica que por cada unidade de x, o valor da variação de y vem dado por a. 
# O valor b é chamado de intercepto da linha com o eixo x e \epsilon é o erro inerente ao 
# processo de coleta das observações.

# Em R a função lm (linear model), calcula a regressão linear entre duas ou mais variáveis. 
# Uma vez achada a relação, é possível fazer alguma previsão de comportamento a futuro das variáveis, 
# em R a função predict nos permite calcular esses novos dados.

# Um exemplo prático: 
# IBGE lanca o produto cartográfico BC250, observou-se que ao longo dos dias a quantidade de 
# descargas do produto vem aumentando significativamente.
# 
# Nosso chefe quer uma previsão de descarga para os próximos 9 dias, já que tem de se preparar 
# para a página não ficar bloqueada por excesso de acessos.
# 
# Solução: vamos criar um modelo simples de comportamento das descargas (_lm_) e fazer uma predição 
# para os próximos 9 dias (predict).

# criação dos dados
descargas <- c(5,7,4,9,11,10,14,17,13,11,18,17,21,21,24,23,28,35,21,27,23)

# vetor de dias
dias <- seq(1:21)

# Calculo da funcao de regressao, descargas por dia
descargas_lm <- lm(descargas ~ dias)
descargas_lm

#### Residuais

# Com os dados fornecidos podemos dizer que nosso modelo é y=1.194 x + 3.967 + \epsilon. 
# Mas quais os erros da nossa linha de regressão calculada? 
# A diferença entre os dados registrados e nosso modelo em cada ponto são os chamados resíduos e  
# são expressos pelo letra grega epsilon, na equação apresentada. 
# Podemos demostrar matematicamente que o somatório de resíduos é 0, os resíduos e seu 
# somatório entram en vários cálculos de parâmetros de qualidade das observações. 
# Vejamos agora eles gráficamente.

par(mfrow=c(1,1))

# calculo do modelo para cada dia observado
pred.dias <- predict(descargas_lm, as.data.frame(dias))

# dados de descargas observados
plot(descargas ~ dias, 
     xlim = c(1, 25), 
     ylim = c(0,40), 
     pch  = 19, 
     cex  = 1.3,
     main=" Residuos da regressão calculada")

# linha de regressão calculada
abline(descargas_lm, 
       lwd = 2, 
       col = "red")

# plotagem das linhas de resíduos
for (i in dias)
  lines (c(dias[i],dias[i]),
         c(descargas[i],pred.dias[i]),
         col = "red", 
         lwd = 2)

# Necessitamos fazer agora a previsão para os próximos 9 dias...

# predicao com a funcao para mais 9 dias
dias_futuro <- data.frame(dias = 22:30)

descargas_pred <- predict(descargas_lm, dias_futuro)

print(" A previsão de descargas é:")

round(descargas_pred,0)

# Vamos fazer um gráfico com as observações e a predição

par(mfrow=c(1,1))
plot(descargas ~ dias, xlim = c(1, 30), ylim=c(0,50), pch=19, cex=1.5)

# os download previstos para os seguintes 9 dias
points(22:30, descargas_pred, col = "red", pch=19, cex=1.5)

# grafico da linha de regressao
abline(descargas_lm, lwd=2, col="blue")
title(main="Descargas previstas da BC250")

# vemos o resumo da regressao
summary.lm(descargas_lm)

# Atente para a quantidade de informação que o summary oferece. Além dos coeficientes 
# da regressão,  os códigos de significancia dos valores calculados e os quantis dos 
# resíduos, temos o valor do R quadrado, que nos informa que a variação nos dados 
# está explicada em 81% pela variável "dias" (também chamado de coeficiente de determinação).
# 
# Note também que temos 19 graus de liberdade na regressão, já que temos dois coeficientes 
# a determinar, ou seja 21-2 (a e b).
# 
# Uma forma mais apurada de analisar nosso modelo é atraves do gráfico dele.

par(mfrow=c(2,2))
plot(descargas_lm)

 

# No primeiro gráfico temos os residuais versus os valores ajustados, o gráfico não pode 
# apresentar tendência ou agrupamentos e deve aparecer distribuído aleatoreamente.
# 
# No segundo gráfico de cima, apresenta-se a distribuição por quantís, vemos que temos 
# alguns valores em ambas pontas que ficam muito fora da linha de quantís teórica, 
# sugerindo dados não normais.
# 
# No terceiro gráfico a informação é semelhante ao primeiro, mas numa escala diferente 
# por se tratar de resíduos padronizados no eixo Y. Seria um problema se os valores se 
# apresentarem crescendo ao longo do eixo X, mas não parece ser o caso.
# 
# No último gráfico se graficam os pontos mais influentes na regressão, vemos que os 
# últimos dias tem a maior importancia e sugerem que no futuro os valores calculados 
# podem deixar de ter credibilidade.
# 
# Esta previsão poderia ser melhorada se incorporassemos os resíduos obtidos, já 
# apresentados num gráfico anterior e que o summary detalhou. 
# 
# Para simplificar, vamos tratar os residuos como de distribuição normal, com media e 
# desvio padrão conhecidos. A média sabemos que deve ser 0, e o desvio padrão dos 
# resíduos está no summary.

# calculo do ruido a introducir na predição
set.seed(123)
epsilon <- rnorm(9, 
                 mean = 0, 
                 sd   = 3.561)

descargas_pred.nova <- descargas_pred + epsilon

# E finalmente podemos graficar os resultados da previsão afinada

plot(descargas ~ dias, 
     xlim = c(1, 30), 
     ylim = c(0,50), 
     pch  = 19, 
     cex  = 1.5)

points(22:30, 
       descargas_pred.nova, 
       col = "red", 
       pch = 19, 
       cex = 1.5)

abline(descargas_lm, 
       lwd = 2, 
       col = "blue")

title(main="Descargas previstas da BC250")
 

# Se vou me preparar para as piores possibilidades é so usar a função max 
# ou summary para ter os valores desejados.

summary(descargas_pred.nova)
 

---
  
  ## Fim da oficina!!
  
  
  
  