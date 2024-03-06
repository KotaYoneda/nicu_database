print("Loading module_01...")

module_01 <- 
    tabPanel(
        title = "Records",
        titlePanel("症例データ登録"),
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
                    inputId = "patient_id",
                    label = "患者 ID",
                    value = NA,
                ),
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
            ),
            
            
            mainPanel(
                tabsetPanel(
                    type = "tabs",
                    module_01_01,
                    module_01_02,
                    module_01_03,
                    module_01_04,
                    module_01_05,
                ),
            ),
        ),
    )

