
# App Settings & Materials (tutorials and intro to the app)
osSystem <- Sys.info()["sysname"]
#

ini_rarefaction <- sidebarLayout(position = "left",
                                  sidebarPanel(
                                    h3("Rarefaction Analysis"),
                                    p(paste0("One ne of the most important")),
                                    br(),
                                    #directoryInput('ras_layers_directory', label = 'Select a raster layers directory'),
                                    selectInput("SetsRarefaction","Select at Community",
                                                choices = vars_names,
                                                multiple = TRUE),

                                    numericInput(inputId = "HillNumber",
                                                 label = "Hill Number:",
                                                 min = 0,
                                                 max = 2,
                                                 value = 0),

                                    selectInput("dataTypeR",label = "Data Type:",
                                                choices = c("Abundance "="abundance",
                                                            "Incidence Frequency"="incidence_freq",
                                                            "Incidence Raw"="incidence_raw")),
                                    
                                    shinyBS::bsButton("run_raferaction",  "Run",   icon = icon("upload", lib = "glyphicon"),  style = "primary"),
                                    
                                    br(),
                                    width=4),
                                  mainPanel(
                                    h4('Rarefaction Curve', align='center'),
                                    br(),
                                    #verbatimTextOutput(outputId = "rendertwoDistribution"),
                                    plotOutput("plotRarefaction")
                                  )
)

