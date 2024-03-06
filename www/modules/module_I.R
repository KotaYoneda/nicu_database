print("Loading module_I...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_I <- 
    wellPanel(
        h4("I. 新生児消化器疾患"),
        width = 9,
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "gastrointestinal_hyperalimentation",
                    label = "中心静脈栄養",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "gastrointestinal_hyperalimentation"
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
                    inputId = "gastrointestinal_NEC",
                    label = "新生児壊死性腸炎",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "gastrointestinal_NEC"
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
                    inputId = "gastrointestinal_perforation",
                    label = "特発性消化管穿孔",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "gastrointestinal_perforation"
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
                    inputId = "gastrointestinal_meconuim",
                    label = "胎便関連イレウス",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "gastrointestinal_meconuim"
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
                width = 8,
                conditionalPanel(
                    condition = "input.gastrointestinal_meconuim == 1",
                    selectInput(
                        inputId = "gastrointestinal_meconuim_treatment",
                        label = "胎便関連イレウス処置",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "gastrointestinal_meconuim_treatment"
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