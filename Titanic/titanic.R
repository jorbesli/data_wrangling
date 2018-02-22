# Project 2 in data wrangling module to perform missing data handling
library(tidyr)
library(dplyr)

# 0: Load the data in RStudiod
# Save the target data to a R variable - "ds"
ds <- read.csv("titanic_original.csv")
as.data.frame(ds)

# 1: Port of embarkation
# Replace missing value in embarked column with "S"
ds$embarked[ds$embarked == ""] <- "S"
ds$embarked[anyNA(ds$embarked, recursive = TRUE)] <- "S"

# 2: Age
# Fill up the missing value in "age" column with the mean value
ds$age[is.na(ds$age)] <- mean(ds$age, na.rm = TRUE)

# 3: Lifeboat
# Add dummy value "none" to the missing values in "boat" column
ds$boat <- sub("^$", "none", ds$boat)

# 4: Cabin
# Create a new binary column "has_cabin_number"
#ds$has_cabin_number <- as.numeric(grepl("[[:alnum:]]", ds$cabin))
ds$has_cabin_number <- ifelse(ds$cabin == "", 0,1)

# 5. Submit the project on Github
# Create a new file "titanic_clean.csv" 
write.csv(ds, file = "titanic_clean.csv")

