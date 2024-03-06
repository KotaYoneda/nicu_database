print("Loading module_C...")

module_C <- 
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