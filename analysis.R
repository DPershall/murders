library(tidyverse)
load("rda/murders.rda")

murders %>% mutate(abb = reorder(abb, rate)) %>% 
  ggplot(aes(abb, rate)) +
  geom_bar(width = 0.5, stat = "identity", color = "black") +
  coord_flip()

ggsave("figs/barplot.png")


r <- murders %>% 
  summarize(rate = sum(total) /  sum(population) * 10^6) %>%
  pull(rate)
r

murders %>% ggplot(aes(population/10^6, total, label = abb)) +
  geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") + #murder rate
  geom_point(aes(color=region), size = 3) +
  geom_text_repel() + 
  scale_x_log10() + 
  scale_y_log10() + 
  xlab("Population in millions (log scale)") +
  ylab("Total number of murders") +
  ggtitle("US Gun Murders in 2010") + 
  scale_color_discrete(name = "Region") + 
  theme_economist()

ggsave("figs/USgunmurders2010.png")