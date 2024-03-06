print("Loading module_01_02...")

module_01_02 <- 
    tabPanel(
        title = h4("入院経過"),
        br(),
        
        conditionalPanel(
            condition = "input.neonatal_livebirth == 1",
            module_E,
            module_F,
            module_G,
            module_H,
            module_I,
            module_J,
            module_K,
        ),
        module_L,
        module_M,
        module_N,
        conditionalPanel(
            condition = "input.discharge_death == 2",
            module_O,
        ),
    )
