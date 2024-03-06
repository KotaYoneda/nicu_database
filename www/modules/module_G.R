print("Loading module_G...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_G <- 
    wellPanel(
        h4("G. 新生児神経疾患"),
        width = 9,
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "neurologic_seizure",
                    label = "新生児けいれん",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neurologic_seizure"
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
                    condition = "input.neurologic_seizure == 1",
                    selectInput(
                        inputId = "neurologic_seizure_diagnosis",
                        label = "新生児けいれん診断",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "neurologic_seizure_diagnosis"
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
                selectInput(
                    inputId = "neurologic_IVH",
                    label = "脳室内出血",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neurologic_IVH"
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
        
        conditionalPanel(
            condition = "input.neurologic_IVH == 1",
            
            fluidRow(
                column(
                    width = 4,
                    selectInput(
                        inputId = "neurologic_IVH_grade",
                        label = "脳室内出血重症度",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "neurologic_IVH_grade"
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
                        inputId = "neurologic_IVH_grade_right",
                        label = "脳室内出血（右）",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "neurologic_IVH_grade_right"
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
                        inputId = "neurologic_IVH_grade_left",
                        label = "脳室内出血（左）",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "neurologic_IVH_grade_left"
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
                    width = 6,
                    selectInput(
                        inputId = "neurologic_IVH_hydrocephalus",
                        label = "脳室内出血後水頭症",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "neurologic_IVH_hydrocephalus"
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
                        condition = "input.neurologic_IVH_hydrocephalus == 1",
                        selectInput(
                            inputId = "neurologic_IVH_hydrocephalus_shunt",
                            label = "脳室内出血後水頭症シャント術",
                            choices = df_choices |> 
                                dplyr::filter(
                                    item == "neurologic_IVH_hydrocephalus_shunt"
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
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "neurologic_cPVL",
                    label = "嚢胞性脳室周囲白質軟化症",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neurologic_cPVL"
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
                    inputId = "neurologic_whiteMatterLesion",
                    label = "頭部 MRI 白質病変",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neurologic_whiteMatterLesion"
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
                    inputId = "neurologic_HIE",
                    label = "低酸素虚血性脳症",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neurologic_HIE"
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