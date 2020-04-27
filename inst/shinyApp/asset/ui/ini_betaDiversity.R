
ini_BetaDiv <- sidebarLayout(position = 'left',
                         sidebarPanel(
                           h3("Beta Diversity"),
                           br(),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),
                           p(""),
                           br(),

                           h4("Methods"),
                           tags$div(title="Select one Method",
                                    radioButtons('BetaDivMethod', 'Data Type', c('Jaccard','Sorensen'))),
                           
                           
                           shinyBS::bsButton("run_betaDiversity","Run", icon = icon("upload",lib = "glyphicon"), style = "primary"),
                           br(),
                           width=4),

                         mainPanel(
                           h4("Output Beta Diversity", align='center'),
                           br(),
                           plotOutput("OutputDisplayBetaDiv")

                         ))
