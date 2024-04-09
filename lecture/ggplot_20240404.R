# Graphics in R with ggplot

library(patchwork)
library(ggplot2)
library(ggthemes)


# skeleton of a ggplot call

# p1 <- ggplot(data=<DATA>) + # can subsequently call by just column name or df$column
#   aes(<MAPPINGS>) +  # what goes to x and what goes to y
#   geom_FUNCTION(aes(<MAPPINGS>), stat=<STAT>, position=<POSITION>) + # what is the shape of the graph or other pieces
#   coordinate_FUNCTION +
#   facet_FUNCTION

ggsave(plot=p1, filename="MyPlot", width=5, height=5, units="in", device="pdf")



# basic graph types ----

d <- mpg
str(d)
table(d$fl)


# histogram
ggplot(data=d) + aes(x=hwy) +
  geom_histogram()

ggplot(data=d) + aes(x=hwy) +
  geom_histogram(fill="cornflowerblue", color="black")

ggplot(data=d) + aes(x=hwy, fill="green") + # color is in aes() and R is trying to color by groups and you're just giving the group a name
  geom_histogram()

ggplot(data=d) + aes(x=hwy, fill=I("seagreen"), color=I("black")) + # this fills by color (I=identity)
  geom_histogram()



# density plot

ggplot(data=d) + aes(x=hwy) +
  geom_density(fill="mintcream", color="darkgrey")



# scatter plot
ggplot(data=d) + aes(x=displ, y=hwy) +
  geom_point() + # add scatter points
 # geom_smooth() # add a best fit spline with default 95% CI
geom_smooth(method="lm", col="seagreen") # add a best fit line based on linear model

ggplot(data=d) + aes(x=displ, y=hwy) +
  geom_point() + 
  geom_smooth() +
  geom_smooth(method="lm", col="seagreen")



# boxplot
ggplot(data=d) + aes(x=fl, y=cty) + # x is categorical and y is continuous
  geom_boxplot()

ggplot(data=d) + aes(x=fl, y=cty) + 
  geom_boxplot(fill="thistle") # all the same color

ggplot(data=d) + aes(x=fl, y=cty, fill=fl) + # color based on fuel type, adds a legend
  geom_boxplot()


# bar plot (long format)
ggplot(data=d) + aes(x=fl) +
  geom_bar(fill="thistle", color="black")


# bar plot w/ specified values (geom_col)
x_treatment <- c("contol", "low", "high")
y_response <- c(12,2.5,22.9)
summary_data <- data.frame(x_treatment, y_response)

ggplot(data=summary_data) + aes(x=x_treatment, y=y_response) +
  geom_col(fill=c("grey50", "goldenrod","goldenrod"), col="black")



# Basic curves and functions -----
my_vec <- seq(1,100, by=0.1)

# simple mathematical functions
d_frame <- data.frame(x=my_vec, y=sin(my_vec))
ggplot(data=d_frame) + aes(x=x, y=y) +
  geom_line()


# probability functions
d_frame <- data.frame(x=my_vec, y=dgamma(my_vec, shape=5, scale=3))
ggplot(data=d_frame) + aes(x=x, y=y) +
  geom_line()


# user-defined functions
my_fun <- function(x) sin(x) + 0.1*x
d_frame <- data.frame(x=my_vec, y=my_fun(my_vec))
ggplot(data=d_frame) + aes(x=x, y=y) +
  geom_line()



# Theme and fonts ----
# default is just okay, let's change it!

p1 <- ggplot(data=d) + aes(x=displ, y=cty) +
  geom_point() # the default

## themes
p1 + theme_classic() # classic theme, removes background/grid 
p1 + theme_linedraw() # lighter grid background
p1 + theme_dark() # dark grey grid background
p1 + theme_base() # mimics base R style
p1 + theme_par() # matches current parameter settings in base
p1 + theme_void() # only shows data points
p1 + theme_solarized() # light yellow background, good for webpages
p1 + theme_economist() # specialized themes from Economist
p1 + theme_grey() # default theme

## modify font and font size
p1 + theme_classic(base_size=40, base_family="serif") # base_size changes the size of axis and font, base_family is font type
# defaults: theme_grey, base_size=16, base_family="Helvetica"
# font families:Times, Ariel, Monaco, Courier, Helvetica, serif, sans

## use coord_flip to invert entire plot
p2 <- ggplot(data=d) + aes(x=fl, fill=fl) +
  geom_bar()

p2 + coord_flip()



## minor theme modifications

p3 <- ggplot(data=d) + aes(x=displ, y=cty) +
  geom_point(size=7, shape=21, fill="steelblue", color="black") +
  labs(title="graph title", 
       subtitle="extended subtitle below main title",
       x="x axis label",
       y="y axis label") +
  xlim(0,4) + ylim(0,20)


