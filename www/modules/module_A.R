print("Loading module_A...")

module_A <- 
    wellPanel(
        h4("A. 母体情報"),
        width = 9,
        numericInput(
            inputId = "maternal_age",
            label = "母年齢",
            min = 1,
            max = 99,
            value = NA,
        ),
        shinyBS::bsTooltip("action", "ここに詳細な説明を書きます！", "right"),
        numericInput(
            inputId = "maternal_gravida",
            label = "妊娠回数",
            min = 1,
            max = 99,
            value = NA,
        ),
        numericInput(
            inputId = "maternal_parity",
            label = "分娩回数",
            min = 0,
            max = 99,
            value = NA,
        ),
        selectInput(
            inputId = "maternal_comorbidity_main",
            label = "母体基礎疾患",
            choices = c(
                "All ages" = "malaria_tot",
                "0-4 yrs" = "malaria_rdt_0-4",
                "5-14 yrs" = "malaria_rdt_5-14",
                "15+ yrs" = "malaria_rdt_15"
            ), 
            multiple = TRUE,
        ),
        numericInput(
            inputId = "maternal_ART",
            label = "母体不妊治療",
            min = 1,
            max = 9,
            value = NA,
        ),
        numericInput(
            inputId = "maternal_foreigner",
            label = "児の母が外国籍",
            min = 1,
            max = 9,
            value = NA,
        ),
    )