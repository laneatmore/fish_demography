library(dplyr)
library(ggplot2)

setwd('~/OneDrive - Universitetet i Oslo/Bioinformatics/Papers/North_Sea/angsd_sfs/')

CelticDowns <- read.csv('download/celticdowns.folded.thetas.idx.pestPG', sep = '\t', head=TRUE)
NorthSea <- read.csv('download/northsea.folded.thetas.idx.pestPG', sep = '\t', head=TRUE)
IsleOfMan <- read.csv('download/isleofman.folded.thetas.idx.pestPG', sep = '\t', head=TRUE)
lyminge <- read.csv('download/binsa_8th.folded.thetas.idx.pestPG', sep = '\t', head=TRUE)
#bbl <- read.csv('download/binsa_11th.folded.thetas.idx.pestPG', sep = '\t', head=TRUE)
#coppergate <- read.csv('download/binsa_13th.folded.thetas.idx.pestPG', sep = '\t', head=TRUE)

head(CelticDowns)

CD <- CelticDowns %>%
  select('Chr', 'WinCenter', 'tW', 'tH', 'Tajima') %>%
  mutate(pop = "Celtic/Downs")
NS <- NorthSea %>%
  select('Chr', 'WinCenter', 'tW', 'tH', 'Tajima') %>%
  mutate(pop = "North Sea")
IM <- IsleOfMan %>%
  select('Chr', 'WinCenter', 'tW', 'tH', 'Tajima') %>%
  mutate(pop = "Isle Of Man")
LY <- lyminge %>%
  select('Chr', 'WinCenter', 'tW', 'tH', 'Tajima') %>%
  mutate(pop = "Lyminge")

CD <- CD[!(CD$Chr %in% "MT"),]
NS <- NS[!(NS$Chr %in% "MT"),]
IM <- IM[!(IM$Chr %in% "MT"),]
LY <- LY[!(LY$Chr %in% "MT"),]

pi <- ggplot() +
  geom_boxplot(aes(CD$pop, CD$tH, fill=CD$pop)) +
  geom_boxplot(aes(NS$pop, NS$tH, fill=NS$pop)) +
  geom_boxplot(aes(IM$pop, IM$tH, fill=IM$pop)) +
  geom_boxplot(aes(LY$pop, LY$tH, fill=LY$pop)) +
  ylab('Pi') +
  xlab('Population') +
  theme_bw() +
  theme(legend.position='none')
pi


Wat_theta <- ggplot() +
  geom_boxplot(aes(CD$pop, CD$tW, fill=CD$pop)) +
  geom_boxplot(aes(NS$pop, NS$tW, fill=NS$pop)) +
  geom_boxplot(aes(IM$pop, IM$tW, fill=IM$pop)) +
  geom_boxplot(aes(LY$pop, LY$tW, fill=LY$pop)) +
  ylab('Wattersons Theta') +
  xlab('Population') +
  theme_bw() +
  theme(legend.position='none')
Wat_theta


tajD <- ggplot() +
  geom_boxplot(aes(CD$pop, CD$Tajima, fill = CD$pop)) +
  geom_boxplot(aes(NS$pop, NS$Tajima, fill = NS$pop)) +
  geom_boxplot(aes(IM$pop, IM$Tajima, fill = IM$pop)) +
  geom_boxplot(aes(LY$pop, LY$Tajima, fill = LY$pop)) +
  xlab('Population') +
  ylab("Tajima's D") +
  theme_bw() +
  scale_fill_manual("Population", values = c("North Sea" = "darkred", 
                                             "Celtic/Downs" = "lightblue", 
                                             "Isle Of Man" = "orange",
                                             "Lyminge" = 'brown3')) +
  theme(legend.position = 'none')

pdf('../PLOTS/TajD_by_pop.pdf')
tajD
dev.off()
