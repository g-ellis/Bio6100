# Graphics in R with ggplot, part 3

library(ggplot2)
library(ggthemes)
library(patchwork)
library(colorblindr)
library(cowplot)
library(colorspace)
library(wesanderson)
library(ggsci)
library(scales)

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



### using color ###

# color visualizations
my_cols <- c("thistle", "tomato", "cornsilk", "cyan", "chocolate")
demoplot(my_cols, "map") # from colorspace package, how do the colors look together?
demoplot(my_cols, "bar")
demoplot(my_cols, "scatter")
demoplot(my_cols, "heatmap")
demoplot(my_cols, "spine")
demoplot(my_cols, "perspective")


# working with black and white
my_greys <- c("grey20", "grey50", "grey80") # built-in greys, 0=black 100=white
demoplot(my_greys, "bar")

my_greys2 <- grey(seq(from=0.1, to=0.9, length.out=10)) # grey() function
demoplot(my_greys2, "heatmap")

# converting color plots to b+w
p1 <- ggplot(data=d) + aes(x=as.factor(cyl), y=cty, fill=as.factor(cyl)) +
  geom_boxplot()
p1_des <- colorblindr::edit_colors(p1, desaturate)
plot(p1_des) # default R colors look the same in b+w

# manually change colors, now they look okay in b+w
p2 <- p1 + scale_fill_manual(values=c("red", "blue", "green", "yellow"))
plot(p2)
p2_des <- colorblindr::edit_colors(p2, desaturate)                             
plot(p2_des)


# using alpha transparency for histograms
x1 <- rnorm(n=100, mean=0)
x2 <- rnorm(n=100, mean=2.7)
df <- data.frame(v1=c(x1, x2))
lab <- rep(c("Control", "Treatment"), each=100)
df <- cbind(df, lab)
str(df)

ggplot(data=df) + aes(x=v1, fill=lab) +
  geom_histogram(position="identity", alpha=0.5, color="black")


# color customizations
ggplot(data=d) + aes(x=as.factor(cyl), y=cty) +
  geom_boxplot()

ggplot(data=d) + aes(x=as.factor(cyl), y=cty, fill=as.factor(cyl)) +
  geom_boxplot()

ggplot(data=d) + aes(x=as.factor(cyl), y=cty, fill=as.factor(cyl)) +
  geom_boxplot() +
  scale_fill_manual(values=my_cols)

# scatterplot with no color
ggplot(d) + aes(x=displ, y=cty) +
  geom_point(size=3)

# with default color
ggplot(d) + aes(x=displ, y=cty, col=as.factor(cyl)) +
  geom_point(size=3)
my_cols <- c("red", "blue", "green", "yellow")

# with custom color
ggplot(d) + aes(x=displ, y=cty, col=as.factor(cyl)) +
  geom_point(size=3) + 
  scale_color_manual(values=my_cols)


# gradients with default
ggplot(d) + aes(x=displ, y=cty, col=hwy) + 
  geom_point(size=3)

# gradients with custom, 2 colors
ggplot(d) + aes(x=displ, y=cty, col=hwy) + 
  geom_point(size=3) +
  scale_color_gradient(low="green", high="red")

# gradients with custom, 3 colors
mid <- median(d$hwy)
ggplot(d) + aes(x=displ, y=cty, col=hwy) + 
  geom_point(size=3) +
  scale_color_gradient2(midpoint=mid, low="blue", mid="white", high="red")

# gradients with custom n colors
ggplot(d) + aes(x=displ, y=cty, col=hwy) + 
  geom_point(size=3) +
  scale_color_gradientn(colors=c("blue", "green", "yellow", "purple", "orange"))


# sometimes choosing your own colors doesn't work well, that's where color palettes come in
print(wes_palettes)

demoplot(wes_palettes$GrandBudapest1, "pie")

demoplot(wes_palettes[[6]][1:3], "bar") # first 3 color values from the 2nd palette

ggplot(data=d) + aes(x=as.factor(cyl), y=cty, fill=as.factor(cyl)) +
  geom_boxplot() + 
  scale_fill_manual(values=wes_palettes$GrandBudapest2[1:4])

library(RColorBrewer)
display.brewer.all()
display.brewer.all(colorblindFriendly = TRUE)
demoplot((brewer.pal(4, "Accent")), "bar")
demoplot(brewer.pal(11, "Spectral"), "heatmap")                    

my_cols <- c("grey75", brewer.pal(3, "Blues"))
ggplot(data=d) + aes(x=as.factor(cyl), y=cty, fill=as.factor(cyl)) +
  geom_boxplot() +
  scale_fill_manual(values=my_cols)

library(scales)
show_col(my_cols)


# Viridis palettes in base R

# make a heat map
xVar <- 1:30
yVar <- 1:5
myData <- expand.grid(xVar=xVar, yVar=yVar)
zVar <- myData$xVar + myData$yVar + 2*rnorm(n=150)
myData <- cbind(myData, zVar)

p4 <- ggplot(data=myData) + aes(x=xVar, y=yVar, fill=zVar) +
  geom_tile()

# custom colors
p4 + scale_fill_gradient2(midpoint=19, 
                       low="brown",
                       mid=grey(0.8),
                       high="darkblue")
# viridis scale
p4 + scale_fill_viridis_c()
# options: viridis (default), cividis, magma, inferno, plasma, etc...
p4 + scale_fill_viridis_c(option="cividis")
p4 + scale_fill_viridis_c(option="magma")

plot(edit_colors(p4 + scale_fill_viridis_c(), desaturate))
