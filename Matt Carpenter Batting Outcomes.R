#load packages
require(pitchRx)
require(dplyr)

###################
# scrape the data #
# April 09, 2017  #
# STL VS 
###################
dat <- scrape("2017-04-09", "2017-04-09", suffix=c("miniscoreboard.xml", "inning/inning_all.xml", "inning/inning_hit.xm"))

locations1 <- select(dat$pitch,pitch_type, px, pz, des, num, gameday_link, end_speed, inning, count)

names1 <- select(dat$atbat, pitcher_name, batter_name, num, gameday_link, event, stand, b, s, o)

####################
# select cardinals #
####################
data1 <- inner_join(locations1, filter(names1, grepl("sln", names1$gameday_link)), by = c("num", "gameday_link"))


####################
# Matt Carpenter   #
# Batting Outcomes #
####################
strikeFX(filter(data1, batter_name=="Matt Carpenter"), point.alpha=1,draw_zones = FALSE)+
  facet_wrap(~event, ncol=2)+
  ggtitle("Carpenter At Bat")+
  theme(legend.position="bottom", plot.title = element_text(hjust = 0.5))



