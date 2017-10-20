#################
# load packages #
#################
require(pitchRx)
require(dplyr)

###################
# scrape the data #
###################

dat <- scrape("2017-04-07", "2017-04-07")

locations <- select(dat$pitch,
                    pitch_type, count, px, pz, des, num, gameday_link)

names <- select(dat$atbat, pitcher_name, batter_name,
                num, gameday_link, event, stand)

# Select data where Mike Leake was pithching
data <- inner_join(locations, filter(names,
                   pitcher_name == "Mike Leake"),
                   by = c("num", "gameday_link"))

####################################### 
# Pitch Location by batter handedness #
#######################################
strikeFX(data, point.alpha=1, layer=facet_grid(pitch_type ~ stand )) +
  ggtitle("Locations of All Pitches by Batter Handedness")+
  theme(legend.position = "bottom")+
  theme(plot.title = element_text(hjust = 0.5))



