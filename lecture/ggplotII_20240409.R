# Graphics in R with ggplot, part 2

library(ggplot2)
library(ggthemes)
library(patchwork)
d <- mpg


# Plotting multiple panel graphs with patchwork ----
g1 <- ggplot(data=d) + aes(x=displ, y=cty) +
  geom_point() +
  geom_smooth()

g2 <- ggplot(data=d) + aes(x=fl) +
  geom_bar(fill="tomato", color="black") +
  theme(legend.position="none")

g3 <- ggplot(data=d) + aes(displ) +
  geom_histogram(fill="royalblue", color="black")

g4 <- ggplot(data=d) + aes(x=fl, y=cty, fill=fl) +
  geom_boxplot() +
  theme(legend.position = "none")


# place two plots horizontally
g1 + g2


# place three plots vertically
g1 + g2 + g3 + plot_layout(ncol=1)


# change relative area of each plot
g1 + g2 + plot_layout(ncol=1, heights=c(2,1))
g1 + g2 + plot_layout(ncol=2, widths=c(2,1))


# add a spacer plot
g1 + plot_spacer() + g2


# use nested layouts
g1 + {
  g2 + {
    g3 + 
      g4 +
      plot_layout(ncol=1)
  }
} + plot_layout(ncol=1)


# - operator for subtrack placement
g1 + g2 - g3 + plot_layout(ncol=1)


# / and | for intuitive layouts
(g1 | g2 | g3)/g4
(g1 | g2)/(g3 | g4)


# add title, etc. 
g1 + g2 + plot_annotation("This is a title", caption="made with patchwork")

# change styling of elements
g1 + g2 + plot_annotation("This is a title", caption="made with patchwork", 
                          theme = theme(plot.title=element_text(size=16)))


# add tags to plots
g1 / (g2 | g3) + plot_annotation(tag_level="A")


# swapping axis orientations 
g3a <- g3 + scale_x_reverse() #now goes from high to low
g3b <- g3 + scale_y_reverse()
g3c <- g3 + scale_x_reverse() + scale_y_reverse()
(g3 | g3a)/(g3b | g3c)

(g3 + coord_flip() | g3a + coord_flip())/(g3b + coord_flip() | g3c + coord_flip())

ggsave(filename="myplot.pdf", plot=g3, device="pdf", width=20, height=20, units="cm", dpi=300)




# Mapping aesthetic variables ----

# mapping a discrete var to a point color
m1 <- ggplot(data=d) + aes(x=displ, y=cty, color=class) + # assign points color based on car class
  geom_point(size=3)

# to a point shape
m2 <- ggplot(data=d) + aes(x=displ, y=cty, shape=class) + 
  geom_point(size=3) # comes with a warning, ggplot only has 6 shapes

# to a point size
m3 <- ggplot(data=d) + aes(x=displ, y=cty, size=class) + 
  geom_point()


# mapping a continuous variable to point size, bubble plot
m1 <- ggplot(data=d) + aes(x=displ, y=cty, size=hwy) + 
  geom_point()

# to a color
m1 <- ggplot(data=d) + aes(x=displ, y=cty, color=hwy) + 
  geom_point(size=3)


# mapping two variables to different aesthetics
m1 <- ggplot(data=d) + aes(x=displ, y=cty, shape=class, color=hwy) +
  geom_point(size=5)
m1 <- ggplot(data=d) + aes(x=displ, y=cty, shape=drv, color=fl) + # drv has fewer categories, so this looks nicer
  geom_point(size=4) 


# use size, shape, and color, to indicate 5 attributes! (not recommended)
m1 <- ggplot(data=d) + aes(x=displ, y=cty, shape=drv, color=fl, size=hwy) +
  geom_point()


# mapping a var to the same aesthetic in two different geoms
m1 <- ggplot(data=d) + aes(x=displ, y=cty, color=drv) +
  geom_point(size=2) +
  geom_smooth(method="lm")


# facet variables for more effective groupings
m1 <- ggplot(data=d) + aes(x=displ, y=cty) +
  geom_point()
m1 + facet_grid(class~fl) # row ~ column
m1 + facet_grid(fl~class)

m1 + facet_grid(class~fl, scales="free_y") # default is the same scale for all aspects, but can change that
m1 + facet_grid(class~fl, scales="free")

m1 + facet_grid(.~class) # add just one facet dimension
m1 + facet_grid(class~.) 

m1 + facet_wrap(~class) # wrapping individual plots instead of forcing them into a grid

m1 + facet_wrap(~class + fl)

m1 + facet_wrap(~class + fl, drop=FALSE) # now includes "empty" graphs

m1 <- ggplot(data=d) + aes(x=displ, y=cty, color=drv) + 
  geom_point()
m1 + facet_grid(.~class) # aes from original ggplot carries over

m1 <- ggplot(data=d) + aes(x=displ, y=cty, color=drv) + 
  geom_smooth(se=FALSE, method="lm") # only show the regression line
m1 + facet_grid(.~class)

# continuous variables and boxplots
m1 <- ggplot(data=d) + aes(x=displ, y=cty) +
  geom_boxplot()
m1 + facet_grid(.~class)

m1 <- ggplot(data=d) + aes(x=displ, y=cty, fill=drv) + 
  geom_boxplot()
m1 + facet_grid(.~class)



## mapping aesthetics within geoms

# standard plot
p1 <- ggplot(data=d) + aes(x=displ, y=hwy) +
  geom_point() + 
  geom_smooth()

# break out the drive types and apply geoms to each
p1 <- ggplot(data=d) + aes(x=displ, y=hwy, group=drv) +
  geom_point() + 
  geom_smooth()

# a better way to do the above since now the points are colored by drv
p1 <- ggplot(data=d) + aes(x=displ, y=hwy, color=drv) +
  geom_point() + 
  geom_smooth()
p1 <- ggplot(data=d) + aes(x=displ, y=hwy, fill=drv) +
  geom_point() + 
  geom_smooth()
p1 <- ggplot(data=d) + aes(x=displ, y=hwy, color=drv, fill=drv) +
  geom_point() + 
  geom_smooth()

# can manipulate data within geoms
p1 <- ggplot(data=d) + aes(x=displ, y=hwy, color=drv) + 
  geom_point(data=d[d$drv=="4",]) +
  geom_smooth()

# or instead of subsetting, just map an aesthetic within geom
p1 <- ggplot(data=d) + aes(x=displ, y=hwy) +
  geom_point(aes(color=drv)) + # only coloring points
  geom_smooth() # this still inherits base aes
p1 <- ggplot(data=d) + aes(x=displ, y=hwy) +
  geom_point(aes(color=drv)) + # only coloring points
  geom_smooth(color="black")

# conversely, map the smooth but not the points
p1 <- ggplot(data=d) + aes(x=displ, y=hwy) +
  geom_point() + 
  geom_smooth(aes(color=drv))

# subset data in the base layer
p1 <- ggplot(data=d[d$drv!="4",]) + aes(x=displ, y=hwy) +
  geom_point(aes(color=drv)) +
  geom_smooth()
