# Graphics in R with ggplot, part 3

library(ggplot2)
library(ggthemes)
library(patchwork)
library(colorblindr)
library(cowplot)
library(colorspace)
library(wesanderson)
library(ggsci)

d <- mpg

## Barplots
table(d$drv)

ggplot(data=d) + aes(x=drv) +
  geom_bar(color="black", fill="cornflowerblue")

# aesthetic mapping gives multiple groups for each bar
ggplot(data=d) + aes(x=drv, fill=fl) +
  geom_bar()

# stacked, but need to adjust transparency which is "alpha" parameter, this is not a nice graph though
ggplot(data=d) + aes(x=drv, fill=fl) +
  geom_bar(alpha=0.5, position="identity")

# better to use position=fill for proportional stacking (hides sample sizes)
ggplot(data=d) + aes(x=drv, fill=fl) +
  geom_bar(position="fill")

# best to use position=dodge for multiple bars
ggplot(data=d) + aes(x=drv, fill=fl) +
  geom_bar(position="dodge", color="black", linewidth=0.25)

# more typical bar plot has heights as the values themselves
d_tiny <- tapply(X=d$hwy, INDEX=as.factor(d$fl), FUN=mean) # calculate mean hwy for each fuel type
d_tiny <- data.frame(hwy=d_tiny) # create a single column df
d_tiny <- cbind(fl=row.names(d_tiny),d_tiny)

ggplot(data=d_tiny) + aes(x=fl, y=hwy, fill=fl) +
  geom_col()

# create a box plot instead, more informative
ggplot(data=d) + aes(x=fl, y=hwy, fill=fl) +
  geom_boxplot()

# overlay raw data, use jitter to spread out points
ggplot(data=d) + aes(x=fl, y=hwy) +
  geom_boxplot(fill="thistle", outlier.shape=NA) + # don't show outlier data points
  geom_point(position=position_jitter(width=0.2, height=0.5), color="grey60", size=2, alpha=0.5)
