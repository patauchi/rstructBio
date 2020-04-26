
# App Settings & Materials (tutorials and intro to the app)
osSystem <- Sys.info()["sysname"]
#

ini_collinearity <- sidebarLayout(position = "left",
                                  sidebarPanel(
                                  h4("Niche layers"),
                                  p(paste0("One ne of the most important",
                                                    "things for your data analysis",
                                                    " in NTB is to select the folder",
                                                    " with the raster layers that you",
                                                    "will use as niche variables.")),
                                  br(),
                                  p("Please select the folder of raster",
                                             " layers; notice that all of them",
                                             " need to be in the same resolution",
                                             " and extension."),
                                  p("The supported raster formats are: ",".asc",
                                             ".bil",",",".tif",",",".nc.",
                                             ",",".sdat",",",".img"),
                                  br(),
                                           #directoryInput('ras_layers_directory', label = 'Select a raster layers directory'),
                                  h4("Dataset"),

                                  selectInput("datasetBx",
                                              label="Choose a dataset :",
                                              choices=c("Species", "Environmental")),
                                  selectInput("SetsBox","Select at Community",
                                              choices = vars_names,
                                              multiple = TRUE),


                                           ############################## BEGIN CAPSULES
                                  checkboxInput("getCorrelation",label = "Correlation",value = FALSE),
                                  conditionalPanel("input.getCorrelation == true",
                                                  shiny::radioButtons("wc_resol",
                                                  label =  "Select a resolution",
                                                  choices = c('Pearson '='pearson',
                                                              'Spearman'='spearman',
                                                              'Kendall Mann'='kendall')),
                                            br(),
                                            shinyBS::bsButton("loadNicheLayers",
                                                     "Load niche layers",
                                                      icon = icon("upload",
                                                      lib = "glyphicon"),
                                                      style = "primary"),
                                            shinysky::busyIndicator("Loading...",wait = 0),
                                            br()),
                                           ############################## END CAPSULES
                                           br(),
                                  width=3),
                                         mainPanel(
                                           #htmlOutput("page"),
                                           #plotOutput("niche_layers"),
                                           conditionalPanel("input.load_projLayers == true ||
                                              input.load_projLayers_win == true",
                                                        #    plotOutput("niche_layers_proj")
                                           )
                                         )
)
