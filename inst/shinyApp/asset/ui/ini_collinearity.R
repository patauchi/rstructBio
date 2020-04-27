
# App Settings & Materials (tutorials and intro to the app)
osSystem <- Sys.info()["sysname"]
#

ini_collinearity <- sidebarLayout(position = "left",
                                  sidebarPanel(
                                  h3("Correlations"),
                                  p(paste0("One ne of the most important")),
                                  br(),
                                  selectInput("SetsColinearity","Select at variable",
                                              choices = vars_names,
                                              multiple = TRUE),
                                  
                                  shiny::radioButtons("correlationMethod", label =  "Select a Method",
                                                  choices = c('Pearson '='pearson',
                                                              'Spearman'='spearman',
                                                              'Kendall Mann'='kendall')),
                                  ############################## BEGIN CAPSULES
                                  checkboxInput("geDisplay",label = "Advanced display",value = FALSE),
                                  conditionalPanel("input.geDisplay == true",
                                                   shiny::radioButtons("DiplayCor",
                                                                       label =  "Choose display method",
                                                                       choices = c('Matrix  '='matrix',
                                                                                   'Network'='network',
                                                                                   'Circle'='circle')),
                                                   br(),
                                                   
                                                   br()),
                                  ############################## END CAPSULES
                                  

                                  shinyBS::bsButton("run_collinearity",
                                                    "Run",
                                                    icon = icon("upload",
                                                                lib = "glyphicon"),
                                                    style = "primary"),
                                  shinysky::busyIndicator("Loading...",wait = 0),         
                                  br(),
                                  width=4),
                                         mainPanel(
                                           plotOutput('OutputDisplayCor')
                                         )
)
