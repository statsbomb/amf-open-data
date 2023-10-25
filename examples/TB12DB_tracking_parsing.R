library(RJSONIO)
library(tidyverse)
library(listviewer)


#### Download game file from GitHub and then use the file path to read it into R
game <- fromJSON("/Users/mattedwards/Downloads/SB_tracking_20230116_DAL_TB.json", nullValue = NaN)

#### Get the game level information
game_id = game$game_id
game_date = game$game_date
season_name = game$season_name
home_team = game$home_team$name
away_team = game$away_team$name

#### Get play by play information
### Set up vectors for a for loop of all the data that is in the JSON for each play
play_ids <- vector()
start_timestamps <- vector()
end_timestamps <- vector()
gsis_playids <- vector()
quarters <- vector()
game_clocks <- vector()
yardlines <- vector()
downs <- vector()
distances <- vector()
play_types <- vector()
gains <- vector()
offense_team_ids <- vector()
player_coverage_counts <- vector()

### Now we need to know how long we need to make the for loop
loop_length <- length(game$plays)

for (i in 1:loop_length) {
  play_id <- game$plays[[i]]$play_uuid
  start_timestamp <- game$plays[[i]]$start_timestamp
  end_timestamp <- game$plays[[i]]$end_timestamp
  gsis_playid <- game$plays[[i]]$gsis_play_id
  quarter <- game$plays[[i]]$play_quarter
  yardline <- game$plays[[i]]$play_yardline
  game_clock <- game$plays[[i]]$game_clock
  down <- game$plays[[i]]$play_down
  distance <- game$plays[[i]]$play_yards_to_go
  play_type <-game$plays[[i]]$play_type
  gain <- game$plays[[i]]$play_yards_net
  offense_team_id <- game$plays[[i]]$play_offense_team_id
  player_coverage_count <- game$plays[[i]]$player_coverage_count
  
  play_ids[i] <- play_id
  start_timestamps[i] <- start_timestamp
  end_timestamps[i] <- end_timestamp
  gsis_playids[i] <- gsis_playid
  quarters[i] <- quarter
  game_clocks[i] <- game_clock
  yardlines[i] <- yardline
  downs[i] <- down
  distances[i] <- distance
  play_types[i] <- play_type
  gains[i] <- gain
  offense_team_ids[i] <- offense_team_id
  player_coverage_counts[i] <- player_coverage_count
  
}

### Pulll it all together into a dataframe
play_by_play <- data.frame(play_ids, start_timestamps, end_timestamps, gsis_playids, quarters, game_clocks, downs, distances, yardlines, gains, play_types, offense_team_ids, player_coverage_counts)
play_by_play <- play_by_play %>% mutate(play_number = row_number())

#### Listviewer for an individual play is helpful to see what is happening with the json file at the play level
#### I would love to do this at the game level, but it is too big, and never actually opened for me
jsonedit(game$plays[[141]], height = "800px", mode = "view")


#### Let's pull the player information at an individual play level, Tom Brady's last TD of his career
#### It's not Gronk, but fitting that his last TD went to a Tight End lined up in the slot
track_ids <- vector()
end_timestamps <- vector()
start_timestamps <- vector()
team_ids <- vector()
player_names <- vector()
player_ids <- vector()
player_positions <- vector()
player_jersey_numbers <- vector()
on_camera_ratios <- vector()

for (i in 1:22) {
  track_id <- game$plays[[141]]$tracks[[i]]$track_id
  end_timestamp <- game$plays[[141]]$tracks[[i]]$end_timestamp
  start_timestamp <- game$plays[[141]]$tracks[[i]]$start_timestamp
  team_id <- game$plays[[141]]$tracks[[i]]$team_id
  player_name <- game$plays[[141]]$tracks[[i]]$player$name
  player_id <- game$plays[[141]]$tracks[[i]]$player$player_id
  player_position <- game$plays[[141]]$tracks[[i]]$player$position_code
  player_jersey_number <- game$plays[[141]]$tracks[[i]]$player$jersey_number
  on_camera_ratio <- game$plays[[141]]$tracks[[i]]$on_camera_ratio
  
  track_ids[i] <- track_id
  end_timestamps[i] <- end_timestamp
  start_timestamps[i] <- start_timestamp
  team_ids[i] <- team_id
  player_names[i] <- player_name
  player_ids[i] <- player_id
  player_positions[i] <- player_position
  player_jersey_numbers[i] <- player_jersey_number
  on_camera_ratios[i] <- on_camera_ratio
  
}

individual_play_player_data <- data.frame(track_ids, start_timestamps, end_timestamps, team_ids, player_names, player_ids, player_positions, player_jersey_numbers, on_camera_ratios)

  

#### Now we need to get the actual locational data. Cameron Brate scores the TD on this play. Let's check him out
play_timestamp <- vector()
play_x <- vector()
play_y <- vector()
play_ngs_x <- vector()
play_ngs_y <- vector()
play_time_since_snap <- vector()

