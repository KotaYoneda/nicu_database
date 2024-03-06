print("Loading module_B...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_B <- 
    wellPanel(
        h4("B. 妊娠合併症"),
        width = 9,
        
        fluidRow(
            column(
                width = 4,
                numericInput(
                    inputId = "pregnancy_multiple",
                    label = "胎児数",
                    min = 1,
                    max = 9,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                conditionalPanel(
                    condition = "input.pregnancy_multiple > 1",
                    numericInput(
                        inputId = "pregnancy_multiple_order",
                        label = "出生順位",
                        min = 1,
                        max = 9,
                        value = NA,
                    ),
                ),
            ),
            column(
                width = 4,
                conditionalPanel(
                    condition = "input.pregnancy_multiple > 1",
                    selectInput(
                        inputId = "pregnancy_plurarity",
                        label = "膜性（多胎の場合）",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pregnancy_plurarity"
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
                width = 4,
                selectInput(
                    inputId = "pregnancy_DM",
                    label = "糖尿病",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pregnancy_DM"
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
                    inputId = "pregnancy_chronicHypertension",
                    label = "慢性高血圧",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pregnancy_chronicHypertension"
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
                    inputId = "pregnancy_hypertension",
                    label = "妊娠高血圧・子癇発作",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pregnancy_hypertension"
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
                    inputId = "pregnancy_CAM_clinical",
                    label = "臨床的絨毛膜羊膜炎",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pregnancy_CAM_clinical"
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
                    inputId = "pregnancy_CAM_pathological",
                    label = "組織学的絨毛膜羊膜炎",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pregnancy_CAM_pathological"
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
                    condition = "input.pregnancy_CAM_pathological == 1",
                    selectInput(
                        inputId = "pregnancy_CAM_pathological_grade",
                        label = "組織学的絨毛膜羊膜炎分類",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pregnancy_CAM_pathological_grade"
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