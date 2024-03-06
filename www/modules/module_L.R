print("Loading module_L...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_L <- 
    wellPanel(
        h4("L. 診断"),
        width = 9,
        
        fluidRow(
            column(
                width = 6,
                selectInput(
                    inputId = "diagnosis_malformation",
                    label = "先天異常",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "diagnosis_malformation"
                        ) |> 
                        dplyr::select(description, value) |> 
                        dplyr::add_row(
                            description = unselected, 
                            value = NA_integer_
                        ) |> 
                        tibble::deframe(),
                    selected = NA_integer_,
                ),
            ),
            column(
                width = 6,
                conditionalPanel(
                    condition = "input.diagnosis_malformation == 1",
                    selectInput(
                        inputId = "diagnosis_malformation_surgery",
                        label = "先天異常手術",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "diagnosis_malformation_surgery"
                            ) |> 
                            dplyr::select(description, value) |> 
                            dplyr::add_row(
                                description = unselected, 
                                value = NA_integer_
                            ) |> 
                            tibble::deframe(),
                        selected = NA_integer_,
                    ),
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 12,
                conditionalPanel(
                    condition = "input.diagnosis_malformation == 1",
                    selectInput(
                        inputId = "diagnosis_malformation_disease",
                        label = "先天異常疾患名",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "cardiac_PDA_surgery"
                            ) |> 
                            dplyr::select(description, value) |> 
                            dplyr::add_row(
                                description = unselected, 
                                value = NA_integer_
                            ) |> 
                            tibble::deframe(),
                        selected = NA_integer_,
                    ),
                ),
            ),
        ),
    )