print("Loading module_O...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_O <- 
    wellPanel(
        h4("O. 退院時の発達予後見込み"),
        width = 9,
        
        fluidRow(
            column(
                width = 6,
                selectInput(
                    inputId = "disabled_motor",
                    label = "運動障害の発生見込み",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "disabled_motor"
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
                selectInput(
                    inputId = "disabled_vision",
                    label = "視力障害の発生見込み",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "disabled_vision"
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
    )