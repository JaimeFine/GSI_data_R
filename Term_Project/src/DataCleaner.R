library(dplyr)
library(lubridate)

data <- read.csv(
  "spotify_history.csv", header=TRUE, 
  quote = "\""
)

data$ts <- ymd_hms(data$ts)

# Data cleaning:
# Filtering only the data of 2024 June - December:
filtered_data <- data %>%
  filter(year(ts) == 2024 & month(ts) %in% 6:12)

# Filter the songs that weren't played at all:
clean_time <- filtered_data %>%
  filter(ms_played != 0)

# Only leave the top 25 most-played artists:
most_artists <- clean_time %>%
  count(artist_name, sort=TRUE) %>%
  slice_head(n = 25)
clean_artist <- clean_time %>%
  filter(artist_name %in% most_artists$artist_name)

# Removing "mac" and "windows"
clean_platform <- clean_artist %>%
  filter(platform != "mac" & platform != "windows")

# Write to a new file:
write.csv(clean_platform, "clean_spotify.csv", row.names = FALSE)