steps_length <- length(game$plays[[141]]$tracks[[1]]$steps)

for (i in 1:steps_length) {
    timestamp = game$plays[[141]]$tracks[[1]]$steps[[i]][["timestamp"]]
    x = game$plays[[141]]$tracks[[1]]$steps[[i]][["x"]]
    y = game$plays[[141]]$tracks[[1]]$steps[[i]][["y"]]
    ngs_x = game$plays[[141]]$tracks[[1]]$steps[[i]][["ngs_x"]]
    ngs_y = game$plays[[141]]$tracks[[1]]$steps[[i]][["ngs_y"]]
    time_since_snap = game$plays[[141]]$tracks[[1]]$steps[[i]][["time_since_snap"]]
    
    play_timestamp[i] = timestamp
    play_x[i] = x
    play_y[i] = y
    play_ngs_x[i] = ngs_x
    play_ngs_y[i] = ngs_y
    play_time_since_snap[i] = time_since_snap
    
}

Cameron_Brate_Movement <- data.frame(play_timestamp, play_time_since_snap, play_x, play_y, play_ngs_x, play_ngs_y) %>% mutate(frame = row_number())

#### Let's plot that movement for just Cameron Brate
library(plotly)
library(cowplot)
library(gganimate)

### First, start with the field set up
left_hashes = data.frame(
  x = c(1:99),
  xend = c(1:99), 
  y = c((70*12+9)/36),
  yend = c(((70*12+9)/36)+.66)
)
right_hashes = data.frame(
  x = c(1:99),
  xend = c(1:99), 
  y = c(29.09),
  yend = c(29.75)
)
yard_markers = data.frame(
  x=c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100),
  xend = c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100),
  y=c(0),
  yend=c(53.33)
)

FarFieldNumbers = data.frame(x= c(10,20,30,40,50,60,70,80,90), y = c(12), Number = c(10,20,30,40,50,40,30,20,10))
CloseFieldNumbers = data.frame(x= c(10,20,30,40,50,60,70,80,90), y = c(41.33), Number = c(10,20,30,40,50,40,30,20,10))


ggplot() +
  geom_segment(aes(x=0,y=0,xend=0,yend=53.33)) +
  geom_segment(aes(x=-10,y=0,xend=-10,yend=53.33)) +
  geom_segment(aes(x=100,y=0,xend=100,yend=53.33)) +
  geom_segment(aes(x=110,y=0,xend=110,yend=53.33)) +
  geom_segment(aes(x=-10,y=0,xend=110,yend=0)) +
  geom_segment(aes(x=-10,y=53.33,xend=110,yend=53.33)) +
  geom_segment(data= yard_markers, aes(x=x, xend=xend, y=y, yend=yend)) +
  geom_segment(data = left_hashes, aes(x=x, xend=xend, y=y, yend=yend)) +
  geom_segment(data = right_hashes, aes(x=x, xend=xend, y=y, yend=yend)) +
  geom_text(data = CloseFieldNumbers, mapping = aes(x,y, label = Number), colour = "#000000", size = 8,) + ##These are the Numbers on the field
  geom_text(data = FarFieldNumbers, mapping = aes(x, y, label = Number), colour = "#000000", size = 8, angle = 180) +
  theme_nothing() +
  geom_point(data=Cameron_Brate_Movement, aes(x=play_x, y=play_y), size=3) +
  scale_y_reverse() + ##To make sure that we get the right direction of the y coordinates
  transition_time(frame)
  

#### Fun! Now let's shoot to have all of the players, jersey numbers, and more! 
track_ids <- vector()
end_timestamps <- vector()
start_timestamps <- vector()
team_ids <- vector()
player_names <- vector()
player_ids <- vector()
player_positions <- vector()
player_jersey_numbers <- vector()
on_camera_ratios <- vector()
timestamps <- vector()
time_since_snaps <- vector()
nfl_team_ids <- vector()


field_x <- matrix(ncol=length(game$plays[[141]]$tracks[[1]]$steps), nrow=22)
field_y <- matrix(ncol=length(game$plays[[141]]$tracks[[1]]$steps), nrow=22)

