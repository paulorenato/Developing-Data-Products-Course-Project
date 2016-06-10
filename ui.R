library(shiny)

# The following variable contains the Help Text which will be displayed in the 'Help' Tab. Placed here for clarity
HELP_TEXT_INTRO <- "The \'Shiny Roominator\' is a room rent estimating application for people looking to rent a room in the Silicon Valley, California area.
The author collected rent data from popular websites in June 2016 and built a dataset with the results. This dataset is used to build a
simple linear prediction model based on the room size (\'square footage\'), the town where it's located, and whether or not the 
room has a private bathroom.
The application displays an histogram with a density plot based on the selected parameters to give the user a sense of the rent 
price distribution. A rent prediction including upper and lower prediction interval bounds is also displayed based on the
confidence level the user selected."

# Read the rents dataset
df <- readRDS('rents.Rds')

# Define the UI
shinyUI(

    # Use a fluid Bootstrap layout
    fluidPage(

        # Give the page a title
        titlePanel("The Shiny \'Roominator\' - Silicon Valley Room Rent Estimator"),

        # Generate a row with a sidebar
        sidebarLayout(

            # Define the sidebar with one input
            sidebarPanel(
                selectInput("idx", "Town:",
                            choices=sort(levels(df$town)), #sort alphabetically
                            selected = "sunnyvale"), 
                hr(),
                sliderInput("sqft", 'Square Footage:',value = 200, min = 100, max = 600, step = 10),
                hr(),
                radioButtons("broom", "Private Bathroom:", choices = c("Yes", "No"), selected = "No" , inline = FALSE, width = NULL),
                hr(),
                sliderInput("conf", 'Prediction Confidence %:',value = 90, min = 50, max = 99, step = 5),
                hr(),
                h4("Instructions:"),
                helpText("Select the \'Help\' tab on the right panel for detailed instructions"),
                hr("\n\n\n")
                ),

            # Create a spot for the barplot
            mainPanel(
                tabsetPanel(type = "tabs", 
                  tabPanel("Results", 
                           h4("Rent Distribution:"),  
                           plotOutput("plot1"),
                           h4("Median Rent:"),
                           verbatimTextOutput("median_val"),
                           h4("Mean Rent:"),
                           verbatimTextOutput("mean_val"),
                           h4("Estimated Rent:"),
                           verbatimTextOutput("pred_rent")), 
                  tabPanel("Help",
                           h4("Overview"),
                           helpText(HELP_TEXT_INTRO),
                           h4("Instructions"),
                           h5("1) Using the Left panel, select the town where the room is located, the room size 
                              ('square footage'), and whether or not the room has a private bathroom."),
                           h5("2) Select a confidence level for the rent prediction. The lower the confidence, the narrower the resulting prediction interval will be."),
                           h5("3) The right panel displays an histogram for the datapoints found in the dataset matching the left panel selections. A density plot estimate is overlayed
with the histogram (you can think of this as an \'estimate\' of the underlying rent price distribution)."),
                           h5("4) The median, mean and predicted rents are calculated and displayed on the right panel.")
                           
                           )
                  )
                )
            )))