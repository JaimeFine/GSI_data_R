library(dplyr)
library(ggplot2)
library(lubridate)

Sys.setlocale("LC_TIME", "English_United States.1252")

data <- read.csv("clean_spotify.csv", header=TRUE)

data$ts <- ymd_hms(data$ts)

top_artists <- data %>%
  mutate(month=format(ts, "%b")) %>%
  mutate(month=factor(
    month, 
    levels=c("Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
  )) %>%
  group_by(month, artist_name) %>%
  summarise(total_time_ms=sum(ms_played), .groups="drop") %>%
  arrange(month, desc(total_time_ms)) %>%
  group_by(month) %>%
  slice_max(order_by=total_time_ms, n = 1)

print(top_artists)


top_albums <- data %>%
  mutate(month=format(ts, "%b")) %>%
  mutate(month=factor(
    month, 
    levels=c("Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
  )) %>%
  group_by(month, album_name) %>%
  summarise(total_time_ms=sum(ms_played), .groups="drop") %>%
  arrange(month, desc(total_time_ms)) %>%
  group_by(month) %>%
  slice_max(order_by=total_time_ms, n = 1)

print(top_albums)

str(data[, c("reason_start", "reason_end", "shuffle", "skipped")])

data$reason_start <- as.factor(data$reason_start)
data$reason_end   <- as.factor(data$reason_end)
data$shuffle      <- as.logical(data$shuffle)
data$skipped      <- as.logical(data$skipped)

table(data$reason_start, data$skipped)
table(data$reason_end, data$skipped)
table(data$shuffle, data$skipped)

ggplot(data, aes(x = shuffle, fill = skipped)) +
  geom_bar(position = "fill") +
  labs(title = "Skip Rate by Shuffle", y = "Skip Rate", x = "Shuffle or Not") +
  scale_fill_manual(values = c("darkgreen", "darkred"))

reason_skip <- data %>%
  group_by(reason_start, reason_end) %>%
  summarise(skip_rate = mean(skipped))

ggplot(reason_skip, aes(x = reason_start, y = reason_end, fill = skip_rate)) +
  geom_tile(color = "grey") +
  scale_fill_gradient2(
    low = "darkgreen", mid = "darkorange", high = "darkred", midpoint = 0.5
  ) +
  labs(
    title = "Skip Rate by Reason Start & End",
    x = "Reason Start",
    y = "Reason End",
    fill = "Skip Rate"
  )






