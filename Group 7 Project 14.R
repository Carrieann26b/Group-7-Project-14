Project14 <- read.csv("DAProject14.csv")

library(ggplot2)
library(dplyr)
library(skimr)
library(moderndive)
Project14|> skim()

Project14$Year <- as.factor(Project14$Year)
ggplot(data = Project14, aes(x = N)) +
  geom_histogram() +
  labs(x = "Number children", title = "Histogram of N")

ggplot(data = Project14, aes(x = Y)) +
  geom_histogram() +
  labs(x = "Number children Susceptible", title = "Histogram of Y")


ggplot(data = Project14, aes(x = Y, y = N)) +
  geom_jitter(width = 0.3)
#maybe delete??^^

ggplot(data = Project14, aes(x = Year, y = Y)) +
  geom_jitter(width = 0.3)

ggplot(data = Project14, aes(x = Year, y = Y)) +
  geom_boxplot() +
  labs(x = "Year Collected", y = "Number of pre-school children susceptible to measles",
       title = "Number of pre-school children susceptible to measles \n categorised by year")
#keep this plot

Project14_means <- summarise(Project14,mean_Y = mean(Y), mean_N = mean(N), .by = Year)
Project14_means$mean_prop <- Project14_means$mean_Y/Project14_means$mean_N

qqnorm(Project14_means$mean_N, pch = 1, frame = F)
#maybe delete

ggplot(data = Project14, aes(x = N, fill = Year)) +
  geom_bar() + 
  facet_wrap(Year~.)
#this graph tells us the count of IZ that have the same value of N separated by year

ggplot(data = Project14, aes(x = Y, fill = Year)) +
  geom_bar() + 
  facet_wrap(Year~.)
#this graph tells us the count of IZ that have the same value of Y separated by year

summary(Project14)

#look at QQ plots etc. (EDA) so that we can see if data needs transformed, check what assumptions are
#fulfilled and get the data ready for formal analysis (not sure if formal can be done at the same time as exploratory)
#See if can get the EDA() or similar function (check GLM data analysis notes) brought in and use to check assumptions

#Keep following plot, tells us info on mean children susceptible to measles.
ggplot(Project14_means, aes(x = Year, y = mean_Y)) + 
  geom_point() 
#can see a difference after the retraction of the article, decrease in susceptibility

#Edinburgh exhibited a change after 2004, did not necessarily occur in 2004 (could be in 2005)

#keep following project
model.project <- lm(Y ~ Year + N, data = Project14)
summary(model.project)

