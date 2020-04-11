layer_names_kmeans <- c("Extract sites "=1)

ini_Cluster <- sidebarLayout(position = 'left',
                         sidebarPanel(
                           h3("Diversity Index"),
                           br(),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),
                           p(""),
                           br(),
                           #textInput("name","Enter your name", ""),
                           #textInput("age","Enter your age",""),


                           h4("data Loading"),
                           selectInput("datasets",
                                       label="Choose a dataset :",
                                       choices=c("Species", "Environmental")),



                           h4("Diversity Plot"),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),

                           selectInput("StandMethods", "Select the Standardization Methods",
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


                           h4("Diversity Plot"),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),

                           selectInput("DistanceMethod", "Select the diverisity index",
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

                           h4("Diversity Plot"),
                           p("This application was create to analyze and visualize ecological data",
                             style="font-size:13px"),

                           selectInput("ClustMethods", "Select the diverisity index",
                                       choices = c("Ward D"="ward.D",
                                                   "Ward D2"="ward.D2",
                                                   "Single"="single",
                                                   "Complete"="complete",
                                                   "UPGMA"="average",
                                                   "WPGMA"="mcquitty",
                                                   "WPGMC"="median",
                                                   "UPGMC"="centroid")),

                           actionButton("run_dendro","Go!!!",styleclass = "primary"),
                           busyIndicator("Loading...",wait = 0),




                           width=3),

                         mainPanel(
                           #DT::dataTableOutput("user_table"),
                           #textOutput("myname"),
                           #textOutput("myage")
                           h4("Dendrogram"),
                           br(),
                           plotOutput('plotDendro')



                         ))
