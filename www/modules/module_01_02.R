print("Loading module_01_02...")

module_01_02 <- 
    tabPanel(
        title = h4("施設データ"),
        br(),
        
        fluidPage(
            sidebarLayout(
                sidebarPanel(
                    width = 3,
                    textInput(
                        inputId = "facility_id",
                        label = "施設 ID",
                        value = NA,
                    ),
                    numericInput(
                        inputId = "birth_year",
                        label = "出生年",
                        value = NA,
                    ),
                    textAreaInput(
                        inputId = "notes",
                        label = "Notes",
                        rows = 20
                    ),
                    fluidRow(
                        column(
                            width = 6,
                            actionButton(
                                inputId = "load_record_neonates",
                                label = "Load",
                                width = "100%",
                            ),
                        ),
                        column(
                            width = 6,
                            actionButton(
                                inputId = "save_record_neonates",
                                label = "Save",
                                width = "100%",
                                class = "btn btn-primary"
                            ),
                        ),
                    ),
                ),
                
                
                mainPanel(
                    
                    module_A,
                    
                ),
            )
        )
    )