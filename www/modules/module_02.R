print("Loading module_02...")

module_02 <- 
    tabPanel(
        title = "Facility",
        titlePanel("施設データ登録"),
        sidebarLayout(
            sidebarPanel(
                width = 3,
                
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
                
                hr(),
                
                textInput(
                    inputId = "facility_id",
                    label = "施設 ID",
                    value = NA,
                ),
                numericInput(
                    inputId = "birth_year",
                    label = "対象年",
                    value = NA,
                ),
                textAreaInput(
                    inputId = "notes",
                    label = "Notes",
                    rows = 5,
                ),
            ),
            
            mainPanel(
                module_facility,
            ),
        ),
    )

