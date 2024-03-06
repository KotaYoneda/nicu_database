print("Loading module_E...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_E <- 
    wellPanel(
        h4("E. 新生児呼吸器疾患"),
        width = 9,
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "pulmonary_RDS",
                    label = "呼吸窮迫症候群",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pulmonary_RDS"
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
                    inputId = "pulmonary_airleak",
                    label = "空気漏出症候群",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pulmonary_airleak"
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
                    condition = "input.pulmonary_airleak == 1",
                    selectInput(
                        inputId = "pulmonary_airleak_thoracentesis",
                        label = "空気漏出症候群胸腔穿刺",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pulmonary_airleak_thoracentesis"
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
                    inputId = "pulmonary_hemorrhage",
                    label = "肺出血",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pulmonary_hemorrhage"
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
                    inputId = "pulmonary_PPHN",
                    label = "新生児遷延性肺高血圧症",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pulmonary_PPHN"
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
                numericInput(
                    inputId = "pulmonary_oxygen",
                    label = "酸素投与日数",
                    min = 0,
                    max = 999,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "pulmonary_CPAP",
                    label = "CPAP使用日数",
                    min = 0,
                    max = 999,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "pulmonary_MV",
                    label = "人工換気使用日数",
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
                    inputId = "pulmonary_HFO",
                    label = "HFO使用",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pulmonary_HFO"
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
                    condition = "input.pulmonary_HFO == 1",
                    selectInput(
                        inputId = "pulmonary_HFO_timing",
                        label = "HFO使用時期",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pulmonary_HFO_timing"
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
                numericInput(
                    inputId = "pulmonary_STA",
                    label = "サーファクタント投与回数",
                    min = 0,
                    max = 99,
                    value = NA,
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 6,
                selectInput(
                    inputId = "pulmonary_NAVA",
                    label = "NAVA 使用",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pulmonary_NAVA"
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
                    condition = "input.pulmonary_NAVA == 1",
                    selectInput(
                        inputId = "pulmonary_NAVA_method",
                        label = "NAVA 使用方法",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pulmonary_NAVA_method"
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
                numericInput(
                    inputId = "pulmonary_NO",
                    label = "一酸化窒素吸入療法日数",
                    min = 0,
                    max = 999,
                    value = NA,
                ),
            ),
            column(
                width = 6,
                conditionalPanel(
                    condition = "input.pulmonary_NO >= 1",
                    selectInput(
                        inputId = "pulmonary_NO_purpose",
                        label = "一酸化窒素吸入療法目的",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pulmonary_NO_purpose"
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
                    inputId = "pulmonary_CLD",
                    label = "慢性肺疾患",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pulmonary_CLD"
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
                    condition = "input.pulmonary_CLD == 1",
                    selectInput(
                        inputId = "pulmonary_CLD_type",
                        label = "慢性肺疾患病型",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pulmonary_CLD_type"
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
                    condition = "input.pulmonary_CLD == 1",
                    selectInput(
                        inputId = "pulmonary_CLD_CXR",
                        label = "慢性肺疾患胸部X線",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pulmonary_CLD_CXR"
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
                    inputId = "pulmonary_CLD_steroid",
                    label = "ステロイド投与（予防を含む）",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pulmonary_CLD_steroid"
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
                    condition = "input.pulmonary_CLD_steroid == 1",
                    selectInput(
                        inputId = "pulmonary_CLD_ICS",
                        label = "予防的吸入ステロイド",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pulmonary_CLD_ICS"
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
                    inputId = "pulmonary_CLD_36wk",
                    label = "修正36週での呼吸補助",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pulmonary_CLD_36wk"
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
                    condition = "input.pulmonary_CLD_36wk == 1",
                    selectInput(
                        inputId = "pulmonary_CLD_36wk_support",
                        label = "修正36週での呼吸補助内容",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pulmonary_CLD_36wk_support"
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
                    condition = "input.pulmonary_CLD_36wk == 1",
                    numericInput(
                        inputId = "pulmonary_CLD_36wk_O2",
                        label = "修正36週FiO2（%）",
                        min = 0,
                        max = 100,
                        value = NA,
                    ),
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "pulmonary_CLD_40wk_support",
                    label = "修正40週での呼吸補助",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "pulmonary_CLD_40wk_support"
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
                    condition = "input.pulmonary_CLD_40wk_support == 1",
                    selectInput(
                        inputId = "pulmonary_CLD_40wk_support_method",
                        label = "修正40週での呼吸補助内容",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "pulmonary_CLD_40wk_support_method"
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