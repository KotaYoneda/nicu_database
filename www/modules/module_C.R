print("Loading module_C...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_C <- 
    wellPanel(
        h4("C. 分娩情報"),
        width = 9,
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "laborDelivery_hydrops",
                    label = "胎児水腫",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_hydrops"
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
                    inputId = "laborDelivery_PROM",
                    label = "前期破水",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_PROM"
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
                    condition = "input.laborDelivery_PROM == 1",
                    selectInput(
                        inputId = "laborDelivery_PROM_duration",
                        label = "前期破水時期",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "laborDelivery_PROM_duration"
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
                    inputId = "laborDelivery_abraptioPlacentae",
                    label = "常位胎盤早期剥離",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_abraptioPlacentae"
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
                    inputId = "laborDelivery_cordProlapse",
                    label = "臍帯脱出",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_cordProlapse"
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
                    inputId = "laborDelivery_steroid",
                    label = "母体ステロイド投与",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_steroid"
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
                    condition = "input.laborDelivery_steroid == 1",
                    selectInput(
                        inputId = "laborDelivery_steroid_course",
                        label = "母体ステロイド投与クール",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "laborDelivery_steroid_course"
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
                    inputId = "laborDelivery_Mg",
                    label = "母体マグネシウム投与",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_Mg"
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
                    inputId = "laborDelivery_NRFS",
                    label = "胎児心拍異常",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_NRFS"
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
                    inputId = "laborDelivery_presentation",
                    label = "胎位",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_presentation"
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
                    inputId = "laborDelivery_mode",
                    label = "分娩様式",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_mode"
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
                    inputId = "laborDelivery_fetoMaternalTransufusion",
                    label = "胎児母体間輸血症候群",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_fetoMaternalTransufusion"
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
                    inputId = "laborDelivery_cordBloodTransfusion",
                    label = "臍帯血輸血",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "laborDelivery_cordBloodTransfusion"
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
                    condition = "input.laborDelivery_cordBloodTransfusion == 1",
                    selectInput(
                        inputId = "laborDelivery_cordBloodTransfusion_method",
                        label = "臍帯血輸血方法",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "laborDelivery_cordBloodTransfusion_method"
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