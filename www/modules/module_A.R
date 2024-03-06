print("Loading module_A...")

unselected = "<!--未選択-->"

df_maternal_comorbidity_choices <- 
    "www/data/table1.csv" |> 
    readr::read_csv(
        col_types = cols(.default = col_character())
    ) |> 
    dplyr::mutate(
        key = diagnosis |> 
            stringr::str_c("（", code, "）")
    ) |> 
    dplyr::select(key, code)

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_A <- 
    wellPanel(
        h4("A. 母体情報"),
        width = 9,

        fluidRow(
            column(
                width = 4,
                numericInput(
                    inputId = "maternal_age",
                    label = "母体年齢",
                    min = 1,
                    max = 99,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "maternal_gravida_plus1",
                    label = "妊娠回数（今回を含む）",
                    min = 1,
                    max = 99,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "maternal_parity",
                    label = "分娩回数（今回を含まず）",
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
                    inputId = "maternal_comorbidity",
                    label = "母体基礎疾患",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "maternal_ART"
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
                    condition = "input.maternal_comorbidity == 1",
                    selectInput(
                        inputId = "maternal_comorbidity_detail",
                        label = "母体基礎疾患の詳細",
                        choices = df_maternal_comorbidity_choices |> 
                            tibble::deframe(),
                        multiple = TRUE,
                    ),
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "maternal_ART",
                    label = "母体不妊治療",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "maternal_ART"
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
                    inputId = "maternal_foreigner",
                    label = "児の母が外国籍",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "maternal_foreigner"
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
                    condition = "input.maternal_foreigner == 1",
                    textInput(
                        inputId = "maternal_foreigner_detail",
                        label = "児の母の国籍",
                        placeholder = "（自由記載）",
                    ),
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