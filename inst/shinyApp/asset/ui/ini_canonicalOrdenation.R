# App Settings & Materials (tutorials and intro to the app)
osSystem <- Sys.info()["sysname"]
#
ini_canonicalOrdenation <- sidebarLayout(position = "left",
                                   sidebarPanel(
                                     titlePanel("NicheToolBox"),
                                     #h3('Welcome to NTB'),
                                     br(),
                                     p(paste0("This application has some tools",
                                              " to analyze and visualize the niche. ",
                                              "In this page you will find th NTB",
                                              " settings of the app.")),

                                     #h3('Settings'),
                                     br(),
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


                                     ########################3##### BEGIN CAPSULES
                                     checkboxInput("getRDA",label = "Redundancy Analysis (RDA)",value = FALSE),
                                     conditionalPanel("input.getRDA == true",
                                                      conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                                       shiny::radioButtons("wc_var",
                                                                                           label = "Select an option",
                                                                                           choices = c("Bioclim"="bio",
                                                                                                       "Min temperature
                                                                                               "='tmin',
                                                                                                       "Max temperature
                                                                                               "='tmax',
                                                                                                       "Precipitation"=
                                                                                                         'prec')),
                                                                       shiny::radioButtons("wc_resol",
                                                                                           label =  "Select a resolution",
                                                                                           choices = c("10 minutes"=10,
                                                                                                       "5 minutes"=5,
                                                                                                       "2.5 minutes"=2.5,
                                                                                                       "30 seconds"=0.5))
                                                      ),
                                                      br(),
                                                      bsButton("loadNicheLayers",
                                                               "Load niche layers",
                                                               icon = icon("upload",
                                                                           lib = "glyphicon"),
                                                               style = "primary"),
                                                      busyIndicator("Loading...",wait = 0),
                                                      br(),

                                     ),

                                     ########################3##### END CAPSULES
                                     ########################3##### BEGIN CAPSULES
                                     checkboxInput("getCA",label = "Correspondence Analysis (CA)",value = FALSE),
                                     conditionalPanel("input.getCA == true",
                                                      conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                                       shiny::radioButtons("wc_var",
                                                                                           label = "Select an option",
                                                                                           choices = c("Bioclim"="bio",
                                                                                                       "Min temperature
                                                                                               "='tmin',
                                                                                                       "Max temperature
                                                                                               "='tmax',
                                                                                                       "Precipitation"=
                                                                                                         'prec')),
                                                                       shiny::radioButtons("wc_resol",
                                                                                           label =  "Select a resolution",
                                                                                           choices = c("10 minutes"=10,
                                                                                                       "5 minutes"=5,
                                                                                                       "2.5 minutes"=2.5,
                                                                                                       "30 seconds"=0.5))
                                                      ),
                                                      br(),
                                                      bsButton("loadNicheLayers",
                                                               "Load niche layers",
                                                               icon = icon("upload",
                                                                           lib = "glyphicon"),
                                                               style = "primary"),
                                                      busyIndicator("Loading...",wait = 0),
                                                      br(),

                                     ),

                                     ########################3##### END CAPSULES
                                     ########################3##### BEGIN CAPSULES
                                     checkboxInput("getCCA",label = "Canonical Correspondence Analysis (CCA)",value = FALSE),
                                     conditionalPanel("input.getCCA == true",
                                                      conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                                       shiny::radioButtons("wc_var",
                                                                                           label = "Select an option",
                                                                                           choices = c("Bioclim"="bio",
                                                                                                       "Min temperature
                                                                                               "='tmin',
                                                                                                       "Max temperature
                                                                                               "='tmax',
                                                                                                       "Precipitation"=
                                                                                                         'prec')),
                                                                       shiny::radioButtons("wc_resol",
                                                                                           label =  "Select a resolution",
                                                                                           choices = c("10 minutes"=10,
                                                                                                       "5 minutes"=5,
                                                                                                       "2.5 minutes"=2.5,
                                                                                                       "30 seconds"=0.5))
                                                      ),
                                                      br(),
                                                      bsButton("loadNicheLayers",
                                                               "Load niche layers",
                                                               icon = icon("upload",
                                                                           lib = "glyphicon"),
                                                               style = "primary"),
                                                      busyIndicator("Loading...",wait = 0),
                                                      br(),

                                     ),

                                     ########################3##### END CAPSULES
                                     ########################3##### BEGIN CAPSULES
                                     checkboxInput("getLDA",label = "Linear Discriminant Analysis (LDA)",value = FALSE),
                                     conditionalPanel("input.getLDA == true",
                                                      conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                                       shiny::radioButtons("wc_var",
                                                                                           label = "Select an option",
                                                                                           choices = c("Bioclim"="bio",
                                                                                                       "Min temperature
                                                                                               "='tmin',
                                                                                                       "Max temperature
                                                                                               "='tmax',
                                                                                                       "Precipitation"=
                                                                                                         'prec')),
                                                                       shiny::radioButtons("wc_resol",
                                                                                           label =  "Select a resolution",
                                                                                           choices = c("10 minutes"=10,
                                                                                                       "5 minutes"=5,
                                                                                                       "2.5 minutes"=2.5,
                                                                                                       "30 seconds"=0.5))
                                                      ),
                                                      br(),
                                                      bsButton("loadNicheLayers",
                                                               "Load niche layers",
                                                               icon = icon("upload",
                                                                           lib = "glyphicon"),
                                                               style = "primary"),
                                                      busyIndicator("Loading...",wait = 0),
                                                      br(),

                                     ),

                                     ########################3##### END CAPSULES
                                     ########################3##### BEGIN CAPSULES
                                     checkboxInput("getPRC",label = "Principal Response Curves (PRC)",value = FALSE),
                                     conditionalPanel("input.getPRC == true",
                                                      conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                                       shiny::radioButtons("wc_var",
                                                                                           label = "Select an option",
                                                                                           choices = c("Bioclim"="bio",
                                                                                                       "Min temperature
                                                                                               "='tmin',
                                                                                                       "Max temperature
                                                                                               "='tmax',
                                                                                                       "Precipitation"=
                                                                                                         'prec')),
                                                                       shiny::radioButtons("wc_resol",
                                                                                           label =  "Select a resolution",
                                                                                           choices = c("10 minutes"=10,
                                                                                                       "5 minutes"=5,
                                                                                                       "2.5 minutes"=2.5,
                                                                                                       "30 seconds"=0.5))
                                                      ),
                                                      br(),
                                                      bsButton("loadNicheLayers",
                                                               "Load niche layers",
                                                               icon = icon("upload",
                                                                           lib = "glyphicon"),
                                                               style = "primary"),
                                                      busyIndicator("Loading...",wait = 0),
                                                      br(),

                                     ),

                                     ########################3##### END CAPSULES
                                     ########################3##### BEGIN CAPSULES
                                     checkboxInput("getCoCA",label = "Co-correspondence Analysis (CoCA)",value = FALSE),
                                     conditionalPanel("input.getCoCA == true",
                                                      conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                                       shiny::radioButtons("wc_var",
                                                                                           label = "Select an option",
                                                                                           choices = c("Bioclim"="bio",
                                                                                                       "Min temperature
                                                                                               "='tmin',
                                                                                                       "Max temperature
                                                                                               "='tmax',
                                                                                                       "Precipitation"=
                                                                                                         'prec')),
                                                                       shiny::radioButtons("wc_resol",
                                                                                           label =  "Select a resolution",
                                                                                           choices = c("10 minutes"=10,
                                                                                                       "5 minutes"=5,
                                                                                                       "2.5 minutes"=2.5,
                                                                                                       "30 seconds"=0.5))
                                                      ),
                                                      br(),
                                                      bsButton("loadNicheLayers",
                                                               "Load niche layers",
                                                               icon = icon("upload",
                                                                           lib = "glyphicon"),
                                                               style = "primary"),
                                                      busyIndicator("Loading...",wait = 0),
                                                      br(),

                                     ),

                                     ########################3##### END CAPSULES
                                     ########################3##### BEGIN CAPSULES
                                     checkboxInput("getCCorA",label = "Canonical Correlation Analysis (CCorA)",value = FALSE),
                                     conditionalPanel("input.getCCorA == true",
                                                      conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                                       shiny::radioButtons("wc_var",
                                                                                           label = "Select an option",
                                                                                           choices = c("Bioclim"="bio",
                                                                                                       "Min temperature
                                                                                               "='tmin',
                                                                                                       "Max temperature
                                                                                               "='tmax',
                                                                                                       "Precipitation"=
                                                                                                         'prec')),
                                                                       shiny::radioButtons("wc_resol",
                                                                                           label =  "Select a resolution",
                                                                                           choices = c("10 minutes"=10,
                                                                                                       "5 minutes"=5,
                                                                                                       "2.5 minutes"=2.5,
                                                                                                       "30 seconds"=0.5))
                                                      ),
                                                      br(),
                                                      bsButton("loadNicheLayers",
                                                               "Load niche layers",
                                                               icon = icon("upload",
                                                                           lib = "glyphicon"),
                                                               style = "primary"),
                                                      busyIndicator("Loading...",wait = 0),
                                                      br(),

                                     ),

                                     ########################3##### END CAPSULES
                                     ########################3##### BEGIN CAPSULES
                                     checkboxInput("getMFA",label = "Multiple Factor Analysis (MFA)",value = FALSE),
                                     conditionalPanel("input.getMFA == true",
                                                      conditionalPanel("input.env_data=='wc' ||
                                                               input.env_data=='wc_future'",
                                                                       shiny::radioButtons("wc_var",
                                                                                           label = "Select an option",
                                                                                           choices = c("Bioclim"="bio",
                                                                                                       "Min temperature
                                                                                               "='tmin',
                                                                                                       "Max temperature
                                                                                               "='tmax',
                                                                                                       "Precipitation"=
                                                                                                         'prec')),
                                                                       shiny::radioButtons("wc_resol",
                                                                                           label =  "Select a resolution",
                                                                                           choices = c("10 minutes"=10,
                                                                                                       "5 minutes"=5,
                                                                                                       "2.5 minutes"=2.5,
                                                                                                       "30 seconds"=0.5))
                                                      ),
                                                      br(),
                                                      bsButton("loadNicheLayers",
                                                               "Load niche layers",
                                                               icon = icon("upload",
                                                                           lib = "glyphicon"),
                                                               style = "primary"),
                                                      busyIndicator("Loading...",wait = 0),
                                                      br(),

                                     ),

                                     ########################3##### END CAPSULES



                                     br(),

                                   ),
                                   mainPanel(
                                     #htmlOutput("page"),
                                     plotOutput("niche_layers"),
                                     conditionalPanel("input.load_projLayers == true ||
                                              input.load_projLayers_win == true",
                                                      plotOutput("niche_layers_proj")
                                     )
                                   )
)
