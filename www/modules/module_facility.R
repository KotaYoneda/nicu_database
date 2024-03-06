print("Loading module_facility...")

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

unselected = "<!--未選択-->"

module_facility <- 
    wellPanel(
        h4("施設データ"),
        width = 9,

        fluidRow(
            column(
                width = 4,
                dateInput(
                    inputId = "facility_date",
                    label = "報告年月日",
                    value = NA,
                ),
            ),
            column(
                width = 4,
                selectInput(
                    inputId = "facility_class",
                    label = "種別",
                    choices = df_choices |> 
                        dplyr::filter(item == "facility_class") |> 
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
                    inputId = "facility_provider",
                    label = "設立母体",
                    choices = df_choices |> 
                        dplyr::filter(item == "facility_provider") |> 
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
                    inputId = "facility_bed",
                    label = "新生児病床数",
                    min = 0,
                    max = 999,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "facility_NICU",
                    label = "NICU 病床数",
                    min = 0,
                    max = 999,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "facility_MFICU",
                    label = "MFICU 病床数",
                    min = 0,
                    max = 999,
                    value = NA,
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 4,
                numericInput(
                    inputId = "facility_doctor",
                    label = "常勤医師数",
                    min = 0,
                    max = 99,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "facility_nurse",
                    label = "看護師数",
                    min = 0,
                    max = 99,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "facility_volume",
                    label = "NRNJ 対象入院数",
                    min = 0,
                    max = 99,
                    value = NA,
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "facility_psychologist",
                    label = "臨床心理士",
                    choices = df_choices |> 
                        dplyr::filter(item == "facility_psychologist") |> 
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
                    inputId = "facility_surgery",
                    label = "外科疾患",
                    choices = df_choices |> 
                        dplyr::filter(item == "facility_surgery") |> 
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
                    inputId = "facility_cardiosurgery",
                    label = "心臓疾患",
                    choices = df_choices |> 
                        dplyr::filter(item == "facility_cardiosurgery") |> 
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
                    inputId = "facility_neurosurgery",
                    label = "脳外科疾患",
                    choices = df_choices |> 
                        dplyr::filter(item == "facility_neurosurgery") |> 
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
                    inputId = "facility_ophthalmology",
                    label = "眼科疾患",
                    choices = df_choices |> 
                        dplyr::filter(item == "facility_ophthalmology") |> 
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
                    inputId = "facility_followUp",
                    label = "フォローアップ体制",
                    choices = df_choices |> 
                        dplyr::filter(item == "maternal_foreigner") |> 
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


# 
# fluidRow(
#     column(
#         width = 6,
#     ),
#     column(
#         width = 6,
#     )
# ),