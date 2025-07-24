library(dplyr)

airlines <- read.csv("HoustonAirline.csv", header=TRUE)
airports <- read.csv("airports.csv", header=TRUE)

# Task 1: How many flights are in this dataset from Houston to city of "Los Angeles"? Print the number.   
la.airports <- airports %>%
  filter(city == "Los Angeles") %>%
  pull(iata)
hou.airports <- airports %>%
  filter(city == "Houston") %>%
  pull(iata)

hou.to.la <- airlines %>%
  filter(Origin %in% hou.airports, Dest %in% la.airports)

cat("The flight from Houston to Los Angeles are", nrow(hou.to.la))

# Task 2:  Which top-10 destination cities have the most number of flights?
airlines %>%
  left_join(airports, by=c("Dest"='iata')) %>%
  group_by(city) %>%
  summarise(
    NFlights = n()
  ) %>%
  arrange(desc(NFlights)) %>%
  slice_head(n=10)

# Task 3:  Which states have no flights? 
no.flights <- airlines %>%
  left_join(airports, by=c("Dest" = 'iata')) %>%
  group_by(state) %>%
  summarise(
    NFlight = n()
  ) %>%
  filter(NFlight == 0)

cat("There are", nrow(no.flight), "state with no flights!")

# Task 4: Which top 10 destination cities have the most cancelations of flights?
airlines %>%
  filter(Cancelled != 0) %>%
  left_join(airports, by=c("Dest" = 'iata')) %>%
  group_by(city) %>%
  summarise(
    NumFlight = n()
  ) %>%
  arrange(desc(NumFlight)) %>%
  slice_head(n=10)

# Task 5: Is there any Cities without a Flight from Houston?
no.houston <- airlines %>%
  filter(!(Origin %in% hou.airports)) %>%
  left_join(airports, by=c("Dest" = 'iata')) %>%
  group_by(city) %>%
  summarise(
    NumFlights = n()
  )

cat("There are", nrow(no.houston), "cities without a Flight from Houston!")

# Task 6: What is the ratio of flights canceled for each state?
state.cal <- airlines %>%
  filter(Cancelled != 0) %>%
  left_join(airports, by=c("Dest" = 'iata')) %>%
  group_by(state) %>%
  summarise(
    NumFlight = n()
  )

state.all <- airlines %>%
  left_join(airports, by=c("Dest" = 'iata')) %>%
  group_by(state) %>%
  summarise(
    NumFlight = n()
  )

state.cal.ratio <- state.cal %>%
  rename(CancelledFlights = NumFlight) %>%
  left_join(state.all %>% rename(TotalFlights = NumFlight), by="state") %>%
  mutate(CalRatio = CancelledFlights / TotalFlights) %>%
  mutate(CalRatio = paste0(round(CalRatio * 100, 1), "%")) %>%
  select(state, CalRatio)

print(state.cal.ratio, n = 39)