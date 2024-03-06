print("Loading module_M...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_M <- 
    wellPanel(
        h4("M. サマリー"),
        width = 9,
        
        fluidRow(
            column(
                width = 6,
                numericInput(
                    inputId = "summary_feeding_100",
                    label = "経腸栄養 100mL/kg/day 達成日齢",
                    min = 0,
                    max = 999,
                    value = NA,
                ),
            ),
            column(
                width = 6,
                selectInput(
                    inputId = "summary_anemia_RBCtransfusion",
                    label = "赤血球輸血",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "summary_anemia_RBCtransfusion"
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
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "summary_feeding_breastMilk",
                    label = "母乳の割合（%）",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "summary_feeding_breastMilk"
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
                    inputId = "summary_feeding_breastmilk_donorMilk",
                    label = "ドナーミルクの利用",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "summary_feeding_breastmilk_donorMilk"
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
                    condition = "input.summary_feeding_breastmilk_donorMilk == 1",
                    selectInput(
                        inputId = "summary_feeding_breastmilk_donorMilkBank",
                        label = "母乳バンクの利用",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "summary_feeding_breastmilk_donorMilkBank"
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
                width = 6,
                selectInput(
                    inputId = "summary_anemia_EPO",
                    label = "エリスロポエチン投与",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "summary_anemia_EPO"
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
                    condition = "input.summary_anemia_EPO == 1",
                    
                    selectInput(
                        inputId = "summary_anemia_EPO_purpose",
                        label = "エリスロポエチン投与目的",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "summary_anemia_EPO_purpose"
                            ) |> 
                            dplyr::select(description, value) |> 
                            tibble::deframe(),
                        selected = NA_integer_,
                        multiple = TRUE,
                    ),
                ),
            ),
        ),
    )