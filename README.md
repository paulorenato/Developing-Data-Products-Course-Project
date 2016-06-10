Coursera Developing Data Products Course Project
=================================================
Paulo Oliveira

## Overview

This application has been created as a course project for the Coursera Developing Data Products course.
The 'Shiny Roominator" app is a room rent estimating application for people looking to rent a room in the Silicon Valley, California area.
The author collected rent data from popular websites in June 2016 and built a dataset with the results. This dataset is used to build a
simple linear prediction model based on the room size ('square footage'), the town where it's located, and whether or not the 
room has a private bathroom.
The application displays an histogram with a density plot based on the selected parameters to give the user a sense of the rent 
price distribution. A rent prediction including upper and lower prediction interval bounds is also displayed based on the
confidence level the user selected. 

Demo of the applications be found [here](https://paulorenato.shinyapps.io/roominator/).

## Instructions

1. Using the Left panel, select the town where the room is located, the room size ('square footage'), and whether or not the room has a private bathroom.
2. Select a confidence level for the rent prediction. The lower the confidence, the narrower the resulting prediction interval will be.
3. The right panel displays an histogram for the datapoints found in the dataset matching the left panel selections. A density plot estimate is overlayed
with the histogram (you can think of this as an "estimate' of the underlying rent price distribution).
4. The median, mean and predicted rents are calculated and displayed on the right panel.
