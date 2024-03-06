print("Loading module_N...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_N <- 
    wellPanel(
        h4("N. 退院情報"),
        width = 9,
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "discharge_transfer",
                    label = "急性期転院搬送",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "discharge_transfer"
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
                    condition = "input.discharge_transfer == 1",
                    textInput(
                        inputId = "discharge_transfer_purpose",
                        label = "転院搬送の理由",
                        placeholder = "（自由記載）",
                    ),
                ),
            ),
            column(
                width = 4,
                conditionalPanel(
                    condition = "input.discharge_transfer == 1",
                    numericInput(
                        inputId = "discharge_transfer_readmissionDay",
                        label = "再入院時生後日数",
                        min = 0,
                        max = 999,
                        value = NA,
                    ),
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 12,
                numericInput(
                    inputId = "discharge_day",
                    label = "退院時生後日数",
                    min = 0,
                    max = 999,
                    value = NA,
                ),
            ),
        ),
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "discharge_death",
                    label = "退院時死亡",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "discharge_death"
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
                    condition = "input.discharge_death == 1",
                    selectInput(
                        inputId = "discharge_autopsy",
                        label = "退院時剖検",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "discharge_autopsy"
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
            column(
                width = 4,
                conditionalPanel(
                    condition = "input.discharge_death == 1",
                    selectInput(
                        inputId = "discharge_causeOfDeath_code",
                        label = "退院時死亡原因",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "discharge_causeOfDeath_code"
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
        
        conditionalPanel(
            condition = "input.discharge_death == 2",
            fluidRow(
                column(
                    width = 4,
                    selectInput(
                        inputId = "discharge_home",
                        label = "退院時退院先",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "discharge_home"
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
                conditionalPanel(
                    condition = "input.discharge_home == 2",
                    column(
                        width = 4,
                        selectInput(
                            inputId = "discharge_to",
                            label = "退院時転送先",
                            choices = df_choices |> 
                                dplyr::filter(
                                    item == "discharge_to"
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
        ),
        
        conditionalPanel(
            condition = "input.discharge_death == 2",
            fluidRow(
                column(
                    width = 6,
                    
                    selectInput(
                        inputId = "discharge_HOT",
                        label = "退院時 HOT",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "discharge_HOT"
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
                        inputId = "discharge_tracheostomy",
                        label = "退院時気管切開",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "discharge_tracheostomy"
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
                numericInput(
                    inputId = "discharge_weight",
                    label = "退院時体重 (g)",
                    min = 0,
                    max = 99999,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "discharge_length",
                    label = "退院時身長 (cm)",
                    min = 0,
                    max = 999,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "discharge_HC",
                    label = "退院時頭囲 (cm)",
                    min = 0,
                    max = 999,
                    value = NA,
                ),
            ),
        ),
    )