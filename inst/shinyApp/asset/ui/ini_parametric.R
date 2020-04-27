osSystem <- Sys.info()["sysname"]
#
ini_parametric <- sidebarLayout(position = "left",
                                  sidebarPanel(
                                    h3("Parametric Tests"),
                                    p(paste0("One ne of the most important")),
                                    br(),
                                    #directoryInput('ras_layers_directory', label = 'Select a raster layers directory'),
                                    selectInput("SetsVarsTests","Select at variable",
                                                choices = vars_names,
                                                multiple = TRUE),

                                    ############################## BEGIN CAPSULES
                                    checkboxInput("getMeans", label = "Analysis of Means",value = FALSE),
                                    conditionalPanel("input.getMeans == true",
                                                     selectInput("parammeans",label = "Select a source",
                                                                 choices = c("Student's t-test (one sample)"="ttestOne",
                                                                             "Student's t-test (two samples)"="ttestTwo",
                                                                             "z test (one sample)"="ztestOne",
                                                                             "z test (two samples)"="ztestTwo")),

                                                     conditionalPanel("input.parammeans=='ttestOne'",
                                                                      h5('Options'),
                                                                      numericInput(inputId = "muTestOne",
                                                                                   label = "Mean hypothetical:",
                                                                                   min = 0,
                                                                                   max = 1000000,
                                                                                   value = 0),
                                                                      ),
                                                     br()),

                                    ############################## END CAPSULES
                                    
                                    ############################## BEGIN CAPSULES
                                    checkboxInput("getVariance", label = "Analysis of Variance",value = FALSE),
                                    conditionalPanel("input.getVariance == true",
                                                     selectInput("paramvars",label = "Select a source",
                                                                 choices = c("One-sample variance test"="oneSampleVar",
                                                                             "Two-sample comparison of variances"="twoSampleVar",
                                                                             "k-samples comparison of variances"="kSampleVar")),
                                                     
                                                     conditionalPanel("input.paramvars=='oneSampleVar'",
                                                                      h5('Options'),
                                                                      numericInput(inputId = "muSigTestOneVar",
                                                                                   label = "Variance hypothetical:",
                                                                                   min = 0,
                                                                                   max = 1000000,
                                                                                   value = 0),
                                                     ),
                                                     br()),
                                    
                                    ############################## END CAPSULES

                                    br(),
                                    
                                    shinyBS::bsButton("run_parametric","Run",
                                                      icon = icon("upload",lib = "glyphicon"),
                                                      style = "primary"),
                                    width=4),
                                  mainPanel(
                                    h4('Ouput Parametric Tests', align='center'),
                                    br(),
                                    verbatimTextOutput(outputId = "renderTestParametric")
                                  )
)