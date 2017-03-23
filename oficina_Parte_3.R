# ---
# title: "Introdução a Estatística Básica e R(RStudio) - 3a. Parte"
# author: "Walter Humberto Subiza Pina"
# date: "11 de janeiro de 2017"
# ---
  
  ## Gráficos com a função genérica plot
  

  
#   O objetivo é mostrar como usar a função plot do pacote base
# para fazer plotagens básicas, como gráfico de variáveis, histogramas e boxplot
# 
# Arquivo de dados externo: "dados4.csv" (formato csv2, sem cabeçalho) e "bloco1.csv"
# 
# quando trabalhamos com graficos é uma boa prática salvar os parámetros gráficos que sao padrão
# 

     
pro <- par(no.readonly=TRUE) 
  
# 
# Experimente na janela 3 (console) o seguinte comando R: demo(graphics)
#   Os graficos são úteis?? Vejamos o seguinte exemplo
# 
# Tenho um arquivo com 300 observacoes cuja media esperada é de 2.5, um desvio padrão perto de 1 e 
# uma distribucao esperada  tipo normal. O que podemos analisar?
# Importar dados4.csv, fazer histograma, média e desvio padrão.


 
# importo os dados com read.csv2
dados4 <- read.csv2("dados4.csv", header=T)

# estrutura dos dados e primeiros 6 registros ou linhas...
str(dados4)
head(dados4)

# algumas estatísticas, média, desvio padrão...
mean(dados4$Valor)
sd(dados4$Valor)

# histograma para verificar a normalidade
hist(dados4$Valor, breaks=10)

# analisar resultados, tendência? calcule a mediana
median(dados4$Valor)

# gráfico sequencial, algum valor chama a atenção??
plot(dados4$Valor)

# zoom sobre dados suspeitos
plot(dados4$Valor, xlim=c(146,160), ylim=c(0.9,1.2))
# carregar arquivo selecao.csv (formato 2)
  
### Grafico de barras
# O gráfico de barras não é muito informativo com vetores numericos.


bloco1 <- read.csv2("bloco1.csv")
attach(bloco1)

barplot(H, horiz = F)

# Para dados categoricos oferece mais informação.

conto <- table(Sub.Bloco)
barplot(conto, 
        ylim= c(0,100),
        main="est1", 
        xlab="Estacoes por Sub Blocos")
# horizontal horiz="True"

# Os dados podem ser empilhados, usando uma tabela de dupla entrada, nesse caso, vamos 
# classificar por Bloco e Sub Blocos

conto2 <- table( Sub.Bloco,Bloco)
color <- c("darkslategray1", "darkslategray3", "darkslategray4", "red")

barplot(conto2, 
        ylim = c(0,160),
        col= color,
        main="Estações por Bloco e Sub-Bloco") 

legend("topright", rownames(conto2), fill= color)
 
# Você deve estar-se perguntando como foram escolhidos essas cores especiais, aqui vai a dica...


# > ### DICA PARA ESCOLHER CORES!!!
# >
# > Instale o pacote "colourpicker", carregue-o e execute o comando: colourPicker(numCols = 3), 
# > sendo o numCols =3 a quantidade de cores a escolher, depois abre uma janela adicional para
# > escolher entre muitas opções de cores, quando fechar deve aparecer na console algo como:
# > "navajowhite"  "navajowhite3" "navajowhite4", copie para uma variável e use no script.
# >
  
#     Vamos graficar!!
#    Primeiro uma plotagem simples com alguns controles. Simulamos dados, 300 valores 
# consecutivos e aleatorios entre -5 e +5...veja ?runif


 
set.seed(12345) # semente serve para reprodução de valores iguais em dados aleatórios (ou  seudo...)

x<-1:300

y<-runif(x,-5,5)

# gráfico simples sem nenhum control específico
plot(x,y)

# vamos colocar nomes nos eixos, parametros: xlab e ylab
plot(x, y, 
     xlab="Sequencial", 
     ylab="Valores")

# a cor e o símbolo são simples de mudar com "col" e "pch" 
# veja ?colors e ?pch, palette
plot(x, y, 
     xlab="Sequencial", 
     ylab="Valores", 
     col="red", 
     pch = 25)

# O tamanho do símbolo pode ser mudado com "cex", experimente valores como 2 e 0.5
plot(x, y, 
     xlab="Sequencial", 
     ylab="Valores", 
     col="red", 
     pch = 25, 
     cex=0.5)

# os limites dos eixos podem ser estabelecidos com "xlim" e "ylim"
plot(x, y, 
     xlab="Sequencial", 
     ylab="Valores", 
     col="red", 
     pch = 25, 
     cex=0.5,
     ylim=c(-10,10), 
     xlim=c(0,400))

