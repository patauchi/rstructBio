layer_names_kmeans <- c("Extract sites "=1)

ini_Cluster <- sidebarLayout(position = 'left',
                         sidebarPanel(
                           h3("Cluster Analysis"),
                           br(),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),
                           p(""),
                           br(),

                           h4("Standarization Data"),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),

                           selectInput("StandMethods", "Choosing method for data standarization",
                                       choices = c("Total"="total",
                                                   "Maximum"="max",
                                                   "Frequency"="frequency",
                                                   "Normalize"="normalize",
                                                   "Ranks"="rank",
                                                   "Standardize"="standardize",
                                                   "Presence / Absence"="pa",
                                                   "Chi square"="chi.square",
                                                   "Hellinger" = "hellinger",
                                                   "Logaritmico" = "log")),


                           h4("Distance Computation"),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),

                           selectInput("DistanceMethod", "Choosing distance method",
                                       choices = c("Manhattan"="manhattan",
                                                   "Euclidean"="euclidean",
                                                   "Camberra"="camberra",
                                                   "Clark"="clark",
                                                   "Bray"="bray",
                                                   "Kulczynski"="kulczynski",
                                                   "Jaccard"="jaccard",
                                                   "Gower"="gower",
                                                   "AltGower"="altgower",
                                                   "Morisita"="morisita",
                                                   "Horn"="horn",
                                                   "mountford"="Mountford",
                                                   "Raup"="raup",
                                                   "Binomial"="binomial",
                                                   "Chao"="chao",
                                                   "Mahalanobis"="mahalanobis")),

                           h4("Clustering Algorithm"),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),

                           selectInput("ClustMethods", "Choosing the right algorithm",
                                       choices = c("Ward D"="ward.D",
                                                   "Ward D2"="ward.D2",
                                                   "Single"="single",
                                                   "Complete"="complete",
                                                   "UPGMA"="average",
                                                   "WPGMA"="mcquitty",
                                                   "WPGMC"="median",
                                                   "UPGMC"="centroid")),

                           shinyBS::bsButton("run_cluster",  "Run",   icon = icon("upload", lib = "glyphicon"),  style = "primary"),
                           br(),
                           width=4),
                         mainPanel(
                           h4("Output Clustering", align='center'),
                           br(),
                           plotOutput('plotDendro')
                         ))
