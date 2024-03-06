print("Loading module_F...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_F <- 
    wellPanel(
        h4("F. 新生児循環器疾患"),
        width = 9,
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "cardiac_PDA",
                    label = "症候性の動脈管開存症",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "cardiac_PDA"
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
                    inputId = "cardiac_PDA_indomethacin",
                    label = "動脈管に対する NSAIDs",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "cardiac_PDA_indomethacin"
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
                    condition = "input.cardiac_PDA == 1",
                    selectInput(
                        inputId = "cardiac_PDA_surgery",
                        label = "動脈管に対する外科治療",
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
        
        fluidRow(
            column(
                width = 12,
                conditionalPanel(
                    condition = "input.cardiac_PDA_indomethacin == 1",
                    selectInput(
                        inputId = "cardiac_PDA_drug",
                        label = "動脈管に対する NSAIDs の種類",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "cardiac_PDA_drug"
                            ) |> 
                            dplyr::select(description, value) |> 
                            tibble::deframe(),
                        multiple = TRUE,
                    ),
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 12,
                selectInput(
                    inputId = "cardiac_lcc",
                    label = "晩期循環不全（ステロイド投与）",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "cardiac_lcc"
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