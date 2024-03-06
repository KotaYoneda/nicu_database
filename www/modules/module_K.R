print("Loading module_K...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_K <- 
    wellPanel(
        h4("K. 未熟児網膜症"),
        width = 9,
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "rop_stage",
                    label = "未熟児網膜症の病期",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "rop_stage"
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
                width = 4,
                selectInput(
                    inputId = "rop_treatment",
                    label = "未熟児網膜症に対する治療",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "rop_treatment"
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
                width = 4,
                conditionalPanel(
                    condition = "input.rop_treatment == 1",
                    selectInput(
                        inputId = "rop_treatment_antiVEGF",
                        label = "抗VEGF抗体治療",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "rop_treatment_antiVEGF"
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