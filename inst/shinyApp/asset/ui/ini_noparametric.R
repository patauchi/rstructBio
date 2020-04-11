
# App Settings & Materials (tutorials and intro to the app)
osSystem <- Sys.info()["sysname"]
#

ini_noparametric <- sidebarLayout(position = "left",
                                sidebarPanel(
                                  h4("No Parametric Tests"),
                                  p(paste0("One ne of the most important",
                                           "things for your data analysis",
                                           " in NTB is to select the folder",
                                           " with the raster layers that you",
                                           "will use as niche variables.")),
                                  br(),
                                  #directoryInput('ras_layers_directory', label = 'Select a raster layers directory'),

                                  h4("Dataset"),
                                  selectInput("datasetnoParam",
                                              label="Choose a dataset :",
                                              choices=c("Species", "Environmental")),
                                  selectInput("SetsNoVarsTests","Select at Community",
                                              choices = vars_names,
                                              multiple = TRUE),


                                  ############################## BEGIN CAPSULES
                                  checkboxInput("getTypeDistribution", label = "Comparison of two distribution",value = FALSE),
                                  conditionalPanel("input.getTypeDistribution == true",

                                                   ####### One Sample
                                                   h5('Compararison two distributions'),

                                                   br(),
                                                   shinyBS::bsButton("runTwoDistKolm",  "Run",   icon = icon("upload", lib = "glyphicon"),  style = "primary"),
                                                   shinysky::busyIndicator("Loading...",wait = 0),
                                                   br(),

                                  ),

                                  ############################## END CAPSULES

                                  ############################## BEGIN CAPSULES
                                  checkboxInput("getSignedRankWilcoxon", label = "One Sample Wilcoxon signed-rank test",value = FALSE),
                                  conditionalPanel("input.getSignedRankWilcoxon == true",
                                                   h5('t test options'),
                                                   numericInput(inputId = "muTestWil",
                                                                label = "Theorical median:",
                                                                min = 0,
                                                                max = 1000000,
                                                                value = 0),
                                                   h5('Comparing signed-rank test'),
                                                   br(),
                                                   shinyBS::bsButton("runOneSampleWilcoxon", "Run",  icon = icon("upload", lib = "glyphicon"),style = "primary"),
                                                   shinysky::busyIndicator("Loading...",wait = 0),
                                                   br(),

                                  ),

                                  ############################## END CAPSULES

                                  ############################## BEGIN CAPSULES
                                  checkboxInput("getTwoNoParametricSample",label = "Comparison two samples",value = FALSE),
                                  conditionalPanel("input.getTwoNoParametricSample == true",
                                                   shiny::radioButtons("wc_testNoParamTest",
                                                                       label =  "Select a resolution",
                                                                       choices = c('Mann Whitney Test '='MannWhitneyTest',
                                                                                   'Sign Test'='SignTest',
                                                                                   'Wilcoxon Signed Rank Test'='WilcoxonSigned')),
                                                   br(),
                                                   shinyBS::bsButton("runTwoSamplesNoParam",
                                                            "Load niche layers",
                                                            icon = icon("upload",
                                                                        lib = "glyphicon"),
                                                            style = "primary"),
                                                   shinysky::busyIndicator("Loading...",wait = 0),
                                                   br()),
                                  ############################## END CAPSULES
                                  ############################## BEGIN CAPSULES
                                  checkboxInput("getKNoParametricSample", label = "Comparison K-samples",value = FALSE),
                                  conditionalPanel("input.getKNoParametricSample == true",
                                                   selectInput("wc_testKNoParamTest",label = "Select a test",
                                                               choices = c("Kruskal-Wallis test"="getKrukalTest",
                                                                           "Friedman's test"="getFriedmanTest",
                                                                           "Multiple Comparison (sort)"="getMultipleCompa")),


                                                   conditionalPanel("input.wc_testKNoParamTest=='getKrukalTest'",
                                                                    shiny::radioButtons("wc_testNoParamTest",
                                                                                        label =  "Select a post-ho method",
                                                                                        choices = c('None'='none',
                                                                                                    "Dunn's Test"='SignTest',
                                                                                                    "Dunn's Test with Bonferroni"='dunnBonferroni',
                                                                                                    'Tukey and Kramer (Nemenyi) Test'='nemenyiTest',
                                                                                                    'Nemenyi Test with Chisquare'='nemenyiTest',
                                                                                                    "Conover's Test"='conoverTest',
                                                                                                    "Conover's Test with Bonferroni"='conoverBonferroni'
                                                                                                    )),
                                                   ),
                                                   conditionalPanel("input.wc_testKNoParamTest=='getFriedmanTest'",
                                                                    shiny::radioButtons("wc_testNoParamTest",
                                                                                        label =  "Select a post-ho method",
                                                                                        choices = c('None'='none',
                                                                                                    'Nemenyi Test'='friedmanNemenyiTest',
                                                                                                    "Conover's Test"='friedmanConoverTest')),
                                                   ),

                                                   br(),
                                                   shinyBS::bsButton("runParMeans","Run",icon = icon("upload", lib = "glyphicon"),style = "primary"),
                                                   shinysky::busyIndicator("Loading...",wait = 0),
                                                   br(),
                                  ),
                                  ############################## END CAPSULES
                                  br(),

                                ),
                                mainPanel(
                                  h4('No Parametric Tests'),
                                  br(),
                                  #verbatimTextOutput(outputId = "rendertwoDistribution"),
                                  verbatimTextOutput(outputId = "rendertwoDistribution"),
                                  verbatimTextOutput(outputId = "renderOneWilcox"),
                                  verbatimTextOutput(outputId = "rendertwoSampleNoParam")

                                )
)




