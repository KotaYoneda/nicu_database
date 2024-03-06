print("Loading module_D...")

unselected = "<!--未選択-->"

df_choices <- 
    "www/data/choices.csv" |> 
    readr::read_csv(
        col_types = cols(
            value = col_integer(),
            .default = col_character()
        )
    )

module_D <- 
    wellPanel(
        h4("D. 新生児情報"),
        width = 9,
        
        fluidRow(
            column(
                width = 4,
                numericInput(
                    inputId = "neonatal_admissionDay",
                    label = "入院時生後日数",
                    min = 1,
                    max = 99,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                selectInput(
                    inputId = "neonatal_sex",
                    label = "性別",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neonatal_sex"
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
                    inputId = "neonatal_livebirth",
                    label = "NICU への入院",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neonatal_livebirth"
                        ) |> 
                        dplyr::select(description, value) |> 
                        dplyr::add_row(
                            description = unselected, 
                            value = NA_integer_
                        ) |> 
                        tibble::deframe(),
                    selected = 1,
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 6,
                selectInput(
                    inputId = "neonatal_outborn",
                    label = "院外出生",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neonatal_outborn"
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
                    condition = "input.neonatal_outborn == 2",
                    selectInput(
                        inputId = "neonatal_inborn",
                        label = "母体紹介（院内出生の場合）",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "neonatal_inborn"
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
                    inputId = "neonatal_GA_week",
                    label = "在胎期間（週）",
                    min = 20,
                    max = 49,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "neonatal_GA_day",
                    label = "在胎期間（日）",
                    min = 0,
                    max = 6,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                selectInput(
                    inputId = "neonatal_GA_confirm",
                    label = "妊娠初期在胎期間確認",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neonatal_GA_confirm"
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
                    inputId = "neonatal_ap1",
                    label = "アプガー 1 分値",
                    min = 0,
                    max = 10,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "neonatal_ap5",
                    label = "アプガー 5 分値",
                    min = 0,
                    max = 10,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "neonatal_ap10",
                    label = "アプガー 10 分値",
                    min = 0,
                    max = 10,
                    value = NA,
                ),
            ),
        ),
        
        fluidRow(
            column(
                width = 4,
                selectInput(
                    inputId = "neonatal_resuscitation_withhold",
                    label = "積極的蘇生の実施差し控え",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neonatal_resuscitation_withhold"
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
                    inputId = "neonatal_resuscitation_oxygen",
                    label = "蘇生時酸素使用",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neonatal_resuscitation_oxygen"
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
                    inputId = "neonatal_resuscitation_intubation",
                    label = "蘇生時気管挿管",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neonatal_resuscitation_intubation"
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
                    inputId = "neonatal_resuscitation_CPAP",
                    label = "蘇生時 CPAP 施行",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neonatal_resuscitation_CPAP"
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
                    inputId = "neonatal_resuscitation_chestCompression",
                    label = "蘇生時胸骨圧迫施行",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neonatal_resuscitation_chestCompression"
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
                    inputId = "neonatal_resuscitation_adrenalin",
                    label = "蘇生時アドレナリン投与",
                    choices = df_choices |> 
                        dplyr::filter(
                            item == "neonatal_resuscitation_adrenalin"
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
                    inputId = "neonatal_birthWeight",
                    label = "出生体重 (g)",
                    min = 1,
                    max = 9999,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "neonatal_birthLength",
                    label = "出生時身長 (cm)",
                    min = 1,
                    max = 99,
                    value = NA,
                ),
            ),
            column(
                width = 4,
                numericInput(
                    inputId = "neonatal_birthHC",
                    label = "出生時頭囲 (cm)",
                    min = 1,
                    max = 99,
                    value = NA,
                ),
            ),
        ),
        
        conditionalPanel(
            condition = "input.neonatal_livebirth == 1",
            
            fluidRow(
                column(
                    width = 4,
                    selectInput(
                        inputId = "neonatal_cordBloodGas_sample",
                        label = "臍帯動脈血採取",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "neonatal_cordBloodGas_sample"
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
                        inputId = "neonatal_neonatalBloodGas_sample",
                        label = "入院時血液ガス分析",
                        choices = df_choices |> 
                            dplyr::filter(
                                item == "neonatal_neonatalBloodGas_sample"
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
                        condition = "input.neonatal_neonatalBloodGas_sample == 1",
                        selectInput(
                            inputId = "neonatal_neonatalBloodGas_sampleSite",
                            label = "入院時血液ガス検体",
                            choices = df_choices |> 
                                dplyr::filter(
                                    item == "neonatal_neonatalBloodGas_sampleSite"
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
                condition = "input.neonatal_cordBloodGas_sample == 1",
                
                wellPanel(
                    
                    h5("臍帯動脈血ガス"),
                    
                    fluidRow(
                        column(
                            width = 3,
                            numericInput(
                                inputId = "neonatal_cordBloodGas_pH",
                                label = "pH",
                                min = 0,
                                max = 9,
                                value = NA,
                            ),
                        ),
                        column(
                            width = 3,
                            numericInput(
                                inputId = "neonatal_cordBloodGas_PO2",
                                label = "PO2",
                                min = 0,
                                max = 999,
                                value = NA,
                            ),
                        ),
                        column(
                            width = 3,
                            numericInput(
                                inputId = "neonatal_cordBloodGas_PCO2",
                                label = "PCO2",
                                min = 0,
                                max = 999,
                                value = NA,
                            ),
                        ),
                        column(
                            width = 3,
                            numericInput(
                                inputId = "neonatal_cordBloodGas_BE",
                                label = "BE",
                                min = -99,
                                max = 99,
                                value = NA,
                            ),
                        ),
                    ),
                ),
            ),
            
            conditionalPanel(
                condition = "input.neonatal_neonatalBloodGas_sample == 1",
                
                wellPanel(
                    
                    h5("入院時血ガス"),
                    
                    fluidRow(
                        column(
                            width = 3,
                            numericInput(
                                inputId = "neonatal_neonatalBloodGas_pH",
                                label = "pH",
                                min = 0,
                                max = 9,
                                value = NA,
                            ),
                        ),
                        column(
                            width = 3,
                            numericInput(
                                inputId = "neonatal_neonatalBloodGas_PO2",
                                label = "PO2",
                                min = 0,
                                max = 999,
                                value = NA,
                            ),
                        ),
                        column(
                            width = 3,
                            numericInput(
                                inputId = "neonatal_neonatalBloodGas_PCO2",
                                label = "PCO2",
                                min = 0,
                                max = 999,
                                value = NA,
                            ),
                        ),
                        column(
                            width = 3,
                            numericInput(
                                inputId = "neonatal_neonatalBloodGas_BE",
                                label = "BE",
                                min = -99,
                                max = 99,
                                value = NA,
                            ),
                        ),
                    ),
                ),
            ),
            
            fluidRow(
                column(
                    width = 6,
                    numericInput(
                        inputId = "neonatal_admission_temperature",
                        label = "入院時体温（℃）",
                        min = 0,
                        max = 999,
                        value = NA,
                    ),
                ),
                column(
                    width = 6,
                    numericInput(
                        inputId = "neonatal_admission_Hb",
                        label = "入院時 Hb (g/dL)",
                        min = 0,
                        max = 999,
                        value = NA,
                    ),
                ),
            ),
        ),
    )