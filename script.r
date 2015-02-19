rm(list=ls())


x <- c("rgl", "lattice", "plyr", "dplyr")
install.packages(x)

require(rgl)
require(lattice)
require(plyr)
require(tidyr)
require(dplyr)


all_counts <- read.csv("data/counts_germany_combined.csv") %>% tbl_df()

rates <- all_counts %>% mutate(mort_rate=death_count/population_count)
# Pick a country

# Italy
rates_italy <- rates %>% filter(country=="ITA")


# Male matrix of values

block <- rates_italy %>% 
  filter(sex=="male" & age <=80) %>% 
  select(year, age, mort_rate) %>% 
  spread(key = year, value=mort_rate) 

bl_row <- as.character(block$age)
bl_col <- names(block)[-1]
block <- block %>% select(-1) %>% as.matrix
rownames(block) <- bl_row
colnames(block) <- bl_col


persp3d(block,
        col="lightgrey",
        specular="black", axes=FALSE, 
        box=FALSE, xlab="", ylab="", zlab="")  


lblock <- rates_italy %>% 
  filter(sex=="male" & age <= 80) %>% 
  mutate(lmort_rate = log(mort_rate)) %>% 
  select(year, age, lmort_rate) %>% 
  spread(key=year, value=lmort_rate)

bl_row <- as.character(lblock$age)
bl_col <- names(lblock)[1]
lblock <- lblock %>% select(-1) %>% as.matrix
rownames(lblock) <- bl_row
colnames(lblock) <- bl_col

persp3d(lblock,
        col="lightgrey",
        specular="black", axes=FALSE, 
        box=FALSE, xlab="", ylab="", zlab="")  

# 

