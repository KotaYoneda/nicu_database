print("Loading module_J...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_J <- 
    wellPanel(
        h4("J. 聴覚スクリーニング"),
        width = 9,
        
        fluidRow(
            column(
                width = 12,
                selectInput(
                    inputId = "hearing_screening_result",
                    label = "聴覚スクリーニング",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "hearing_screening_result"
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