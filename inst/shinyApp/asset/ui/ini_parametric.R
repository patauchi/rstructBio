
# App Settings & Materials (tutorials and intro to the app)
osSystem <- Sys.info()["sysname"]
#

ini_parametric <- sidebarLayout(position = "left",
                                  sidebarPanel(
                                    h4("Parametric Tests"),
                                    p(paste0("One ne of the most important",
                                             "things for your data analysis",
                                             " in NTB is to select the folder",
                                             " with the raster layers that you",
                                             "will use as niche variables.")),
                                    br(),
                                    #directoryInput('ras_layers_directory', label = 'Select a raster layers directory'),

                                    h4("Dataset"),
                                    selectInput("datasetParam",
                                                label="Choose a dataset :",
                                                choices=c("Species", "Environmental")),
                                    selectInput("SetsVarsTests","Select at Community",
                                                choices = vars_names,
                                                multiple = TRUE),



                                    ############################## BEGIN CAPSULES
                                    checkboxInput("getMeans", label = "Analysis of Means",value = FALSE),
                                    conditionalPanel("input.getMeans == true",
                                                     selectInput("test_MeanParam",label = "Select a source",
                                                                 choices = c("Student's t-test (one sample)"="ttestOne",
                                                                             "Student's t-test (two samples)"="ttestTwo",
                                                                             "z test (one sample)"="ztestOne",
                                                                             "z test (two samples)"="ztestTwo")),

                                                     conditionalPanel("input.test_MeanParam=='ttestOne'",
                                                                      h5('t test options'),
                                                                      numericInput(inputId = "muTestOne",
                                                                                   label = "Mean hypothetical:",
                                                                                   min = 0,
                                                                                   max = 1000000,
                                                                                   value = 0),
                                                                      ),
                                                     br(),
                                                     bsButton("runParMeans",
                                                              "Run",
                                                              icon = icon("upload",
                                                                          lib = "glyphicon"),
                                                              style = "primary"),
                                                     busyIndicator("Loading...",wait = 0),
                                                     br(),

                                    ),

                                    ############################## END CAPSULES

                                    ############################## BEGIN CAPSULES
                                    checkboxInput("getVariance", label = "Analysis of Variance",value = FALSE),
                                    conditionalPanel("input.getVariance == true",
                                                     selectInput("test_VarParam",label = "Select a source",
                                                                 choices = c("One-sample variance test"="oneSampleVar",
                                                                             "Two-sample comparison of variances"="twoSampleVar",
                                                                             "k-samples comparison of variances"="kSampleVar")),

                                                     conditionalPanel("input.test_VarParam=='oneSampleVar'",
                                                                      h5('t test options'),
                                                                      numericInput(inputId = "muSigTestOneVar",
                                                                                   label = "Variance hypothetical:",
                                                                                   min = 0,
                                                                                   max = 1000000,
                                                                                   value = 0,
                                                                                   width='50%'),
                                                                      ),
                                                     br(),
                                                     bsButton("runParVariance", "Run",  icon = icon("upload", lib = "glyphicon"), style = "primary"),
                                                     busyIndicator("Loading...",wait = 0),
                                                     br(),),

                                    ############################## END CAPSULES


                                    ############################## BEGIN CAPSULES
                                    checkboxInput("getPropotion", label = "Proportions",value = FALSE),
                                    conditionalPanel("input.getPropotion == true",

                                                     ####### One Sample
                                                     checkboxInput('getParametricOnePro', label = "Test for one proportion", value = FALSE),
                                                     conditionalPanel("input.getParametricMeans==true",
                                                                      ## Agregar parametros del test
                                                                      h5('Agrega contenido'),
                                                     ),
                                                     ####### Two Sample
                                                     checkboxInput('getParametricTwoPro', label = "Test for two proportion", value = FALSE),
                                                     conditionalPanel("input.getParametricTwoPro==true",
                                                                      ## Agregar parametros del test
                                                                      h5('Agrega contenido'),
                                                     ),
                                                     ####### More than two Sample
                                                     checkboxInput('getParametricThreePro', label = "Test for K-proportion", value = FALSE),
                                                     conditionalPanel("input.getParametricThreePro==true",
                                                                      ## Agregar parametros del test
                                                                      h5('Agrega contenido'),
                                                     ),
                                                     br(),
                                                     bsButton("loadNicheLayers",
                                                              "Run",
                                                              icon = icon("upload",
                                                                          lib = "glyphicon"),
                                                              style = "primary"),
                                                     busyIndicator("Loading...",wait = 0),
                                                     br(),

                                    ),

                                    ############################## END CAPSULES


                                    br(),

                                    width=4),
                                  mainPanel(
                                    h4('Parametric Tests'),
                                    br(),
                                    verbatimTextOutput(outputId = "renderTestParametric"),
                                    verbatimTextOutput(outputId = "renderVarianceParametric")
                                  )
)




