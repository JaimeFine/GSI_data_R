library(dplyr)

airlines <- read.csv("airlines.csv", header = FALSE)
airports <- read.csv("airports.csv", header = TRUE)

# Task 1: How many flights are in this dataset from Houston to city of "Los Angels"? Print the number.   
la.airports <- airports %>%
  filter(CITY == "Los Angeles") %>%
  pull(IATA_CODE)
hou.airports <- airports %>%
  filter(CITY == "Houston") %>%
  pull(IATA_CODE)

hou.to.la <- airlines %>%
  filter(V8 %in% hou.airports, V9 %in% la.airports)

cat("The flight from Houston to Los Angeles are", nrow(hou.to.la))

# Task 2:  Which top-10 destination cities have the highest arrival delay of flights?
airlines %>%
  select(Dest = V9, ArrDelay = V23) %>%
  filter(ArrDelay >= 0) %>%
  left_join(airports, by = c("Dest" = 'IATA_CODE')) %>%
  group_by(CITY) %>%
  summarise(
    NFlight = n()
  ) %>%
  arrange(desc(NFlight)) %>%
  slice_head(n = 10)

# Task 3: Which top 10 destination cities have the most cancellations of flights?
airlines %>%
  select(Dest = V9, Cancel = V25) %>%
  filter(Cancel != 0) %>%
  left_join(airports, by = c("Dest" = 'IATA_CODE')) %>%
  group_by(CITY) %>%
  summarise(
    NFlight = n()
  ) %>%
  arrange(desc(NFlight)) %>%
  slice_head(n = 10)

# Task 4: Is there any Cities without a Flight from Houston?
hou.airports <- airports %>%
  filter(CITY == "Houston") %>%
  pull(IATA_CODE)

to.houston <- airlines %>%
  select(Origin = V8, Dest = V9) %>%
  filter(Origin %in% hou.airports) %>%
  left_join(airports, by = c("Dest" = 'IATA_CODE')) %>%
  pull(CITY) %>%
  unique()

all.flights <- airlines %>%
  select(Origin = V8, Dest = V9) %>%
  left_join(airports, by = c ("Dest" = 'IATA_CODE')) %>%
  pull(CITY) %>%
  unique()

cities.without.hou <- setdiff(all.flights, to.houston)

print("The cities without a flight from Houston")
cities.without.hou

# Task 5: What is the ratio of flights canceled for each cities? Which city has the highest ratio? 
city.cal <- airlines %>%
  select(Dest = V9, Cancel = V25) %>%
  filter(Cancel != 0) %>%
  left_join(airports, by = c("Dest" = 'IATA_CODE')) %>%
  group_by(CITY) %>%
  summarise(
    NFlight = n()
  )

city.all <- airlines %>%
  select(Dest = V9, Cancel = V25) %>%
  left_join(airports, by=c("Dest" = 'IATA_CODE')) %>%
  group_by(CITY) %>%
  summarise(
    NFlight = n()
  )

city.cal.ratio <- city.cal %>%
  rename(CancelledFlights = NFlight) %>%
  left_join(city.all %>% rename(TotalFlights = NFlight), by="CITY") %>%
  mutate(CalRatioNum = CancelledFlights / TotalFlights) %>%
  arrange(desc(CalRatioNum)) %>%
  mutate(CalRatio = paste0(round(CalRatioNum * 100, 1), "%")) %>%
  select(CITY, CalRatio)

print(city.cal.ratio, n = 112)