for (i in 1:22) {
  track_id <- game$plays[[141]]$tracks[[i]]$track_id
  end_timestamp <- game$plays[[141]]$tracks[[i]]$end_timestamp
  start_timestamp <- game$plays[[141]]$tracks[[i]]$start_timestamp
  team_id <- game$plays[[141]]$tracks[[i]]$team_id
  player_name <- game$plays[[141]]$tracks[[i]]$player$name
  player_id <- game$plays[[141]]$tracks[[i]]$player$player_id
  player_position <- game$plays[[141]]$tracks[[i]]$player$position_code
  player_jersey_number <- game$plays[[141]]$tracks[[i]]$player$jersey_number
  on_camera_ratio <- game$plays[[141]]$tracks[[i]]$on_camera_ratio
  nfl_team_id <- game$plays[[141]]$tracks[[i]]$nfl_team_id
  
  track_ids[i] <- track_id
  end_timestamps[i] <- end_timestamp
  start_timestamps[i] <- start_timestamp
  team_ids[i] <- team_id
  player_names[i] <- player_name
  player_ids[i] <- player_id
  player_positions[i] <- player_position
  player_jersey_numbers[i] <- player_jersey_number
  on_camera_ratios[i] <- on_camera_ratio
  nfl_team_ids[i] <- nfl_team_id
  
  length = length(game$plays[[141]]$tracks[[i]]$steps)
  
  for (j in 1:length) {
    timestamp = game$plays[[141]]$tracks[[i]]$steps[[j]][["timestamp"]]
    time_since_snap = game$plays[[141]]$tracks[[i]]$steps[[j]][["time_since_snap"]]
    
    timestamps[j] = timestamp
    time_since_snaps[j] = time_since_snap
    field_x[i,j] = game$plays[[141]]$tracks[[i]]$steps[[j]][["x"]]
    field_y[i,j] = game$plays[[141]]$tracks[[i]]$steps[[j]][["y"]]
    
  }
  
}

extra_info <- as.data.frame(t(as.data.frame(rbind(timestamps, time_since_snaps)))) %>% mutate(frame = row_number())

field_x_df <- data.frame(track_ids, player_ids, player_names, nfl_team_ids, player_jersey_numbers, player_positions, start_timestamps, end_timestamps, field_x) %>% 
  pivot_longer(cols = starts_with("X"), names_to = "frame", names_prefix = "X", values_to = "x", values_drop_na = F)

field_y_df <- data.frame(track_ids, player_ids, player_names, nfl_team_ids, player_jersey_numbers, player_positions, start_timestamps, end_timestamps, field_y) %>%
  pivot_longer(cols = starts_with("X"), names_to = "frame", names_prefix = "X", values_to = "y", values_drop_na = F)

total_tracking <- merge(field_x_df, field_y_df, by = c("track_ids", "player_ids", "nfl_team_ids", "player_names", "player_jersey_numbers", "player_positions","start_timestamps","end_timestamps","frame"))
total_tracking <- merge(total_tracking, extra_info, by = "frame")

total_tracking$frame <- as.numeric(total_tracking$frame)

##### Short field plotting
left_hashes = data.frame(
  x = c(1:24),
  xend = c(1:24), 
  y = c((70*12+9)/36),
  yend = c(((70*12+9)/36)+.66)
)
right_hashes = data.frame(
  x = c(1:24),
  xend = c(1:24), 
  y = c(29.09),
  yend = c(29.75)
)
yard_markers = data.frame(
  x=c(0,5,10,15,20,25),
  xend = c(0,5,10,15,20,25),
  y=c(0),
  yend=c(53.33)
)

FarFieldNumbers = data.frame(x= c(10,20), y = c(12), Number = c(10,20))
CloseFieldNumbers = data.frame(x= c(10,20), y = c(41.33), Number = c(10,20))


ggplot() +
  geom_segment(aes(x=0,y=0,xend=0,yend=53.33)) +
  geom_segment(aes(x=-10,y=0,xend=-10,yend=53.33)) +
  geom_segment(aes(x=25,y=0,xend=25,yend=53.33)) +
  geom_segment(aes(x=25,y=0,xend=25,yend=53.33)) +
  geom_segment(aes(x=-10,y=0,xend=25,yend=0)) +
  geom_segment(aes(x=-10,y=53.33,xend=25,yend=53.33)) +
  geom_segment(data= yard_markers, aes(x=x, xend=xend, y=y, yend=yend)) +
  geom_segment(data = left_hashes, aes(x=x, xend=xend, y=y, yend=yend)) +
  geom_segment(data = right_hashes, aes(x=x, xend=xend, y=y, yend=yend)) +
  geom_text(data = CloseFieldNumbers, mapping = aes(x,y, label = Number), colour = "#000000", size = 8,) + ### These are the Numbers on the field
  geom_text(data = FarFieldNumbers, mapping = aes(x, y, label = Number), colour = "#000000", size = 8, angle = 180) +
  theme_nothing() +
  geom_point(data=total_tracking, aes(x=x, y=y, color = nfl_team_ids), size=5) +
  geom_point(data = total_tracking %>% filter(player_names == "Cameron Brate"), aes(x=x,y=y), size = 5, color = "#D50A0A") +
  geom_text(data = total_tracking, aes(x=x, y=y, label = player_jersey_numbers), color = "white", 
            vjust = 0.36, size = 4) + 
  scale_color_manual(values = c("#869397", "#000000")) +
  transition_time(frame) +
  coord_flip() +
  scale_x_reverse() +
  scale_y_reverse()

anim_save("full_play.gif", last_animation())

