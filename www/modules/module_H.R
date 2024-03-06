print("Loading module_H...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_H <- 
    wellPanel(
        h4("H. 新生児感染症"),
        width = 9,
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "infectious_intrauterine",
                    label = "子宮内感染症",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "infectious_intrauterine"
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
                    inputId = "infectious_sepsis",
                    label = "敗血症",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "infectious_sepsis"
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
                    condition = "input.infectious_sepsis == 1",
                    numericInput(
                        inputId = "infectious_sepsis_times",
                        label = "敗血症回数",
                        min = 0,
                        max = 99,
                        value = NA,
                    ),
                ),
            ),
        ),
        
        conditionalPanel(
            condition = "input.infectious_sepsis_times >= 1",
            
            wellPanel(
                
                h5("敗血症初回"),
                
                fluidRow(
                    column(
                        width = 4,
                        numericInput(
                            inputId = "infectious_sepsis_onset_1st",
                            label = "発症時日齢",
                            min = 0,
                            max = 99,
                            value = NA,
                        ),
                    ),
                    column(
                        width = 8,
                        selectInput(
                            inputId = "infectious_sepsis_pathogen_1st",
                            label = "起炎菌",
                            choices = df_choices |> 
                                dplyr::filter(
                                    item == "infectious_sepsis_pathogen_1st"
                                ) |> 
                                dplyr::select(description, value) |> 
                                dplyr::add_row(
                                    description = unselected, 
                                    value = NA_integer_
                                ) |> 
                                tibble::deframe(),
                            multiple = TRUE,
                        ),
                    ),
                ),
            ),
        ),
        
        conditionalPanel(
            condition = "input.infectious_sepsis_times >= 2",
            
            wellPanel(
                
                h5("敗血症 2 回目"),
                
                fluidRow(
                    column(
                        width = 4,
                        numericInput(
                            inputId = "infectious_sepsis_onset_1st",
                            label = "発症時日齢",
                            min = 0,
                            max = 99,
                            value = NA,
                        ),
                    ),
                    column(
                        width = 8,
                        selectInput(
                            inputId = "infectious_sepsis_pathogen_2nd",
                            label = "起炎菌",
                            choices = df_choices |> 
                                dplyr::filter(
                                    item == "infectious_sepsis_pathogen_2nd"
                                ) |> 
                                dplyr::select(description, value) |> 
                                tibble::deframe(),
                            multiple = TRUE,
                        ),
                    ),
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 6,
                selectInput(
                    inputId = "infectious_meningitis",
                    label = "髄膜炎",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "infectious_meningitis"
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
                    condition = "infectious_meningitis == 1",
                    numericInput(
                        inputId = "infectious_meningitis_times",
                        label = "髄膜炎回数",
                        min = 0,
                        max = 99,
                        value = NA,
                    ),
                ),
            ),
        ),
        
        conditionalPanel(
            condition = "input.infectious_meningitis_times >= 1",
            
            wellPanel(
                
                h5("髄膜炎初回"),
                
                fluidRow(
                    column(
                        width = 4,
                        numericInput(
                            inputId = "infectious_meningitis_onset_1st",
                            label = "発症時日齢",
                            min = 0,
                            max = 99,
                            value = NA,
                        ),
                    ),
                    column(
                        width = 8,
                        selectInput(
                            inputId = "infectious_meningitis_pathogen_1st",
                            label = "起炎菌",
                            choices = df_choices |> 
                                dplyr::filter(
                                    item == "infectious_meningitis_pathogen_1st"
                                ) |> 
                                dplyr::select(description, value) |> 
                                tibble::deframe(),
                            multiple = TRUE,
                        ),
                    ),
                ),
            ),
        ),
        
        conditionalPanel(
            condition = "input.infectious_meningitis_times >= 2",
            
            wellPanel(
                
                h5("髄膜炎 2 回目"),
                
                fluidRow(
                    column(
                        width = 4,
                        numericInput(
                            inputId = "infectious_meningitis_onset_2nd",
                            label = "発症時日齢",
                            min = 0,
                            max = 99,
                            value = NA,
                        ),
                    ),
                    column(
                        width = 8,
                        selectInput(
                            inputId = "infectious_meningitis_pathogen_2nd",
                            label = "起炎菌",
                            choices = df_choices |> 
                                dplyr::filter(
                                    item == "infectious_meningitis_pathogen_2nd"
                                ) |> 
                                dplyr::select(description, value) |> 
                                tibble::deframe(),
                            multiple = TRUE,
                        ),
                    ),
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