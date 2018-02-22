# Project 1 in data wrangling module to perform basic data manipulation
library(tidyr)
library(dplyr)

# 0: Load the data in RStudio
# Save the target data to a R variable - "dataset"
dataset <- read.csv("refine_original.csv")

# 1: Clean up brand names
# Convert to all lowercase and then standardize them for "company"
dataset$company <- dataset$company %>% tolower()
dataset$company <- sub("^ak.*", "akzo", dataset$company)
dataset$company <- sub(".*ps$", "philips", dataset$company)
dataset$company <- sub(".*ver$", "unilever", dataset$company)
dataset$company <- sub(".*ten$", "van houten", dataset$company)

# 2: Separate product code and number
# Convert to two new variables: "product_code" and "product_number"
dataset <- separate(dataset, "Product.code...number", c("product_code", "product_number"), sep = "-")

# 3: Add product categories
# Add one more column "product_category" to map "product_code" as follows:
# product categories:
# p = Smartphone
# v = TV
# x = Laptop
# q = Tablet
dataset <- dataset %>% mutate(product_category = recode_factor(product_code, p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet"))

# 4: Add full address for geocoding
# Add a new column "full_address" to concatenate "address, city, country"
dataset <- dataset %>% unite(full_address, address, city, country, sep = ", ")

# 5: Create dummy variables for company and product category
# Add four binary columns for "company" and "product_category"

dataset$company_philips <- ifelse(dataset$company == "philips", 1, 0)
dataset$company_akzo <- ifelse(dataset$company == "akzo", 1, 0)
dataset$company_van_houten <- ifelse(dataset$company == "van houten", 1, 0)
dataset$company_unilever <- ifelse(dataset$company == "unilever", 1, 0)

dataset$product_smartphone <- ifelse(dataset$product_category == "Smartphone", 1, 0)
dataset$product_tv <- ifelse(dataset$product_category == "TV", 1, 0)
dataset$product_laptop <- ifelse(dataset$product_category == "Laptop", 1, 0)
dataset$product_tablet <- ifelse(dataset$product_category == "Tablet", 1, 0)

# 6: Submit the project on Github
# Run the code and create the output file "refine_clean". 
write.csv2(dataset, file = "refine_clean.csv")

