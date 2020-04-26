
# App Settings & Materials (tutorials and intro to the app)
osSystem <- Sys.info()["sysname"]
#

ini_rarefaction <- sidebarLayout(position = "left",
                                  sidebarPanel(
                                    h4("Rarefaction Analysis"),
                                    p(paste0("One ne of the most important",
                                             "things for your data analysis",
                                             " in NTB is to select the folder",
                                             " with the raster layers that you",
                                             "will use as niche variables.")),
                                    br(),
                                    #directoryInput('ras_layers_directory', label = 'Select a raster layers directory'),

                                    h4("Dataset"),
                                    selectInput("InputRarefaction",
                                                label="Choose a dataset :",
                                                choices=c("Species")),
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



                                    ############################## BEGIN CAPSULES
                                    checkboxInput("getRarefactionP", label = "Advanced options: ",value = FALSE),
                                    conditionalPanel("input.getRarefactionP == true",
                                                     ####### One Sample
                                                     h5('Compararison two distributions'),
                                                     numericInput(inputId = "typerarePlot",
                                                                  label = "Hill Number:",
                                                                  min = 1,
                                                                  max = 3,
                                                                  value = 1),
                                                     shiny::radioButtons("faceVAR",
                                                                         label =  "Select a post-ho method",
                                                                         choices = c('No separation'='none',
                                                                                     "A separate plot for each diversity"='order',
                                                                                     "A separate plot for each site"='site',
                                                                                     'A separate plot for each combination'='both')),


                                    ),
                                    shinyBS::bsButton("run_raferaction",  "Run",   icon = icon("upload", lib = "glyphicon"),  style = "primary"),



                                    ############################## END CAPSULES

                                    br(),

                                    width=3),
                                  mainPanel(
                                    h4('No Parametric Tests'),
                                    br(),
                                    #verbatimTextOutput(outputId = "rendertwoDistribution"),
                                    plotOutput("plotRarefaction")


                                  )
)