# O título tambem pode ser adicionado (subtitulo também!!)
plot(x, y, 
     xlab="Sequencial", 
     ylab="Valores", 
     col="red", 
     pch = 25, 
     cex=0.5, 
     ylim=c(-10,10), 
     xlim=c(0,400),
     main = "O meu Titulo principal")

# vamos agora controlar um pouco os eixos...
par(pro) # voltamos aos valores padrão de cada parâmetro

# tamanho dos nomes nos eixos e das etiquetas
par(cex.lab=1.5,cex.axis=1.3)

plot(x, y, 
     xlab="Sequencial",
     ylab="Valores")

# Uma funcao muito útil para ter mais controle dos eixos é  "axis".
# Dentre outras coisas, com ela podemos mudamos os valores das marcas, tipo de linha, 
# tamanho, espacamento das linhas, cor, etc. 
# 
# Vejamos:
#   
#   Uso da função axis

par(pro) # voltamos aos valores padrão..
plot(x,y,
     xaxt="n") # o valor xaxt="n", impede de plotar o eixo x

axis(side= 1,
     at  = c(seq(0, 300, 25))) # plotar os valores no eixo x de x=0 a 300, cada 25

# Podemos determinar etiquetas texto em determinados valores
par(pro)
plot(x,y,
     xaxt="n",
     yaxt="n")

axis(side= 1,
     at  = c(seq(0, 300, 25))) # plotar os valores no eixo x de x=0 a 300, cada 25

axis(side   = 2,
     at     = c(-4,0,4),
     labels = c("Pequeno","Medio","Grande"))

# a função tambem controla a linha e espessura das marcas
par(pro)
plot(x,y,
     xaxt = "n",
     yaxt = "n")

axis(side = 1,
     at   = c(seq(0, 300, 25))) # plotar os valores no eixo x de x=0 a 300, cada 25

axis(side   = 2,
     at     = c(-4,0,4),
     labels = c("Pequeno","Medio","Grande"))

axis(side      = 3,
     at        = c(5,25,75),
     lwd       = 4,
     lwd.ticks = 2,
     col.ticks = "red")

axis(side=3,
     at        = c(150,225,275),
     lwd       = 4,
     lwd.ticks = 2,
     col.ticks = "blue")

abline(v=150)

abline(v=275)

# o se desejar pode tirar toda a borda da plotagem e mostrar apenas os eixos
# note que o R numera os eixos de 1 a 4 em sentido destrogiro a partir da base

plot(x,y,
     bty="n",
     xaxt="n",
     yaxt="n")

axis(side = 3,
     at   = seq(0,300,50),
     lwd  = 3)
axis(side = 4,
     at   = seq(-5,5,2.5),
     lwd  = 3)
  
# 
# 
# Marcas do eixos, ou etiquetas
#   
#   Se tem um controle mais fino através de par ou axis:
#   
#   - valores positivos fazem as marcas estar dentro do gráfico
# 
#   - valores negativos fazem as marcas estar fora do grafico
# 
#   mgp toma tres valores:
#   
#   - o primeiro controla o afastamento entre o gráfico e o eixo do título
# 
#   - o segundo entre o gráfico e o eixo de etiquetas e 
# 
#   - o terceiro entre o gráfico e a linha do eixo,
# 
#   vejamos no seguinte exemplo com mgp=c(1.5,0,0):
 
par(pro)

par(tcl = 0.4,        #tcl controla o tamanho das marcas e a direção
    mgp = c(1.5,0.2,0)) #

plot(x,y) # experimente com 0.5 e 1
  
# segundo termo
par(tcl = -0.4,
    mgp = c(0.5,2,0))
plot(x,y) # experimente com 0.5

# terceiro termo
par(tcl = 0.4,
    mgp = c(0,0.5,2.7))
plot(x,y) # experimente com 0.5
 

# Um outro exemplo com axis

par(pro)
plot(x,y,
     xaxt = "n",
     yaxt = "n",
     xlab = "",
     ylab = "", 
     main = " Meu Titulo")

axis(side     = 1,
     at       = seq(0,300,50),
     tcl      = 0.4,
     lwd.ticks= 3,
     mgp      = c(0,0.5,0))

#usamos mtext porque o eixo foi desabilitado em plot..
mtext(side = 1,         
      text = "Eixo X: sequencial",
      line = 1.5)

axis(side     = 2,
     at       = seq(-5,5,2.5),
     tcl      = 0.3,
     lwd.ticks= 3 ,
     col.ticks= "orange",
     mgp      = c(0,1,1))

mtext(side=2,
      text="Eixo Y: 300 numeros aleatorios",
      line=2.2)
  
# Vejamos o caso quando temos uma area de plotagem com varios gráficos e eixos semelhantes...

