print("Loading module_B...")

module_B <- 
    wellPanel(
        h4("records of the 'neonates' table"),
        width = 9,
        numericInput(
            inputId = "num_fetuses",
            label = "Number of fetuses",
            min = 1,
            max = 9,
            value = NA,
        )
    )