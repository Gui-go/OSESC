

# Libraries ---------------------------------------------------------------

library("shiny")
library("shinydashboard")
library("ggplot2")
library("plotly")
library("DT")
library("tidyverse")
library("forecast")
library("moments")
library("tseries")
library("Quandl")
library("leaflet")


# UI ----------------------------------------------------------------------

ui <- dashboardPage(    
  skin = "blue",
  dashboardHeader(
    title = "OSESC",
    titleWidth = 250
  ),
  

# Sidebar -----------------------------------------------------------------

  dashboardSidebar(
    width = 250,
    sidebarMenu(
      menuItem("Home", tabName = "HOME", icon = icon("asterisk")),
      menuItem("Apresentação", tabName = "AP", icon = icon("star")),
      menuItem("Metodologia", tabName = "MET", icon = icon("cog"),
               menuSubItem("Introdução", tabName = "MET1", icon = icon("check")),
               menuSubItem("Fontes", tabName = "MET2", icon = icon("check")),
               menuSubItem("Stats", tabName = "MET3", icon = icon("check")),
               #menuSubItem("Gráficos", tabName = "MET4", icon = icon("check")),
               menuSubItem("Modelos", tabName = "MET5", icon = icon("check"))),
      menuItem("Análise", tabName = "AN", icon = icon("plus"),
               menuSubItem("Contextualização", tabName = "ANC", icon = icon("check")),
               menuSubItem("Análise Descritiva", tabName = "AND", icon = icon("check")),
               menuSubItem("Análise Indutiva", tabName = "ANI", icon = icon("check"))),
      menuItem("Referências", tabName = "REF", icon = icon("check")),
      menuItem("Sobre", tabName = "SOBRE", icon = icon("paperclip")),
      menuItem("Contatos", tabName = "CTT", icon = icon("send"))
    )
  ),
  

# Body --------------------------------------------------------------------

  dashboardBody(
    tabItems(
      tabItem(
        tabName = "HOME",
        fluidRow(h1(strong("HOME"), align = "center")),
        br(),
        br(),
        br(),
        fluidPage(
          box(width = 12,
              fluidPage(column(7, fluidPage(offset = 6,
                                            br(),
                                            br(),
                                            br(),
                                            tags$cite(h2(strong("All models are wrong, but some are useful."))),
                                            br(),
                                            tags$cite(h2(strong("Todos os modelos estão errados, mas alguns são úteis."))),
                                            br(),
                                            tags$cite(h2(strong("George Edward Pelham Box (1919 - 2013)"))))),
                        column(5, img(src='http://bulletin.imstat.org/wp-content/uploads/42_05-George-E-P-Box.jpg', align = "right"))))
        )
      ),
      tabItem(
        tabName = "AP",
        fluidRow(h1(strong("Apresentação"), align = "center")),
        fluidPage(
          box(width = 12,
              h3("Como a escassez e não amplamente difundida acessibilidade à indicadores conjunturais referentes ao estado de Santa Catarina é algo que aflige qualquer pesquisador e/ou estudante de economia que pretenda se aprofundar na destacada temática socioeconômica Catarinense, apesar de haver bases de dados acerca do estado, é que se viu a oportunidade de criação da plataforma aqui apresentada. A motivação para o desenvolvimento de um ambiente virtual (interativo e dinâmico) que explorasse o comportamento das diferentes e disponíveis séries temporais referentes ao estado Catarinense surgiu com o intuito de ampliar a oportunidade de fundamentação de trabalhos, estudos e análises mais amplas e complexas acerca da economia catarinense, a partir da aplicação automatizada de ferramentas referentes às abordagens quantitativas discutidas em sala de aula nos cursos de economia da Universidade Federal de Santa Catarina (UFSC)."),
              br(),
              h3("O default da página explora apenas as séries temporais referentes à Santa Catarina contidas no Sistema Gerador de Séries Temporais do Banco Central do Brasil - SGS/BCB -, no entanto, também existe a possibilidade de inserir qualquer outra série de interesse do usuário (inclusive referentes a outras Unidades Federativas, por exemplo)."),
              br(),
              h3("Nesta primeira versão a plataforma utiliza ferramentais de análise gráfica e descritiva (como Box-Plots, gráficos de densidade, gráficos de linhas, correlogramas, entre outros) que permitiriam embasar uma análise conjuntural do comportamento passado das séries em questão. Além disso, o ambiente permite realizar a estimação de modelos Box-Jenkins (autoregressivos integrados de médias móveis também em suas formas sazonais – ARIMA e SARIMA), possibilitando assim a consideração do provável comportamento futuro de tais indicadores nas análises e pareceres."),
              br(),
              h3("Portanto, o usuário da plataforma (a princípio tanto estudantes de economia quanto micro e pequenos empresários demandantes de uma estruturação de análise quantitativa básica para construção de seus planejamentos estratégicos) poderia contar com um ambiente amigável, dinâmico e automatizado tanto para acompanhamento/monitoramento de indicadores econômicos do Estado de Santa Catarina, quanto para suas previsões futuras."))
        )
      ),
      tabItem(
        tabName = "MET",
        fluidRow(h1(strong("Metodologia"), align = "center")),
        fluidPage(
          box(width = 12,
              fluidPage(
                h3("box")))
        )
      ),
      tabItem(
        tabName = "MET1",
        fluidRow(h1(strong("Introdução"), align = "center")),
        fluidPage(
          box(width = 12,
              h3("Para o desenvolvimento da presente aplicação, foram utilizados dados, estatatísticas, testes de hipótese, modelos preditivos e medidas de grau de ajuste. Portanto, para elucidar tais elementos, a metodologia da plataforma OSESC foi subdividida em: Fontes, Stats, Gráficos e Modelos. Mais detalhes a seguir:"),
              br(),
              h3(strong("Fontes")),
              br(),
              h3(strong("Stats")),
              br(),
              h3(strong("Gráficos")),
              br(),
              h3(strong("Modelos")),
              br())
        )
      ),
      tabItem(
        tabName = "MET2",
        fluidRow(h1(strong("Fontes"), align = "center")),
        br(),
        br(),
        fluidPage(
          h2(strong("Sistema Gerador de Séries Temporais - SGS")),
          box(
            width = 12,
            h3("O SGS - Sistema Gerenciador de Séries Temporais - tem como objetivo consolidar e disponibilizar informações economico-financeiras de maneira uniforme entre os documentos produzidos com base em séries temporais nele armazenadas. Este sistema é produto do Banco Central do Brasil, contudo não somente séries de sua autoria são armazenadas neste."),
            br(),
            h3("O OSESC se beneficia largamente das séries temporais expostas no SGS, tendo em vista que as análises feitas nesta plataforma terão de usar como base uma das séries temporais mensais do sistema gerenciador de séries temporais, ou qualquer outra série corregada á plataforma. Para explorar uma das séries desejadas, basta inserir o código da série no espaço indicado. Caso o código esteja correto, a série irá carregar automaticamente em poucos segundos."),
            br(),
            h3("Vale notar que, tanto o Banco Central do Brasil quanto o OSESC, não assumem qualquer responsabilidade por defasagem, erro ou qualquer outra deficiência em informações prestadas por estes. Além disso, independente da fonte de origem da série - BCB, DIEESE, BM&BOVESPA, BNDES, Copom, Fiesp, IBGE, ou outros -, para que esta plataforma execute sua performance da maneira como deveria, a série deve ser mensal."),
            br()
          ),
          h2(strong("Sugestões")),
          box(
            width = 12,
            h3("Abaixo encontram-se algumas sugestões de séries para análise:"),
            br(),
            h3("**********************"),
            br(),
            h3(strong("IPCA")),
            h4("Índice nacional de preços ao consumidor-amplo"),
            h4("Código: 433"),
            h4("Unidade padrão: Var. % mensal"),
            h4("Fonte: IBGE"),
            br(),
            h3(strong("INPC")),
            h4("Índice nacional de preços ao consumidor"),
            h4("Código: 188"),
            h4("Unidade padrão: Var. % mensal"),
            h4("Fonte: IBGE"),
            br(),
            h3(strong("ICV")),
            h4("Índice de Custo de Vida"),
            h4("Código: 194"),
            h4("Unidade padrão: Var. % mensal"),
            h4("Fonte: DIEESE"),
            br(),
            h3(strong("Quantidade de ovos produzidas no Brasil")),
            h4("Código: 1310"),
            h4("Unidade padrão: Dúzias (mil)"),
            h4("Fonte: IBGE"),
            br(),
            h3(strong("Produção total de autoveículos no Brasil")),
            h4("Código: 1373"),
            h4("Unidade padrão: Unidades"),
            h4("Fonte: INFAVEA"),
            br(),
            h3(strong("Consumo de derivados do petróleo - Gasolina")),
            h4("Código: 1393"),
            h4("Unidade padrão: Barris/dia (mil)"),
            h4("Fonte: ANP"),
            br(),
            h3(strong("Consumo de energia elétrica - Comercial")),
            h4("Código: 1402"),
            h4("Unidade padrão: GWh"),
            h4("Fonte: Eletrobras"),
            br(),
            h3(strong("Consumo de energia elétrica - Residencial")),
            h4("Código: 1403"),
            h4("Unidade padrão: GWh"),
            h4("Fonte: Eletrobras"),
            br(),
            h3(strong("Consumo de energia elétrica - Industrial")),
            h4("Código: 1404"),
            h4("Unidade padrão: GWh"),
            h4("Fonte: Eletrobras"),
            br(),
            h3(strong("Consumo de energia elétrica - Outros")),
            h4("Código: 1405"),
            h4("Unidade padrão: GWh"),
            h4("Fonte: Eletrobras"),
            br(),
            h3(strong("Consumo de energia elétrica - Total")),
            h4("Código: 1406"),
            h4("Unidade padrão: GWh"),
            h4("Fonte: Eletrobras"),
            br(),
            h3(strong("Indicador de movimento do comércio à prazo")),
            h4("Código: 1454"),
            h4("Unidade padrão: Unidades"),
            h4("Fonte: ACSP"),
            br(),
            h3(strong("Indicador de Movimento de Cheques")),
            h4("Código: 188"),
            h4("Unidade padrão: Unidade"),
            h4("Fonte: ACSP"),
            br(),
            h3(strong("Índice de volume de vendas no varejo - Total - Brasil")),
            h4("Código: 1455"),
            h4("Unidade padrão: Índice"),
            h4("Fonte: IBGE"),
            br(),
            h3(strong("Índice volume de vendas no varejo - Combustíveis e lubrificantes - Brasil")),
            h4("Código: 1483"),
            h4("Unidade padrão: Índice"),
            h4("Fonte: IBGE"),
            br(),
            h3(strong("Índice volume de vendas no varejo - Hiper/supermercado, Prod. alimentícios, bebidas, fumo - Brasil")),
            h4("Código: 1496"),
            h4("Unidade padrão: Índice"),
            h4("Fonte: IBGE"),
            br(),
            h3(strong("Índice volume de vendas no varejo - Tecido, vestuário e calçado - Brasil")),
            h4("Código: 1509"),
            h4("Unidade padrão: Índice"),
            h4("Fonte: IBGE"),
            br(),
            h3(strong("Índice volume de vendas no varejo - Móveis e eletrodomésticos - Brasil")),
            h4("Código: 1522"),
            h4("Unidade padrão: Índice"),
            h4("Fonte: IBGE"),
            br(),
            h3(strong("Índice volume de vendas no varejo - Automóveis, motocicletas, partes e peças - Brasil")),
            h4("Código: 1548"),
            h4("Unidade padrão: Índice"),
            h4("Fonte: IBGE"),
            br(),
            h3(strong("Índice volume de vendas no varejo - Hipermercados e supermercados - Brasil")),
            h4("Código: 1561"),
            h4("Unidade padrão: Índice"),
            h4("Fonte: IBGE"),
            br(),
            h3(strong("Índice de Confiança do Consumidor")),
            h4("Código: 4393"),
            h4("Unidade padrão: Índice"),
            h4("Fonte: Fecomercio"),
            br(),
            h3(strong("Dívida Líquida do Setor Público - Saldos em u.m.c. milhões - Total - Governo Federal")),
            h4("Código: 2054"),
            h4("Unidade padrão: u.m.c. (milhões)"),
            h4("Fonte: BCB-DSTAT"),
            br(),
            h3(strong("Dívida Líquida do Setor Público - Saldos em u.m.c. milhões - Total - Governos estaduais")),
            h4("Código: 2057"),
            h4("Unidade padrão: u.m.c. (milhões)"),
            h4("Fonte: BCB-DSTAT"),
            br(),
            h3(strong("	Dívida Líquida do Setor Público - Saldos em u.m.c. milhões - Total - Governos municipais")),
            h4("Código: 2058"),
            h4("Unidade padrão: u.m.c. (milhões)"),
            h4("Fonte: BCB-DSTAT"),
            br(),
            h3(strong("Dívida Líquida do Setor Público - Saldos em u.m.c. milhões - Total - Empresas estatais")),
            h4("Código: 2059"),
            h4("Unidade padrão: u.m.c. (milhões)"),
            h4("Fonte: BCB-DSTAT"),
            br(),
            h3(strong("Dívida Líquida do Setor Público - Saldos em u.m.c. milhões - Total - Empresas estatais federais")),
            h4("Código: 2060"),
            h4("Unidade padrão: u.m.c. (milhões)"),
            h4("Fonte: BCB-STAT"),
            br(),
            h3(strong("Dívida Líquida do Setor Público - Saldos em u.m.c. milhões - Total - Empresas estatais estaduais")),
            h4("Código: 2061"),
            h4("Unidade padrão: u.m.c. (milhões)"),
            h4("Fonte: BCB-DSTAT"),
            br(),
            h3(strong("Dívida Líquida do Setor Público - Saldos em u.m.c. milhões - Total - Empresas estatais municipais")),
            h4("Código: 2062"),
            h4("Unidade padrão: u.m.c. (milhões)"),
            h4("Fonte: BCB-DSTAT"),
            br(),
            h3(strong("Dívida Líquida do Setor Público - Saldos em u.m.c. milhões - Externa - Governo Federal")),
            h4("Código: 2074"),
            h4("Unidade padrão: u.m.c. (milhões)"),
            h4("Fonte: BCB-DSTAT"),
            br(),
            h3(strong("BM - Papel moeda emitido (média nos dias úteis do mês)")),
            h4("Código: 1783"),
            h4("Unidade padrão: u.m.c. (mil)"),
            h4("Fonte: BCB-DSTAT"),
            br(),
            h3(strong("Taxa de juros - Selic acumulada no mês")),
            h4("Código: 4390"),
            h4("Unidade padrão: % a.m."),
            h4("Fonte: BCB-Demab"),
            br(),
            h3(strong("Taxa de juros - CDI acumulada no mês")),
            h4("Código: 4391"),
            h4("Unidade padrão: % a.m."),
            h4("Fonte: BCB-Demab"),
            br(),
            h3(strong("Taxas de juros - TJLP mensal")),
            h4("Código: 7815"),
            h4("Unidade padrão: % a.m."),
            h4("Fonte: BCB-DSTAT"),
            br(),
            h3(strong("Bovespa - índice mensal")),
            h4("Código: 7845"),
            h4("Unidade padrão: Pontos"),
            h4("Fonte: BM&FBOVESPA"),
            br(),
            h3(strong("Dow Jones NYSE - índice mensal")),
            h4("Código: 7846"),
            h4("Unidade padrão: Pontos"),
            h4("Fonte: Dow Jones"),
            br(),
            h3(strong("Nasdaq - índice mensal")),
            h4("Código: 7847"),
            h4("Unidade padrão: Pontos"),
            h4("Fonte: Nasdaq"),
            br(),
            h3(strong("Exportações - Soja mesmo triturada")),
            h4("Código: 2971"),
            h4("Unidade padrão: US$"),
            h4("Fonte: MDIC/Secex"),
            br(),
            h3(strong("Exportações - Açúcar de cana, em bruto")),
            h4("Código: 2975"),
            h4("Unidade padrão: US$"),
            h4("Fonte: MDIC/Secex"),
            br(),
            h3(strong("Exportações (Fob) - China")),
            h4("Código: 3122"),
            h4("Unidade padrão: US$"),
            h4("Fonte: MDIC/Secex"),
            br(),
            h3(strong("Exportações (Fob) - Venezuela")),
            h4("Código: 3301"),
            h4("Unidade padrão: US$"),
            h4("Fonte: MDIC/Secex"),
            br(),
            h3(strong("Importações (Fob) - China")),
            h4("Código: 3354"),
            h4("Unidade padrão: US$"),
            h4("Fonte: MDIC/Secex"),
            br(),
            h3(strong("Importações (Fob) - Venezuela")),
            h4("Código: 3533"),
            h4("Unidade padrão: US$"),
            h4("Fonte: MDIC/Secex"),
            br(),
            h3(strong("Exportações (Kg) - Soja mesmo triturada")),
            h4("Código: 4218"),
            h4("Unidade padrão: Kg"),
            h4("Fonte: MDIC/Secex"),
            br(),
            h3(strong("	Exportações (Kg) - Açúcar de cana, em bruto")),
            h4("Código: 4222"),
            h4("Unidade padrão: Kg"),
            h4("Fonte: MDIC/Secex"),
            br(),
            h3("Para acessar mais séries, basta consultar código no ",tags$a("SGS - Sistema Gerador de Séries Temporais - ", href = "https://www3.bcb.gov.br/sgspub/localizarseries/localizarSeries.do?method=prepararTelaLocalizarSeries", target="_blank"), " do Banco Central.")
          ),
          box(
            width = 12,
            h3(strong("Séries Externas")),
            br(),
            h4("Para introduzir séries externas ao SGS do Banco Central, basta carregar o arquivo no espaço indicado na aba 'Análise'. Todavia, deve-se atentar ao formato do arquivo: Ele deve estar no formato csv; a primeira coluna deve composta por datas, como:", strong("%Y-%m-%d"),", de modo crescente; já a segunda coluna, deve ser composta pelos dados da série, sendo os decimais separados por ponto (.). Exemplo: ")
            ,
            br(),
            h4("...Datas... - ...Dados..."),
            h4("2008-01-31  -  1993.13"),
            h4("2008-02-28  -  19874.67"),
            h4("2008-03-30  -  1434.54"),
            h4("2008-04-30  -  2018.13"),
            h4("2008-05-30  -  1434.33"),
            h4("2008-06-30  -  1874.73")
          )
        )
      ),
      

# STATS  MET --------------------------------------------------------------

      tabItem(
        tabName = "MET3",
        fluidRow(h1(strong("Stats"), align = "center")),
        fluidPage(
          h2(strong("Descrição das estatísticas, testes de hipótese, parâmetros e medidas de grau de ajuste")),
          box(
            width = 12,
            withMathJax(),
            h3("Apesar da relevância de todas as informações apresentadas nesta plataforma, algumas são tão triviais que acabaram por ser omitidas da descrição a seguir. Contudo, há outras que não são tão triviais assim e merecem melhor explanação, como as a seguir:"),
            br(),
            h3(strong("Variância")),
            h3("Variância de um conjunto de dados que se comporta de modo aleatório, ou que segue um processo estocástico, é uma medida de dispersão estatística, indicando quão distantes seus elementos são do valor esperado, ou média. Há dois tipos de variância: A variância populacional (\\(\\sigma^2\\)); e a variância amostral (\\(s^2\\))."),
            h3("Vale notar que a variância é o quadrado do desvio padrão. Segue as fórmulas abaixo:"),
            br(),
            h2("$$\\sigma^2=\\frac{1}{N}\\times\\sum_{i=1}^{N}(x_{i}-\\mu)^{2}$$"),
            h2("$$s^2=\\frac{1}{n-1}\\times\\sum_{i=1}^{n}(x_{i}-\\bar{x})^{2}$$"),
            br(),
            h3(strong("Desvio Padrão")),
            h3("Desvio padrão, assim como a variância, é extremamente útil para mensurar o grau de variabilidade de um conjunto de dados. No caso do desvio padrão, caso estejamos trabalhando com uma distribuição normal, cerca de 68% dos dados se encontram a \\(\\pm\\)1 d.p. da média; 95% dos dados se encontram a \\(\\pm\\)2 d.p. da média; e 99% dos dados se encontram a \\(\\pm\\)3 d.p. da média. Por esse motivo, torna-se muito mais fácil se trabalhar com distribuições normais do que com as demais. Na prática, porém, dificilmente encontraremos distribuições perfeitamente normais. As fórmulas para o desvio padrão populacional (\\(\\sigma\\)) e desvio padrão amostral (\\(s\\)) seguem abaixo: ???Colocar imagem???"),
            br(),
            h2("$$\\sigma = \\sqrt{\\frac{1}{N}\\times\\sum_{i=1}^{N}(x_{i}-\\mu)^{2}}$$"),
            h2("$$s=\\sqrt{\\frac{1}{n-1}\\times\\sum_{i=1}^{n}(x_{i}-\\bar{x})^{2}}$$"),
            br(),
            h3(strong("Assimetria")),
            h3("Uma distribuição simétrica deve possuir \\(\\bar{x} = Me = Mo\\). Uma distribuição assimétrica, porém, possui certo grau de afastamento entre esses valores, deixando a distribuição assimétrica para a direita ou para a esquerda. Há diversas maneiras de se mensurar o grau de assimetria, contudo, escolhemos, para ilustrar este, o ?primeiro coeficiente de pearson?. Esse conceito é melhor internalizado a partir de exemplos, como os a seguir:"),
            br(),
            h2("$$b_{1}=\\frac{1}{n}\\sum\\left[\\frac{x_{i}-\\bar{x}}{s}\\right]^3$$"),
            br(),
            h3(strong("Curtose")),
            h3("Curtose é uma medida de dispersão que se caracteriza pelo grau de achatamento da curva da função de distribuição. Há diversos coeficientes que pretendem quantificar este achatamento, contudo, para ilustrar este, optamos pelo ?coeficiente tal?, onde, podemos considerar uma distribuição com \\(b_2>0\\) como leptocúrtica; \\(b_2=0\\) como mesocúrtica; e \\(b_2<0\\) como platicúrtica. Confira na ???ilustração??? abaixo:"),
            br(),
            h2("$$b_{2}=\\frac{1}{n}\\sum\\left[\\frac{x_{i}-\\bar{x}}{s}\\right]^4-3$$")
          ),
          br(),
          h2(strong("Testes de hipótese")),
          box(
            width = 12,
            h3(strong("Teste de Bera jarque")),
            h3("Um dos testes de normalidade mais utilizados em estatística e econometria é o teste Bera-Jarque. Este teste foi nomeado a partir do nome de seus autores: Carlos Jarque e Anil K. Bera. Apoiado nos coeficientes de Assimetria e Curtose, o teste BJ tem como hipótese nula a normalidade, portanto, com um p-valor pequeno - digamos, p-valor < 0.10 -, podemos rejeitar a hipótese de normalidade. Já, caso o p-valor seja grande, aceita-se a hipótese de normalidade."),
            br(),
            h3(strong("Teste de Shapiro-Wilk")),
            h3("O teste Shapiro-Wilk, assim como o teste Bera-Jarque, é um teste de normalidade. Este foi publicado por Samuel Sanford Shapiro e Martin Wilk em 1965. O teste SW tem hipótese nula de que o conjunto de dados é normalmente distribuído, portanto, caso o p-valor seja pequeno - digamos, p-valor < 0.10 -, rejeitamos a hipótese nula de que o conjunto de dados segue uma distribuição normal. Por outro lado, caso o p-valor seja grande, aceitamos a hipótese nula de que o conjunto de dados segue uma distribuição normal."),
            br(),
            h3(strong("Teste Dickey-Fuller aumentado")),
            h3("O Teste Dickey-Fuller Aumentado, popularmente conhecido como Teste ADF (Augmented Dickey-Fuller Test), é um teste de raíz unitária na série, ou seja, de maneira resumida, se a série é ou não estacionária. O nome deste teste foi dado em homenagem à David A. Dickey e Wayne Fuller, que o desenvolveram em 1979. No teste ADF, a hipótese nula é de que a série possui raíz unitária, e hipótese alternativa de que a série não possui raiz unitária. Portanto, caso o p-valor seja pequeno - digamos, p-valor < 0.10 -, rejeitamos a hipótese nula de que haja raiz unitária na série  e podemos considerar a série estacionária; Na outra mão, caso o p-valor seja grande, aceitamos a hipótese nula de que haja raiz unitária, logo, a série pode ser considerada não-estacionária."),
            br(),
            h3(strong("Teste de Ljung-Box")),
            h3("Como de costume, em homenagem a seus desenvolvedores, Greta M. Ljung e George E. P. Box, o teste Ljung-Box é um tipo de teste estatístico para verificar-se se um grupo de autocorrelações em uma série temporal é diferente de zero ou não. Ao invés de se checar a autocorrelação em algum lag específico, o teste Ljung-Box observa a autocorrelação de modo mais abrangente, baseado em um número n de lags. Por esse motivo, o teste Ljung-Box também é, devido a seu uso e metodologia, um teste portmanteau. Por conseguinte, neste teste de hipótese, a hipótese nula é de que os dados sejam independentemente distribuídos (por exemplo, ruído branco); e, na outra mão, a hipótese alternativa é de que os dados não sejam independemente distribuídos, em outras palavras, eles apresentam autocorrelação."),
            br()
          ),
          h2(strong("Medidas de grau de ajuste")),
          box(
            width = 12,
            h3(strong("RMSE - Root Mean Squared Error")),
            h3("A Raiz do Erro Quadrático Médio é uma medida de precisão do modelo, devendo ser utilizada para comparar modelos diferentes mas com o mesmo espaço amostral. A utilização do \\(RMSE\\) é interessante pois condensa os diversos erros do modelo (\\(\\hat{Y}_i - Y_i \\)) em somente um valor."),
            h2("$$RMSE=\\sqrt{\\frac{\\sum^{n}_{i=1}(\\hat{y}_i-y_i)^2}{n}}$$"),
            br(),
            h3(strong("AIC - Akaike Information Criterion")),
            h3("O Critério Akaike de Informação - \\(AIC\\) - é um estimador de qualidade de modelo estatístico, para dado conjunto de dados. Portanto, o \\(AIC\\) é um método de seleção para modelos preditivos paramétricos. Dado um conjunto de modelos, a partir da mesma amostra, aquele que possuir o menor \\(AIC\\), teoricamente, é o melhor modelo. O \\(AIC\\), ademais, foi nomeado em homenagem ao estatístico Hirotugu Akaike, quem o formulou, a partir da teoria da informação."),
            h3("O \\(AIC\\) estima a quantidade relativa de informação perdida por dado modelo: quanto menos informação o modelo perde melhor a qualidade do modelo:"),
            h2("$$AIC=2k-2\\ln(\\hat{L})$$"),
            h3("onde \\(k \\)  é o número de parâmetros estimados e \\(\\hat{L}\\) é o valor maximizado da função de verossimilhança, para dado modelo."),
            h3("Vale também notar que o modelo desencoraja a utilização de muitos parâmetros, pois, geralmente, quanto menor o número de parâmetros menor, também, o valor do \\(AIC\\). Além disso, deve-se ter claro que o \\(AIC\\) não se trata da qualidade absoluta do modelo, mas, sim, da qualidade relativa a outro modelos, utilizando o mesmo espaço amostral."),
            br(),
            #h3(strong("AICc")),
            #h3("Em breve"),
            br(),
            h3(strong("BIC - Bayesian
                                  Information Criterion")),
            h3("O Critério Bayesiano de Informação - \\(BIC\\) -  é um estimador de qualidade de modelo estatístico, para dado conjunto de dados. Portanto, o \\(BIC\\) é um critério de seleção entre dois ou mais modelos, pois, dado um conjunto de modelos, a partir da mesma amostra, aquele que possuir o menor \\(BIC\\), teoricamente, é o melhor modelo. O \\(BIC\\), ademais, também é conhecido como \\(SIC\\) - Schwarz-Bayesian Information Criteria -, nome dado em homenagem ao seu criador, Gideon E. Schwarz."),
            h3("O \\(BIC\\) é baseado, em partes, na função de verossimilhança e se aproxima consideravelmente ao \\(AIC\\):"),
            h2("$$BIC=\\ln(n)k-2\\ln(\\hat{L})$$"),
            h3("onde \\(n\\) é o número de observações da amostra, \\(k \\)  é o número de parâmetros estimados pelo modelo, e \\(\\hat{L}\\) é o valor maximizado da função de verossimilhança, para dado modelo. Assim como acontece com o \\(AIC\\), deve-se ter claro que estes valores não se tratam da qualidade absoluta do modelo, mas, sim, da qualidade relativa a outros modelos, utilizando o mesmo espaço amostral."),
            br(),
            #h3(strong("Log likelihood")),
            #h3("Em breve"),
            br()
          )
        )
      ),

# GRAPHS MET --------------------------------------------------------------

      tabItem(
        tabName = "MET4",
        fluidRow(h1(strong("Gráficos"), align = "center")),
        fluidPage(
          box(width = 12,
              fluidPage(
                h3("Em breve")))
        )
      ),

# MET   MODELOS -----------------------------------------------------------

      tabItem(
        tabName = "MET5",
        fluidRow(h1(strong("Modelos"), align = "center")),
        fluidPage(
          h2(strong("Descrição do modelo ARIMA")),
          box(
            width = 12,
            withMathJax(),
            h3("Em estatística e econometria, um dos modelos univariados mais robustos para a análise de séries temporais é o modelo auto-regressivo integrado de médias móveis com sazonalidade, o SARIMA", em("(Seasonal Auto-Regressive Integrated Moving Average)"), ". Além de ser bastante preciso na predição de valores futuros, a utilização de seus componentes pode ser, também, bastante útil para entender o comportamento da série em análise. O cerne desta metodologia, contudo, é o modelo ARIMA, também conhecido como método de Box-Jenkins, nome dado em homenagem aos estatísticos George Box e Gwilym Jenkins."),
            br(),
            h3("Geralmente, o modelo SARIMA é representado como \\(SARIMA(p,d,q)(P,D,Q)m\\), em que os parâmetros \\((p,d,q)\\) representam os componentes não-sazonais, \\((P,D,Q)\\) os componentes sazonais, e \\(m\\) representa o número de períodos em cada temporada da série temporal; ou, mais especificamente, \\(p\\) representa a ordem do modelo autoregressivo, \\(d\\) representa o grau de diferenciação, e \\(q\\) representa a ordem do modelo de média móvel, da parte não sazonal do modelo SARIMA; e, ademais, \\(P\\), \\(D\\) e \\(Q\\) referem-se aos parâmetros do modelo de auto regressão, diferenciação e média móvel da parte sazonal, ou seja, de períodos regressados \\(m\\) vezes."),
            br(),
            h3("Naturalmente, o modelo SARIMA pode ser dividido e utilizado em fragmentos, pois se trata de uma combinação de diferentes metodologias aplicadas a um modelo só, como, por exemplo: ARIMA; ARMA, MA, I e AR. Cada um tendo suas particularidades e sendo recomendado para tipos de séries específicas. Nem sempre o modelo SARIMA será o mais adequado para a predição de determinada série, numa série temporal estacionária e sem sazonalidade, por exemplo, poderia ser recomendado um modelo ARMA. Todavia, a seguir veremos com mais detalhes estas particularidades para que possamos aplicar o modelo ideal para a série em análise.")
          ),
          h2(strong("Parâmetros")),
          box(
            width = 12,
            withMathJax(),
            h3(strong("AR(p)")),
            br(),
            h3("Digamos que \\(Y_t\\) represente o período presente de uma série. Se modelarmos \\(Y_t\\) como:"),
            h2("$$(Y_t-\\delta)=\\alpha_1(Y_{t-1}-\\delta )+u_t$$"),
            h3("onde \\(\\delta\\) representa a média de \\(Y\\) e onde \\(u_t\\) é um termo de erro aleatório não correlacionado com média zero e variância constante (ruído branco), então podemos dizer que \\(Y_t\\) segue um modelo auto-regressivo de primeira ordem, ou \\(AR(1)\\). Portanto, o valor de \\(Y\\) no tempo \\(t\\) depende de uma proporção de \\(Y_{t-1}\\) e do termo aleatório; os valores de \\(Y\\) são expressos na forma de desvios da média. Em outras palavras, este modelo diz que a previsão de valores de \\(Y\\) em \\(t\\) é simplesmente uma proporção \\((=\\alpha_1)\\) de seu valor em \\(t_{-1}\\) mais um choque aleatório no tempo \\(t\\); vale enfatizar, expressos em torno da média."),
            h3("Caso consideremos um modelo auto regressivo de segunda ordem, \\(AR(2)\\), então:"),
            h2("$$(Y_t-\\delta)=\\alpha_1(Y_{t-1}-\\delta)+\\alpha_2(Y_{t-2}-\\delta)+u_t$$"),
            h3("Note que agora, com um modelo que segue um processo auto regressivo de segunda ordem, ou \\(AR(2)\\), o valor de \\(Y\\) no tempo \\(t\\) depende de seus valores em dois períodos prévios; e novamente o valor de \\(Y\\) sendo expresso em torno da média \\((\\delta)\\)."),
            h3("Pra finalizar, caso o modelo auto regressivo siga ordem \\(p\\), ou \\(AR(p)\\), podemos expressar o modelo da seguinte forma:"),
            h2("$$(Y_t-\\delta)=\\alpha_1(Y_{t-1}-\\delta)+\\alpha_2(Y_{t-2}-\\delta)+...+\\alpha_p(Y_{t-p}-\\delta)+u_t$$"),
            h3("ou"),
            h2("$$Y_t=\\delta+\\sum^{p}_{i=1}\\alpha_iY_{t-i}+u_t$$"),
            h3("Vale notar que em todos estes casos foram utilizados somente valores de \\(Y\\), não houveram outros regressores. Nesse sentido, podemos dizer que “os dados falam por si só”.")
          ),
          box(
            width = 12,
            h3(strong("I(d)")),
            br(),
            h3("A parte integrada do modelo, diferentemente dos parâmetros \\(p\\) e \\(q\\), somente é utilizada quando há presença de raíz unitária na série; ou seja, quando se é detectado a presença de tendência na série, se faz necessário diferenciar a série quantas vezes forem necessárias, até que a série apresente sinais estacionariedade. Contudo, na prática, a série é diferenciada no máximo duas vezes para se tornar estacionária."),
            h3("Para averiguar se a série apresenta tendência é possível recorrer aos gráficos, como: Gráfico de linhas, gráfico de autocorrelação e autocorrelação parcial, entre outros. No entanto, o mais indicado seria realizar o teste de raíz unitária de Dickey-Fuller para sanar qualquer dúvida, e para dar mais cientificidade ao processo.")
          ),
          box(
            width = 12,
            h3(strong("MA(q)")),
            br(),
            h3("Digamos que \\(Y_t\\) represente o período presente de uma série. Se modelarmos \\(Y_t\\) como:"),
            h2("$$Y_t=\\mu+\\beta_0u_t+\\beta_1u_{t-1}$$"),
            h3("onde \\(\\mu\\) representa uma constante, \\(\\beta\\) representa uma proporção para a média móvel e \\(u\\) é um termo de erro aleatório não correlacionado com média zero e variância constante (ruído branco). Neste, \\(Y\\) no tempo \\(t\\) é igual a constante mais a média móvel, com proporção = \\(\\beta\\), dos erros em \\(t\\) e \\(t-1\\). Sendo assim, este primeiro exemplo segue um modelo \\(MA\\) de primeira ordem."),
            h3("Caso consideremos um modelo de média móvel de segunda ordem, \\(MA(2)\\), então:"),
            h2("$$Y_t=\\mu+\\beta_0u_t+\\beta_1u{t-1}+\\beta_2u_{t-2}$$"),
            h3("Note que agora, analisando um modelo \\(MA(2)\\), o valor de \\(Y_t\\) depende da constante \\(\\mu\\) mais a média dos três termos de erro (\\(t\\),  \\(t-1\\)  e  \\(t-2\\))."),
            h3("Pra finalizar, caso o modelo de média móvel siga ordem \\(p\\), ou \\(MA(q)\\), podemos expressar o modelo da seguinte forma:"),
            h2("$$Y_t=\\mu+\\beta_0u_t+\\beta_1u_{t-1}+...+\\beta_qu_{t-q}$$")
          )
        )
      ),

# Análise Conjuntura SC ---------------------------------------------------

      tabItem(
        tabName = "AN",
        fluidRow(h1(strong("Conjuntura"), align = "center")),
        fluidPage(
          box(width = 12,
              fluidPage(
                h3("box")))
        )
      ),

# Contexto da conjuntura --------------------------------------------------

      tabItem(
        tabName = "ANC",
        fluidRow(h1(strong("Introdução"), align = "center")),
        fluidPage(
          box(width = 12,
              fluidPage(
                h3("A aba presente, “Análise”, é o cerne desta aplicação. Na sub aba seguinte, “Análise Descritiva”, o usuário terá acesso a meios para se realizar uma análise descritiva das séries temporais abordadas através da plataforma OSESC, seja ela uma série referente à Santa Catarina, uma série do Sistema Gerador de Séries Temporais do Banco Central do Brasil, ou alguma série externa carregada pelo usuário."),
                br(),
                h3("Após feita a análise descritiva, o usuário poderá partir para a “análise indutiva”, onde terá meios para prever valores em períodos futuros através do modelo ARIMA. Fique atento a seleção correta da série, no tamanho da amostra e nos parâmetros. Na aba “análise indutiva” haverá meios para que o usuário selecione os parâmetros do modelo ARIMA a que lhe pareçam fazer mais sentido, no entanto, extremamente difícil é a escolha dos mesmos. Sendo assim, há a possibilidade de seleção automática do modelo através da função auto.arima(). Dessa maneira, o usuário encontrará a série que possui a menor medida de grau de ajuste e, teoricamente, o melhor modelo não viesado.")))
        )
      ),

# Análise Descritiva SC ---------------------------------------------------

      tabItem(
        tabName = "AND",
        fluidRow(h1(strong("Análise Descritiva"), align = "center")),
        fluidRow(
          box(
            title = tagList(shiny::icon("gear"), strong("Controles")),
            solidHeader = T,
            width = 4,
            height = "100%",
            status = "primary",
            selectInput(
              inputId = "FONTAND",
              label = "Fonte da série:",
              choices = c("BCB/SC", "BCB", "Externa"),
              selected = "BCB/SC"
            ),
            conditionalPanel(condition = "input.FONTAND == 'BCB/SC'",
                             selectInput(
                               inputId = "SBCBSCAD",
                               label = "Série:",
                               choices = c("Empregos formais gerados - 12625" = 12625,
                                           "Nível do emprego formal - 12622" = 12622,
                                           "Índice de volume de vendas no varejo - Total - 1477" = 1477,
                                           "Índice de volume de vendas no varejo - Combustíveis e lubrificantes - 1492" = 1492,
                                           "Índice de volume de vendas no varejo - Hiper/supermercados, Prod. alimentícios, bebidas, fumo - 1505" = 1505,
                                           "Índice de volume de vendas no varejo - Tecidos, vestuário e calçados - 1518" = 1518,
                                           "Índice de volume de vendas no varejo - Móveis e eletrodomésticos - 1531" = 1531,
                                           "Índice de volume de vendas no varejo - Automóveis, motocicletas, partes e peças - 1557" = 1557,
                                           "Índice de volume de vendas no varejo - Hipermercados e supermercados - 1570" = 1570,
                                           "Índice de volume de vendas no varejo - Ampliado - 20199" = 20199,
                                           "Índice de volume de vendas no varejo - Artigos farmacêuticos, médicos, ortopédicos, de perfumaria e cosméticos - 20200" = 20200,
                                           "Índice de volume de vendas no varejo - Livros, jornais, revistas e papelaria - 20201" = 20201,
                                           "Índice de volume de vendas no varejo - Equipamentos e materiais para escritório, informática e comunicação - 20202" = 20202,
                                           "Índice de volume de vendas no varejo - Outros artigos de uso pessoal e doméstico - 20203" = 20203,
                                           "Índice de volume de vendas no varejo - Material de construção - 20204" = 20204,
                                           "Exportação de bens - 13081" = 13081,
                                           "Importação de bens - 13082" = 13082,
                                           "Saldo da balança comercial - 13083" = 13083,
                                           "Receita dos estados e municípios (Fluxos) - Arrecadação de ICMS - 4348" = 4348,
                                           "Receita dos estados e municípios (Fluxos) - Transferências da União - 4375" = 4375,
                                           "Arrecadação de ICMS (Fluxos) - Setor primário - 7646" = 7646,
                                           "Arrecadação de ICMS (Fluxos) - Setor terciário - 7668" = 7668,
                                           "Arrecadação de ICMS (Fluxos) - Energia - 7679" = 7679,
                                           "Arrecadação de ICMS (Fluxos) - Petróleo - 7690" = 7690,
                                           "Arrecadação de ICMS (Fluxos) - Outras fontes - 7701" = 7701,
                                           "Saldo das operações de crédito do Sistema Financeiro Nacional - Pessoas físicas - 14025" = 14025,
                                           "Saldo das operações de crédito do Sistema Financeiro Nacional - Pessoas jurídicas - 14052" = 14052,
                                           "Saldo das operações de crédito do Sistema Financeiro Nacional - Total - 14079" = 14079,
                                           "Taxa de inadimplência das operações de crédito do Sistema Financeiro Nacional - Pessoas físicas - 15884" = 15884,
                                           "Taxa de inadimplência das operações de crédito do Sistema Financeiro Nacional - Pessoas jurídicas - 15916" = 15916,
                                           "Taxa de inadimplência das operações de crédito do Sistema Financeiro Nacional - Total - 15948" = 15948
                               ),
                               selected = "Empregos formais gerados - 12625"
                             )),
            conditionalPanel(condition = "input.FONTAND == 'BCB'",
                             numericInput(
                               inputId = "CODSADBC",
                               label = "Série:",
                               value = 433,
                               min = 1,
                               max = 999999
                             )),
            conditionalPanel(condition = "input.FONTAND == 'Externa'",
                             fileInput("EXTFILEAD", "Adicione arquivo .csv",
                                       multiple = TRUE,
                                       accept = c("text/csv",
                                                  "text/comma-separated-values,text/plain",
                                                  ".csv"))
            ),
            selectInput("MARKAD", "Marcadores:",
                        multiple = T,
                        selectize = T,
                        c("Média" = "m1",
                          "Mediana" = "m2"),
                        selected = c("m1", "m2")),
            selectInput(
              inputId = "SISAD",
              "Índice sazonal:",
              c("Aditivo" = "additive", "Multiplicativo" = "multiplicative"),
              selected = "Multiplicativo"),
            numericInput(
              inputId = "DIFSAD",
              label = "Número de diferenciações na série:",
              value = 0,
              min = 0,
              max = 2
            ),
            sliderInput(
              inputId = "SLDAD",
              label = "Período da série:",
              value = c(1, 120), min = 1 , max = 500, step = 1
            ),
            box(
              column(2),
              width = 12,
              tableOutput("PIFAD")
            )
          ),
          tabBox(
            id = "GRAFAD",
            title = strong("Análise gráfica"),
            width = 8,
            side = "right",
            height = "673px",
            tabsetPanel(
              tabPanel(
                "Linha",
                plotlyOutput("GLAD", height = "530px")),
              tabPanel(
                "Linhas",
                plotlyOutput("LINS", height = "530px")),
              tabPanel(
                "SubSerie",
                plotlyOutput("SUBS", height = "530px")),
              tabPanel(
                "Box-Plot",
                plotlyOutput("BPAD", height = "530px")),
              tabPanel(
                "Violino",
                plotlyOutput("BPVAD", height = "530px")),
              tabPanel(
                "Densidade",
                plotlyOutput("DENSAD", height = "530px")),
              tabPanel(
                "Decomposição",
                plotlyOutput("DCAD", height = "530px")),
              tabPanel(
                "ACF",
                plotlyOutput("ACFAD", height = "530px")),
              tabPanel(
                "PACF",
                plotlyOutput("PACFAD", height = "530px")),
              tabPanel(
                "Tabela",
                dataTableOutput("TABLEAD"))
            )
          )
        ),
        fluidRow(
          box(
            title = strong("Sumário"),
            align="center",
            solidHeader = T,
            status = "primary",
            width = 4,
            verbatimTextOutput("STATSAD")
          ),
          box(
            title = strong("Complemento"),
            solidHeader = T,
            status = "primary",
            width = 8,
            "..."
          )
        )
      ),

# Análise Indutiva --------------------------------------------------------

      tabItem(
        tabName = "ANI",
        fluidRow(h1(strong("Análise Indutiva"), align = "center")),
        fluidRow(
          box(
            title = tagList(shiny::icon("gear"), strong("Controles")),
            solidHeader = T,
            width = 4,
            height = "700px",
            status = "primary",
            selectInput(
              inputId = "FONTANI",
              label = "Fonte da série:",
              choices = c("BCB/SC", "BCB", "Externa"),
              selected = "BCB/SC"
            ),
            conditionalPanel(condition = "input.FONTANI == 'BCB/SC'",
                             selectInput(
                               inputId = "SBCBSCAI",
                               label = "Série:",
                               choices = c("Empregos formais gerados - 12625" = 12625,
                                           "Nível do emprego formal - 12622" = 12622,
                                           "Índice de volume de vendas no varejo - Total - 1477" = 1477,
                                           "Índice de volume de vendas no varejo - Combustíveis e lubrificantes - 1492" = 1492,
                                           "Índice de volume de vendas no varejo - Hiper/supermercados, Prod. alimentícios, bebidas, fumo - 1505" = 1505,
                                           "Índice de volume de vendas no varejo - Tecidos, vestuário e calçados - 1518" = 1518,
                                           "Índice de volume de vendas no varejo - Móveis e eletrodomésticos - 1531" = 1531,
                                           "Índice de volume de vendas no varejo - Automóveis, motocicletas, partes e peças - 1557" = 1557,
                                           "Índice de volume de vendas no varejo - Hipermercados e supermercados - 1570" = 1570,
                                           "Índice de volume de vendas no varejo - Ampliado - 20199" = 20199,
                                           "Índice de volume de vendas no varejo - Artigos farmacêuticos, médicos, ortopédicos, de perfumaria e cosméticos - 20200" = 20200,
                                           "Índice de volume de vendas no varejo - Livros, jornais, revistas e papelaria - 20201" = 20201,
                                           "Índice de volume de vendas no varejo - Equipamentos e materiais para escritório, informática e comunicação - 20202" = 20202,
                                           "Índice de volume de vendas no varejo - Outros artigos de uso pessoal e doméstico - 20203" = 20203,
                                           "Índice de volume de vendas no varejo - Material de construção - 20204" = 20204,
                                           "Exportação de bens - 13081" = 13081,
                                           "Importação de bens - 13082" = 13082,
                                           "Saldo da balança comercial - 13083" = 13083,
                                           "Receita dos estados e municípios (Fluxos) - Arrecadação de ICMS - 4348" = 4348,
                                           "Receita dos estados e municípios (Fluxos) - Transferências da União - 4375" = 4375,
                                           "Arrecadação de ICMS (Fluxos) - Setor primário - 7646" = 7646,
                                           "Arrecadação de ICMS (Fluxos) - Setor terciário - 7668" = 7668,
                                           "Arrecadação de ICMS (Fluxos) - Energia - 7679" = 7679,
                                           "Arrecadação de ICMS (Fluxos) - Petróleo - 7690" = 7690,
                                           "Arrecadação de ICMS (Fluxos) - Outras fontes - 7701" = 7701,
                                           "Saldo das operações de crédito do Sistema Financeiro Nacional - Pessoas físicas - 14025" = 14025,
                                           "Saldo das operações de crédito do Sistema Financeiro Nacional - Pessoas jurídicas - 14052" = 14052,
                                           "Saldo das operações de crédito do Sistema Financeiro Nacional - Total - 14079" = 14079,
                                           "Taxa de inadimplência das operações de crédito do Sistema Financeiro Nacional - Pessoas físicas - 15884" = 15884,
                                           "Taxa de inadimplência das operações de crédito do Sistema Financeiro Nacional - Pessoas jurídicas - 15916" = 15916,
                                           "Taxa de inadimplência das operações de crédito do Sistema Financeiro Nacional - Total - 15948" = 15948
                               ),
                               selected = "Empregos formais gerados - 12625"
                             )),
            conditionalPanel(condition = "input.FONTANI == 'BCB'",
                             numericInput(
                               inputId = "CODSAI",
                               label = "Série:",
                               value = 433,
                               min = 1,
                               max = 999999
                             )),
            conditionalPanel(condition = "input.FONTANI == 'Externa'",
                             fileInput("EXTFILEAI", "Adicione arquivo .csv",
                                       multiple = TRUE,
                                       accept = c("text/csv",
                                                  "text/comma-separated-values,text/plain",
                                                  ".csv"))
            ),
            selectInput("MARKAI", "Marcadores:",
                        multiple = T,
                        selectize = T,
                        c("Média" = "m1",
                          "Mediana" = "m2"),
                        selected = c("m1", "m2")),
            br(),
            column(3, numericInput("Ninput1", "AR(p):",
                                   min = 0, max = 20, value = 0, step = 1)),
            column(3, numericInput("Ninput2", "I(d):",
                                   min = 0, max = 2, value = 0, step = 1)),
            column(3, numericInput("Ninput3", "MA(q):",
                                   min = 0, max = 300, value = 0, step = 1)),
            column(3, numericInput("AMP", "Amplitude:",
                                   min = 0, max = 36, value = 6, step = 1)),
            br(),
            column(3, numericInput("SNinput1", "AR(P):",
                                   min = 0, max = 20, value = 0, step = 1)),
            column(3, numericInput("SNinput2", "I(D):",
                                   min = 0, max = 2, value = 0, step = 1)),
            column(3, numericInput("SNinput3", "MA(Q):",
                                   min = 0, max = 30, value = 0, step = 1)),
            column(3, numericInput("Period", "Periodo:",
                                   min = 0, max = 36, value = 12, step = 1)),
            br(),
            sliderInput(
              inputId = "SLDAI",
              label = "Período da série:",
              value = c(1, 120), min = 1 , max = 500, step = 1),
            br(),
            box(
              column(2),
              width = 12,
              tableOutput("PIFAI")
            )
          ),
          tabBox(
            id = "GRAFAI",
            title = strong("Análise gráfica"),
            width = 8,
            side = "right",
            height = "700px",
            tabsetPanel(
              tabPanel(
                "Previsão",
                plotlyOutput("PREVAI", height = "550px")),
              tabPanel(
                "Ajuste",
                plotlyOutput("FITAI", height = "550px")),
              tabPanel(
                "Resíduos",
                plotlyOutput("RESAI", height = "550px")),
              tabPanel(
                "Densidade dos resíduos",
                plotlyOutput("DENSRESAI", height = "550px")),
              tabPanel(
                "ACF dos resíduos",
                plotlyOutput("ACFRESAI", height = "550px")),
              tabPanel(
                "PACF dos resíduos",
                plotlyOutput("PACFRESAI", height = "550px")),
              tabPanel(
                "Validação",
                plotlyOutput("VCAI", height = "550px")),
              tabPanel(
                "Tabela",
                dataTableOutput("TABLEAI"))
            )
          )
        ),
        fluidRow(
          box(
            title = strong("Grau de ajuste"),
            align="center",
            solidHeader = T,
            status = "primary",
            width = 4,
            verbatimTextOutput("STATSAI2")
          ),
          box(
            title = strong("Auto.Arima"),
            align="center",
            solidHeader = T,
            status = "primary",
            width = 8,
            selectInput("AAIC", "Critério seletivo:",
                        multiple = F,
                        selectize = T,
                        c("Akaike Information Criterion - AIC" = "aic",
                          "Akaike Information Criterion Corrected - AICc" = "aicc",
                          "Bayesian Information Criterion - BIC" = "bic"),
                        selected = "aic"),
            verbatimTextOutput("Auto.Arima")
          )
        ),
        fluidRow(
          box(
            title = strong("Sumário dos resíduos"),
            align="center",
            solidHeader = T,
            status = "primary",
            width = 4,
            verbatimTextOutput("STATSAI1")
          ),
          box(
            title = strong("Informações adicionais"),
            align="center",
            solidHeader = T,
            status = "primary",
            width = 8,
            verbatimTextOutput("STATSAI3")
          )
        )
      ),
      
      tabItem(
        tabName = "REF",
        fluidRow(h1(strong("Referências"), align = "center")),
        fluidPage(
          h2(strong("Referências")),
          box(
            width = 12,
            tags$cite(h3("GUJARATI, D. N.", strong("BASIC ECONOMETRICS"),". 3rd Edition, McGraw-hill Companies, 1995.")),
            br(),
            tags$cite(h3("Box, G. E. P.; Jenkins, G. M.; Reinsel, G. C. ",strong("TIME SERIES ANALYSIS: Forecasting and Control"),". 4th edition, John Wiley & sons, Inc., 2008.")),
            br(),
            tags$cite(h3("MORETTIN, P. A.; TOLOI, C. M. C.", strong("ANÁLISE DE SÉRIES TEMPORAIS"), ". Segunda edição, Editora Blucher, 2006.")),
            br(),
            tags$cite(h3("Bueno, R.L.S. ", strong("ECONOMETRIA DE SÉRIES TEMPORAIS"), ". Segunda edição, Editora Cengage Learning, 2012.")),
            br(),
            tags$cite(h3("Grolemund, G.; Wickham, H. ", strong("R for Data Science."), "Disponível em: <https://r4ds.had.co.nz/> Acesso em: 20 de novembro de 2018.")),
            br(),
            tags$cite(h3("Athanasopoulos, G.; Hyndman, J. R. ", strong("Forecasting: Principles and practice."), "Monash University, Australia. Disponível em: <https://otexts.com/fpp2/> Acesso em: 20 de outubro de 2018.")),
            br()
          )
        )
      ),
      tabItem(
        tabName = "SOBRE",
        fluidRow(h1(strong("Sobre"), align = "center")),
        fluidPage(
          box(width = 12,
              h2(strong("Objetivo")),
              br(),
              h3("O objetivo deste trabalho é disponibilizar uma plataforma que explore quantitativamente o comportamento dos dados referentes à conjuntura socioeconômica do estado de Santa Catarina presentes no SGS/BCB (através de análises descritivas e indutivas das mesmas) e dê suporte para a realização de pareceres técnicos que dêem possibilidade não apenas de avaliar a condução das políticas públicas, mas também o apoio e suporte para construção de planejamentos estratégicos, assim como a identificação de diretrizes para políticas públicas e anticíclicas."),
              br(),
              br(),
              h2(strong("Conclusão")),
              br(),
              h3("Após concluída uma primeira versão do OSESC, aufere-se um resultado positivo com a mesma. Além de ter se desenvolvido uma plataforma que pretende explorar o comportamento dos dados estaduais (através de análises descritivas e indutivas) com o auxílio dinâmico dos Inputs e Outputs instantâneos. Sendo assim, fica claro o potencial de aperfeiçoamento nas inferências estatísticas que aplicações “shiny” trazem consigo, bem como suas potenciais contribuições em atuais processos de ensino e aprendizagem (e suas aplicações práticas) de métodos quantitativos."),
              br(),
              br(),
              h2(strong("Material & método")),
              br(),
              h3("O arranjo do OSESC se divide em duas partes. A primeira é a Interface do Usuário (UI), que se constitui na área a qual o usuário tem acesso, onde Inputs (locais em que o usuário poderá inserir ou modificar informações) e Outputs (locais de saída de dados e gráficos) se situam. Já a segunda é a Servidor (Server), local onde os Inputs são processados e, posteriormente, devolvidos para os Outputs na Interface do Usuário. Ainda assim, a Interface do Usuário pode ser fragmentada pelos componentes de sua aba lateral, são eles: a) “Home”, que serve como página inicial para a aplicação; b) “Apresentação”, que faz uma breve introdução do conteúdo da aplicação; c) “Metodologia”, que procura dar mais detalhes sobre os elementos que compõem a página; d) “Análise”, que é onde se situa o cerne da aplicação, onde é possível ter acesso aos dados e realizar as análises descritiva e indutiva; e) “Referências”, onde se situam as obras utilizadas para a elaboração da plataforma; f) “Sobre”, onde se encontram mais detalhes sobre a constituição desta aplicação e os agradecimentos do autor; e, por último, g) “Contatos”, onde estão os contatos dos autores."),
              br(),
              h3("Para a construção de tal aplicação foram utilizados os seguintes pacotes do software R: a) O pacote “shiny” (Chang et al., 2018), o qual permite a conversão do código R em HTML, para que este possa ser exposto sob a forma de uma aplicação online; b) o pacote “shinydashboard” (Chang et al., 2018), que facilita a construção da interface do usuário, proporcionando uma página limpa e de fácil acesso, através de seu cabeçalho e abas laterais; c) o pacote “ggplot2” (Wickham et al., 2018), que proporciona gráficos customizados relativamente complexos; d) o pacote “plotly” (Sievert et al., 2018), que permite maior dinamismo nos gráficos criados pelo pacote anterior; e) o pacote “DT” (Xie et al., 2018), que permite a criação de tabelas interativas para a exposição de dados; f) o pacote “forecast” (Hyndman et al., 2019), que conta com diversas funções relacionadas à análise preditiva, incluindo, mas não somente, a função auto.arima(), a qual permite estimar o melhor conjunto de parâmetros para o modelo ARIMA, segundo determinada medida de grau de ajuste selecionada; g) o pacote “quandl” (McTaggart et al., 2018), que facilita o download das séries temporais do BCB, entre diferentes bancos de dados; e, por fim, h) o pacote “tidyverse” (Wickham, 2017), que possibilita a organização e transformação dos dados."))
        )
      ),
      tabItem(
        tabName = "CTT",
        fluidRow(h1(strong("Contatos"), align = "center")),
        fluidPage(
          h2(strong("Autoria")),
          box(
            width = 12,
            h3(strong("Guilherme Viegas")),
            h3("guilhermeviegas1993@gmail.com"),
            tags$a(href = "https://guilhermeviegas.portfoliobox.net/", h3("Guigo's Portifólio")),
            br(),
            hr(),
            h3(strong("Prof. Dr. Gueibi Peres Souza")),
            h3("gueibi.souza@ufsc.br"),
            br(),
            hr(),
            h3(strong("Profa. Dra. Andréa Cristina Konrath")),
            h3("andreack@gmail.com"),
            br(),
            hr(),
            h3(strong("Prof. Rodrigo Gabriel de Miranda")),
            h3("rgabrieldemiranda@gmail.com"),
            br()
          ),
          h2(strong("Agradecimentos")),
          box(
            width = 12,
            h3(strong("Núcleo de Normalização e Qualimetria - ", tags$a("NNQ", href = "http://qualimetria.ufsc.br/"))),
            leafletOutput("NNQMAP"),
            br(),
            hr(),
            h3(strong("Prof. Dr. Arlei Luiz Fachinelo")),
            br(),
            hr(),
            h3(strong("Prof. Dr. Luiz Ricardo Nakamura")),
            br()
          )
        )
      )
    )
  )
  
)

# SERVER ------------------------------------------------------------------

server <- function(input, output){
  
  SERIEADraw <- reactive({
    if(input$FONTAND == "BCB/SC"){
      SADraw1 <- Quandl::Quandl(paste0("BCB/", input$SBCBSCAD), type = "raw", collapse = "monthly", api_key = "gGdvN9gXsx9hxHMTWPNL")
    }
    else if(input$FONTAND == "BCB"){
      SADraw1 <- Quandl::Quandl(paste0("BCB/", input$CODSADBC), type = "raw", collapse = "monthly", api_key = "gGdvN9gXsx9hxHMTWPNL")
    }
    else if(input$FONTAND == "Externa"){
      req(input$EXTFILEAD)
      SADraw1 <- read.csv(input$EXTFILEAD$datapath,
                          header = F,
                          sep = ",",
                          dec = ".")
      SADraw1 <- SADraw1[seq(dim(SADraw1)[1],1),]
    }
    SADraw2 <- SADraw1[seq(dim(SADraw1)[1],1),]
  })
  
  SERIEADts <- reactive({
    TS <- ts(SERIEADraw()[,2], start = c(as.numeric(substring(SERIEADraw()[1,1],1,4)), as.numeric(substring(SERIEADraw()[1,1],6,7))), frequency = 12)
    if(input$DIFSAD == 0){TS}
    else if(input$DIFSAD == 1){TS <- diff(TS, 1)}
    else if(input$DIFSAD == 2){TS <- diff(TS, 2)}
  })
  
  ################################################
  
  output$PIFAD <- renderTable({
    tpifadii <- tibble("Período Inicial" = paste(substring(SERIEADraw()[input$SLDAD[1],1],6,7), "/", substring(SERIEADraw()[input$SLDAD[1],1],1,4)),
                       "-" = paste("-"),
                       "Período Final" = paste(substring(SERIEADraw()[input$SLDAD[2],1],6,7), "/", substring(SERIEADraw()[input$SLDAD[2],1],1,4)))
  })
  
  output$GLAD <- renderPlotly({
    GLST <- autoplot(ts(SERIEADts()[input$SLDAD[1]:input$SLDAD[2]], start = c(as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],1,4)), as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],6,7))), frequency = 12))+
      labs(title = "Gráfico de linha da série temporal",
           x = "Tempo",
           y = "Y")
    if(is.null(input$MARKAD)){
      GLST
    } else if(all(c("m1", "m2") %in% input$MARKAD)){
      GLST <- GLST +
        geom_hline(yintercept = mean(SERIEADts()[input$SLDAD[1]:input$SLDAD[2]]), color = "red")+
        geom_hline(yintercept = median(SERIEADts()[input$SLDAD[1]:input$SLDAD[2]]), color = "blue")
    } else if(input$MARKAD == "m1" & input$MARKAD != "m2"){
      GLST <- GLST + geom_hline(yintercept = mean(SERIEADts()[input$SLDAD[1]:input$SLDAD[2]]), color = "red")
    } else if(input$MARKAD != "m1" & input$MARKAD == "m2"){
      GLST <- GLST + geom_hline(yintercept = median(SERIEADts()[input$SLDAD[1]:input$SLDAD[2]]), color = "blue")
    }
    GLST+
      theme_minimal()
  })
  
  output$LINS <- renderPlotly({
    ggseasonplot(ts(SERIEADts()[input$SLDAD[1]:input$SLDAD[2]], start = c(as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],1,4)), as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],6,7))), frequency = 12))+
      labs(title = "Gráfico de linhas sazonais",
           x = "Tempo",
           y = "Y")+
      theme_minimal()
  })
  
  
  output$SUBS <- renderPlotly({
    ggsubseriesplot(ts(SERIEADts()[input$SLDAD[1]:input$SLDAD[2]], start = c(as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],1,4)), as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],6,7))), frequency = 12))+
      labs(title = "Gráfico de subséries",
           x = "Tempo",
           y = "Y")+
      theme_minimal()
  })
  
  
  output$BPAD <- renderPlotly({
    SP <- tibble(MES = substr(SERIEADraw()[seq(1:nrow(SERIEADraw()-input$DIFSAD)),1], 6 , 7),
                 ANO = substr(SERIEADraw()[seq(1:nrow(SERIEADraw()-input$DIFSAD)),1], 1 , 4),
                 DADOS = SERIEADraw()[1:nrow(SERIEADraw()), 2])
    SP <- SP[input$SLDAD[1]:input$SLDAD[2],]
    BP <- ggplot(SP , aes(x = factor(SP$MES, levels = c("01","02","03","04","05","06","07","08","09","10","11","12"), ordered = T),
                          y = SP$DADOS, group = SP$MES))+
      geom_boxplot()+
      stat_summary(fun.y = mean, geom = "point", shape = 18, size = 1, color = "red", alpha = 0.8)+
      labs(title = "Box Plot dividido entre os meses do ano",
           x = "Meses do ano",
           y = "Y")
    if(is.null(input$MARKAD)){
      BP
    } else if(all(c("m1", "m2") %in% input$MARKAD)){
      BP <- BP +
        geom_hline(yintercept = mean(SP$DADOS), color = "red")+
        geom_hline(yintercept = median(SP$DADOS), color = "blue")
    } else if(input$MARKAD == "m1" & input$MARKAD != "m2"){
      BP <- BP + geom_hline(yintercept = mean(SP$DADOS), color = "red")
    } else if(input$MARKAD != "m1" & input$MARKAD == "m2"){
      BP <- BP + geom_hline(yintercept = median(SP$DADOS), color = "blue")
    }
    BP+
      theme_minimal()
  })
  
  output$BPVAD <- renderPlotly({
    SP <- tibble(MES = substr(SERIEADraw()[seq(1:nrow(SERIEADraw()-input$DIFSAD)),1], 6 , 7),
                 ANO = substr(SERIEADraw()[seq(1:nrow(SERIEADraw()-input$DIFSAD)),1], 1 , 4),
                 DADOS = SERIEADraw()[1:nrow(SERIEADraw()), 2])
    SP <- SP[input$SLDAD[1]:input$SLDAD[2],]
    VP <- ggplot(SP , aes(x = factor(SP$MES, levels = c("01","02","03","04","05","06","07","08","09","10","11","12"), ordered = T),
                          y = SP$DADOS, group = SP$MES))+
      geom_violin()+
      stat_summary(fun.y = mean, geom = "point", shape = 18, size = 1, color = "red", alpha = 0.8)+
      labs(title = "Violino dividido entre os meses do ano",
           x = "Meses do ano",
           y = "Y")
    if(is.null(input$MARKAD)){
      VP
    } else if(all(c("m1", "m2") %in% input$MARKAD)){
      VP <- VP +
        geom_hline(yintercept = mean(SP$DADOS), color = "red")+
        geom_hline(yintercept = median(SP$DADOS), color = "blue")
    } else if(input$MARKAD == "m1" & input$MARKAD != "m2"){
      VP <- VP + geom_hline(yintercept = mean(SP$DADOS), color = "red")
    } else if(input$MARKAD != "m1" & input$MARKAD == "m2"){
      VP <- VP + geom_hline(yintercept = median(SP$DADOS), color = "blue")
    }
    VP+
      theme_minimal()
  })
  
  output$DENSAD <- renderPlotly({
    SS <- data.frame(C = SERIEADts()[input$SLDAD[1]:input$SLDAD[2]])  
    DENS <- ggplot(SS, aes(as.numeric(SS$C)))+
      geom_density(size = 0.8, fill = "gray", alpha = 0.5)+
      labs(title = "Gráfico da densidade da série temporal",
           x = "Observação",
           y = "Densidade")
    if(is.null(input$MARKAD)){
      DENS
    } else if(all(c("m1", "m2") %in% input$MARKAD)){
      DENS <- DENS +
        geom_vline(xintercept = mean(SS$C), color = "red")+
        geom_vline(xintercept = median(SS$C), color = "blue")
    } else if(input$MARKAD == "m1" & input$MARKAD != "m2"){
      DENS <- DENS + geom_vline(xintercept = mean(SS$C), color = "red")
    } else if(input$MARKAD != "m1" & input$MARKAD == "m2"){
      DENS <- DENS + geom_vline(xintercept = median(SS$C), color = "blue")
    }
    DENS <- ggplotly(DENS+
                       theme_minimal())
    DENS
  })
  
  output$DCAD <- renderPlotly({
    ggplotly(
      autoplot(
        decompose(
          as.ts(
            ts(SERIEADts()[input$SLDAD[1]:input$SLDAD[2]], start = c(as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],1,4)), as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],6,7))), frequency = 12)
          ),
          type  = input$SISAD
        )
      )+
        theme_minimal()
    )
  })
  
  output$ACFAD <- renderPlotly({
    ggplotly(
      ggAcf(
        ts(SERIEADts()[input$SLDAD[1]:input$SLDAD[2]], start = c(as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],1,4)), as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],6,7))), frequency = 12), 
        lag.max = 60)+
        labs(title = "Função de auto-correlação")+
        theme_minimal()
    )
  })
  
  output$PACFAD <- renderPlotly({
    ggplotly(
      ggPacf(
        ts(SERIEADts()[input$SLDAD[1]:input$SLDAD[2]], start = c(as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],1,4)), as.numeric(substring(SERIEADraw()[input$SLDAD[1],1],6,7))), frequency = 12), 
        lag.max = 60)+
        labs(title = "Função de auto-correlação parcial")+
        theme_minimal()
    )
  })
  
  output$TABLEAD <- DT::renderDataTable({
    SP <- tibble(MES = substr(SERIEADraw()[input$SLDAD[1]:input$SLDAD[2],1], 6 , 7),
                 ANO = substr(SERIEADraw()[input$SLDAD[1]:input$SLDAD[2],1], 1 , 4),
                 DADOS = SERIEADraw()[input$SLDAD[1]:input$SLDAD[2], 2])},
    options = list(pageLength = 12)
  )
  
  output$STATSAD <- renderPrint({
    NDI <- as.numeric(SERIEADts())
    Infosadii <- data.frame(Estimador = c("Máximo", "Limite Superior", "3* Quartil", "Mediana", "Média", "1* Quartil", "Limite Inferior", "Mínimo", "Variância", "Desvio Padrão", "Amplitude", "Amplitude interquartil", "Assimetria", "Curtose", "P-valor de Bera-Jarque", "P-valor de Shapiro-Wilk" ,"P-valor de Dickey-Fuller"),
                            "." = c("  "),
                            Estimativa = c(round(max(NDI),3), round(quantile(NDI)[[4]]+1.5*(quantile(NDI)[[4]]-quantile(NDI)[[2]]),3), round(quantile(NDI)[[4]],3), round(median(NDI),3), round(mean(NDI),3), round(quantile(NDI)[[2]],3), round(quantile(NDI)[[2]]-1.5*(quantile(NDI)[[4]]-quantile(NDI)[[2]]),3), round(min(NDI),3),
                                           round(var(NDI),3), round(sd(NDI),3), round(max(NDI)-min(NDI),3), round(quantile(NDI)[[4]]-quantile(NDI)[[2]],3), round(skewness(NDI),3), round(kurtosis(NDI),3), round(jarque.test(as.vector(NDI))[[2]], 3), round(shapiro.test(NDI)[[2]], 3) , round(adf.test(NDI, k = 12)[[4]], 3)))
    Infosadii
  })
  
  ####################################   ANI   ##############################
  
  SERIEAI0 <- reactive({
    if(input$FONTANI == "BCB/SC"){
      SAIraw1 <- Quandl::Quandl(paste0("BCB/", input$SBCBSCAI), type = "raw", collapse = "monthly", api_key = "gGdvN9gXsx9hxHMTWPNL")
    }
    else if(input$FONTANI == "BCB"){
      SAIraw1 <- Quandl::Quandl(paste0("BCB/", input$CODSAI), type = "raw", collapse = "monthly", api_key = "gGdvN9gXsx9hxHMTWPNL")
    }
    else if(input$FONTANI == "EXTFILEAI"){
      req(input$EXTFILEAI)
      SAIraw1 <- read.csv(input$EXTFILEAI$datapath,
                          header = F,
                          sep = ",",
                          dec = ".")
      SAIraw1 <- SAIraw1[seq(dim(SAIraw1)[1],1),]
    }
    SAIraw2 <- SAIraw1[seq(dim(SAIraw1)[1],1),]
    TS <- ts(SAIraw2[,2], start = c(as.numeric(substring(SAIraw2[1,1],1,4)), as.numeric(substring(SAIraw2[1,1],6,7))), frequency = 12)
  })
  
  SERIEAI1 <- reactive({
    if(input$FONTANI == "BCB/SC"){
      SAIraw1 <- Quandl::Quandl(paste0("BCB/", input$SBCBSCAI), type = "raw", collapse = "monthly", api_key = "gGdvN9gXsx9hxHMTWPNL")
    }
    else if(input$FONTANI == "BCB"){
      SAIraw1 <- Quandl::Quandl(paste0("BCB/", input$CODSAI), type = "raw", collapse = "monthly", api_key = "gGdvN9gXsx9hxHMTWPNL")
    }
    else if(input$FONTANI == "EXTFILEAI"){
      req(input$EXTFILEAI)
      SAIraw1 <- read.csv(input$EXTFILEAI$datapath,
                          header = F,
                          sep = ",",
                          dec = ".")
      SAIraw1 <- SAIraw1[seq(dim(SAIraw1)[1],1),]
    }
    SAIraw2 <- SAIraw1[seq(dim(SAIraw1)[1],1),]
  })
  
  SERIEAI2 <- reactive({
    TS <- ts(SERIEAI1()[,2], start = c(as.numeric(substring(SERIEAI1()[1,1],1,4)), as.numeric(substring(SERIEAI1()[1,1],6,7))), frequency = 12)
  })
  
  SERIEAI3 <- reactive({
    SP <- tibble(MES = substr(SERIEAI1()[ ,1], 6 , 7),
                 ANO = substr(SERIEAI1()[ ,1], 1 , 4),
                 DADOS = SERIEAI1()[, 2])
  })
  
  ARIMAdata <- reactive({
    ND <- SERIEAI2()[input$SLDAI[1]:input$SLDAI[2]]
    ARIMA.model <- Arima(ND, order = c(input$Ninput1,input$Ninput2, input$Ninput3), seasonal = list(order = c(input$SNinput1, input$SNinput2, input$SNinput3), period = input$Period))
  })
  
  ##################	SERVER AI 	###################################
  
  output$PIFAI <- renderTable({
    tpifai <- tibble("Período Inicial" = paste(substring(SERIEAI1()[input$SLDAI[1],1],6,7), "/", substr(SERIEAI1()[input$SLDAI[1],1],1,4)),
                     "-" = paste("-"),
                     "Período Final" = paste(substring(SERIEAI1()[input$SLDAI[2],1],6,7), "/", substring(SERIEAI1()[input$SLDAI[2],1],1,4)))
  })
  
  output$PREVAI <- renderPlotly({
    FF <- forecast(ARIMAdata(), h = input$AMP)
    autoplot(FF)+
      autolayer(FF$mean, color = "blue")+
      labs(y = "Y", x = "Tempo")+
      theme(legend.position = "none")+
      theme_minimal()
  })
  
  output$FITAI <- renderPlotly({
    S2A <- SERIEAI2()[input$SLDAI[1]:input$SLDAI[2]]
    FIT <- data.frame(OBSERVADO = S2A,
                      AJUSTE = ARIMAdata()$fitted,
                      TEMPO = SERIEAI1()[input$SLDAI[1]:input$SLDAI[2],1])
    ggplot(FIT)+
      geom_line(aes(y = FIT$OBSERVADO,
                    x = FIT$TEMPO),
                alpha = 0.8, size = 1.2)+
      geom_line(aes(y = FIT$AJUSTE,
                    x = FIT$TEMPO),
                alpha = 0.6, size = 1.2, col = "blue")+
      labs(y = "Y",
           x = "Observação",
           title = "Ajuste do modelo")+
      theme_minimal()
  })
  
  output$RESAI <- renderPlotly({
    DFA <- data.frame(res = residuals(ARIMAdata()))
    ggplot(DFA)+
      geom_segment(aes(x = c(1:length(DFA$res)), y = 0, xend = c(1:length(DFA$res)), yend = DFA$res))+
      geom_hline(yintercept = c(sd(DFA$res), -sd(DFA$res)),linetype = "dashed", alpha = 0.3)+
      geom_hline(yintercept = c(2*sd(DFA$res), -2*sd(DFA$res)),linetype = "dashed", alpha = 0.3)+
      geom_hline(yintercept = c(3*sd(DFA$res), -3*sd(DFA$res)),linetype = "dashed", alpha = 0.3)+
      geom_hline(yintercept = 0)+
      labs(title = "Distância entre o modelo e o observado",
           y = "Resíduos",
           x = "Observações")+
      theme_minimal()
  })
  
  output$DENSRESAI <- renderPlotly({
    PDENSAIII <- ggplot(residuals(ARIMAdata()), aes(residuals(ARIMAdata())))+
      geom_density(size = 0.8, fill = "gray", alpha = 0.5)+
      labs(title = "Distribuição de densidade dos resíduos",
           x = "Observação",
           y = "Frequência")
    
    if(is.null(input$MARKAI)){
      PDENSAIII
    } else if(all(c("m1", "m2") %in% input$MARKAI)){
      PDENSAIII <- PDENSAIII +
        geom_vline(xintercept = mean(residuals(ARIMAdata())), color = "red")+
        geom_vline(xintercept = median(residuals(ARIMAdata())), color = "blue")
    } else if(input$MARKAI == "m1" & input$MARKAI != "m2"){
      PDENSAIII <- PDENSAIII + geom_vline(xintercept = mean(residuals(ARIMAdata())), color = "red")
    } else if(input$MARKAI != "m1" & input$MARKAI == "m2"){
      PDENSAIII <- PDENSAIII + geom_vline(xintercept = median(residuals(ARIMAdata())), color = "blue")
    }
    PDENSAIII <- ggplotly(PDENSAIII+
                            theme_minimal())
    PDENSAIII
  })
  
  output$ACFRESAI <- renderPlotly({
    ggplotly(
      ggAcf(
        residuals(
          ARIMAdata()
        ), lag.max = 60
      )+
        labs(title = "Função de auto-correlação dos resíduos")+
        theme_minimal()
    )
  })
  
  output$PACFRESAI <- renderPlotly({
    ggplotly(
      ggPacf(
        residuals(
          ARIMAdata()
        ), lag.max = 60
      )+
        labs(title = "Função de auto-correlação parcial dos resíduos")+
        theme_minimal()
    )
  })
  
  output$VCAI <- renderPlotly({
    ND <- ts(SERIEAI1()[input$SLDAI[1]:input$SLDAI[2],2], start = c(as.numeric(substring(SERIEAI1()[1,1],1,4)), as.numeric(substring(SERIEAI1()[1,1],6,7))), frequency = 12)
    NF <- forecast(Arima(ND, order = c(input$Ninput1,input$Ninput2, input$Ninput3), seasonal = list(order = c(input$SNinput1, input$SNinput2, input$SNinput3), period = input$Period)), h = input$AMP)
    NB <- ts(SERIEAI1()[input$SLDAI[2]:(input$SLDAI[2]+input$AMP),2], start = c(as.numeric(substring(SERIEAI1()[length(ND),1],1,4)), as.numeric(substring(SERIEAI1()[length(ND),1],6,7))), frequency = 12)
    
    autoplot.zoo(ND)+
      autolayer(NF$mean, size = 0.8, color = "blue", alpha = 0.6)+
      autolayer(as.ts(NB), size = 0.6, color = "red", alpha = 0.3)+
      theme_minimal()
  })
  
  output$TABLEAI <- DT::renderDataTable({
    round(data.frame(forecast(ARIMAdata(), h = 60)), 3)},
    options = list(pageLength = 12)
  )
  
  output$STATSAI1 <- renderPrint({
    InfosaiII1 <- data.frame(ESTIMADOR = c("Máximo", "Limite Superior", "3* Quartil", "Mediana", "Média", "1* Quartil", "Limite Inferior", "Mínimo", "Variância", "Desvio Padrão", "Amplitude", "Amplitude Interquartil", "Assimetria", "Curtose", "P-valor de Bera-Jarque", "P-valor de Shapiro-Wilk", "P-valor de Dickey-Fuller"),
                             "." = " ",
                             ESTIMATIVA = c(round(max(residuals(ARIMAdata())), 3), round(1.5*IQR(residuals(ARIMAdata())), 3), round(quantile(residuals(ARIMAdata()))[[4]], 3), round(median(residuals(ARIMAdata())), 3), round(mean(residuals(ARIMAdata())), 3), round(quantile(residuals(ARIMAdata()))[[2]], 3), round(-1.5*IQR(residuals(ARIMAdata())), 3), round(min(residuals(ARIMAdata())), 3), round(var(residuals(ARIMAdata())), 3), round(sd(residuals(ARIMAdata())), 3), round(min(residuals(ARIMAdata()))- max(residuals(ARIMAdata())), 3), round(IQR(residuals(ARIMAdata())), 3), round(skewness(residuals(ARIMAdata())), 3), round(kurtosis(residuals(ARIMAdata())), 3), round(jarque.test(as.vector(residuals(ARIMAdata())))[[2]], 3), round(shapiro.test(residuals(ARIMAdata()))[[2]], 3), round(adf.test(residuals(ARIMAdata()), k = 12)[[4]], 3)))
    InfosaiII1
  })
  
  output$STATSAI2 <- renderPrint({
    InfosaiII2 <- data.frame(ESTIMADOR = c("AIC", "AICc", "BIC", "RMSE", "Log likelihood", "P-valor de Ljung-Box teste"),
                             "." = " ",
                             ESTIMATIVA = c(round(ARIMAdata()[[6]], 3), round(ARIMAdata()$aicc, 3), round(ARIMAdata()[[16]], 3), round(accuracy(ARIMAdata())[2], 3), round(ARIMAdata()$loglik, 3), round(Box.test(ARIMAdata()$residuals)[[3]], 3)))
    InfosaiII2
  })
  
  output$STATSAI3 <- renderPrint({
    ARIMAdata()[]
  })
  
  output$Auto.Arima <- renderPrint({
    auto.arima(SERIEAI2(), seasonal = T, trace = F, ic = input$AAIC)
  })
  
  output$NNQMAP <- renderLeaflet({
    m <- leaflet() %>%
      addTiles() %>%
      addMarkers(lat = -27.600593, lng = -48.518627, popup = "NNQ - Núcleo de Normalização e Qualimetria") %>%
      addLayersControl(
        options = layersControlOptions(collapsed = FALSE)) %>%
      addMiniMap(tiles = providers$Esri.WorldTopoMap, width = 120, height=180)
    m
  })
  
}

#################  APP   #######################

shinyApp(ui = ui, server = server)