par(pro)
par(oma  = c(3,3,3,0),  # parâmetro que estabelece a margem exterior da janela comúm
    mar  = c(3,3,2,2),  # parâmetro que estabelece a margem exterior de cada gráfico
    mfrow= c(2,2))      # parâmetro que determina a quantidade e posição dos gráficos

plot(1,1, ylab="", xlab="", type="n")
plot(2,1, ylab="", xlab="", type="n")
plot(1,2, ylab="", xlab="", type="n")
plot(2,2, ylab="", xlab="", type="n")

mtext(text = "Rótulo comum ao eixo x",
      side = 1,
      line = 0,
      outer= TRUE)

mtext(text ="Rótulo comum ao eixo y",
      side = 2,
      line = 0,
      outer= TRUE)
mtext(text ="Vários gráficos numa janela só",
      side = 3,
      line = 0,
      outer= TRUE,
      cex  = 1.5)
  
# Um outro tipo de gráfico, o histograma
par(pro)
set.seed(123)
# geramos duas amostras normais, com parâmetros diferentes, veja ?rnorm
x <- rnorm(500, 8, 5)
y <- rnorm(500, 0, 2)
plot(x, xlab="Amostra X")

plot(y, xlab="Amostra Y")
 
hist(x, xlab="Amostra X")
  
hist(x,
     breaks = 20, 
     ylim   = c(0,100), 
     xlab   = "Amostra X",
     main   = " Histograma com 20 intervalos")
  
hist(y,
     breaks = 20, 
     ylim   = c(0,100), 
     xlab   = "Amostra Y",
     main   = " Histograma com 20 intervalos")
  
# Geramos uma distribuição normal assimétrica à direita
z <- cbind(x,y)

hist(z, 
     breaks = 20,
     main   = "Histograma de distribuição assimétrica à direita")

abline(v   = mean(z),      # graficamos a media da amostra
       col = "blue", 
       lwd = 2) 

abline(v   = median(z),   # graficamos a mediana da amostra
       col = "red", 
       lwd = 2) 
 
# Distribuição à esquerda

x2 <- rnorm(500,-8, 5)
y2 <- rnorm(500, 0, 2)

z2 <- cbind(x2,y2)

hist(z2, 
     breaks = 20,
     main   = "Histograma de distribuição assimétrica à esquerda")

abline(v   = mean(z2), 
       col = "blue", 
       lwd = 2)

abline(v   = median(z2), 
       col = "red", 
       lwd = 2)
  
### Boxplot
# O boxplot faz a plotagem dos 5 numeros, veja ?boxplot

boxplot(z2)

boxplot(z2, 
        horizontal = T, 
        names      = c("Valor1","Valor2"), 
        range      = 1.5, 
        notch      = T)
  

# Vejamos agora como agrupar por fatores, usamos o arquivo selecao..
# 
# boxplot(formula, data = ...), formula x ~ grupos_

selecao <- read.csv2("selecao.csv", header=FALSE)

boxplot(selecao$V2 ~ selecao$V1, data=selecao)
  
# Vamos arrumar os nomes...

boxplot(selecao$V2 ~ selecao$V1, data=selecao, las=2)
 

# E dar uma cor...automatica..

boxplot(selecao$V2 ~ selecao$V1, data=selecao, las=2, col=rainbow(27))
  

# Rampas de cores que podem ser usadas (dentre outras) : heat.colors(), terrain.colors(), topo.colors() e cm.colors(). 
# 
# O pacote RColorBrewer cria cores ou niveis de cinza através de gray(). 
# 
# Exemp: gray(0:10/15) produz 10 níveis de cinza.
# 
# 
# Finalmente alguns títulos nos eixos, convenientemente colocados para nao atrapalhar
# ver opcoes de plot e par
# 
# e para salvar o gráfico, nada mais simples...


pdf("meu_boxplot.pdf")
par(pro) 
par(tcl=0.4,
    mgp=c(3.5,0.5,0), 
    cex.lab=1.5, 
    mai=c(1,1,0.5,0.5))# primeiro afasta titulo eixo e o segundo afasta campanhas 

boxplot(selecao$V2 ~ selecao$V1, 
        data=selecao, 
        xlab ="Campanhas", 
        ylab ="Metros", 
        las=2, 
        col=rainbow(27))

title(main      = "Meu Boxplot final", 
      cex.main  = 2, 
      font.main = 3)

dev.off()
  
# Esse script executado não produz saída nenhuma, mas grava no diretório de trabalho o gráfico solicitado.
# 
# Pode-se usar também: win.metafile(), png(), jpeg(), bmp(), tiff(), xfig() e postscript()

# FIM DE GRAFICOS 1
