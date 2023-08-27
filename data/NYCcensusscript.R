install.packages("tidycensus")
require(tidycensus)
census_api_key("********************")

census_data <- load_variables(2010, "acs5", cache = TRUE)


vars <- c(Total = "B01001_001",
          Poverty = "B06012_002",
          median_income = "B06011_001")


data <- get_acs(state = "ny",
                geography = "tract",
                variables = vars, 
                geometry = T,
                survey = "acs5",
                output = "wide",
                year = 2010
)



data$pct_pov <- (data$PovertyE/data$TotalE)*100
data$median_income <- (data$median_incomeE)*1
summary(data$median_income)
summary(data$pct_pov)


plot(data)

data$geometry <- NULL

getwd()

# install.packages("data.table")
require(data.table)


fwrite(data, "median_income_pctpoverty_2010_capstone.csv")

