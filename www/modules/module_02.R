print("Loading module_02...")

module_02 <- 
    tabPanel(
        title = "Database",
        titlePanel("Database for NRNJ Database"),
        tabsetPanel(
            type = "tabs",
            
            tabPanel(
                title = "neonates",
                h3("'neonates' table"),
                fluidPage(
                    sidebarLayout(
                        sidebarPanel(
                            width = 3,
                            actionButton(
                                inputId = "table_downloader_neonates",
                                label = "Download CSV",
                                width = "100%"
                            ),
                            hr(),
                            fileInput(
                                inputId = "table_uploader_neonates",
                                label = "Upload a CSV file",
                                buttonLabel = "Choose File",
                            ),
                        ),
                        mainPanel(
                            width = 9,
                            dataTableOutput("table_neonates"),
                        ),
                    )
                )
            ),  # tabPanel
            
            tabPanel(
                title = "facility",
                h3("'facility' table"),
                fluidPage(
                    sidebarLayout(
                        sidebarPanel(
                            width = 3,
                            actionButton(
                                inputId = "table_downloader_facility",
                                label = "Download CSV",
                                width = "100%"
                            ),
                            hr(),
                            fileInput(
                                inputId = "table_uploader_facility",
                                label = "Upload a CSV file",
                                buttonLabel = "Choose File",
                            ),
                        ),
                        mainPanel(
                            width = 9,
                            dataTableOutput("table_facility"),
                        ),
                    )
                )
            )
        )
    )
