# Welcome! ----

## Data Visualization Workshop Using R (SIS PhD Program)  
## November 30th, 2022                                   
## Shagun Gupta 

## Note on Use of Hashtags for Comments ----

# Single hashtags (#) are for headings OR additional descriptions added to the script to make it easier to follow. 
# Double hashtags (##) are for sub-headings.
# Triple hashtags (###) and so forth are for further nesting. 

# You can check out the R script outline to see how this system works! 
# (the last button on the top right menu of your R script window - next to Source)

-------------------------------------------------------------------------------------------------------------------
  
  

## Introduction to Tidyverse and ggplot2 ---- 

### Installing Tidyverse ----

# Let's install the tidyverse package. You may already have it installed on RStudio. 
#install.packages("tidyverse")
#install.packages("vctrs") #might need to do this separately to prevent few errors

# Installing packages isn't enough. We need to "call" it into the current session for use.
library(tidyverse)
#library(vctrs)

### What is the Tidyverse? ----

# The Tidyverse is a collection of R packages designed for data science. The collection includes the following:
# ggplot2 - grammar of graphics, powerful package of plotting and visualization
# tibble - the primary data structure in the tidyverse, a reimagining of the classic dataframe 
# tidyr - functions to create and work with "tidy" data 
# readr - functions to import different types of data 
# purrr - for functional programming (aka working with functions and vectors)
# dplyr - grammar of data manipulation (a set of verbs to manipulate data)
# stringr - functions to work with characters or "strings"
# forcats - functions to work with factors 

# In this workshop, we will be using a combination of these packages, but the focus will be on visualization
# using ggplot2. Here's an excellent explanation of how ggplot2 works: 
# https://englelab.gatech.edu/useRguide/introduction-to-ggplot2.html 

# We rely on packages like readr, tibble, dplyr to ensure our data is ready for plotting. We then use a combination 
# of aesthetics, geometries, facets, statistics, coordinates and themes to bring our data to life. 

# Let's get started! 

--------------------------------------------------------------------------------------------------------------------
  
  

## Visualization Using the Diamonds Dataset ----

### Load data ----

# This is a toy dataset built into the tidyverse package. You can call it using the following code: 
data("diamonds")

# The dataset should now be visible in your Environment. It's a <Promise> object which means it is an object that
# generally contains data loaded from a package. It becomes a dataframe the moment you use it. 

### Explore data ----

# Use head to view the first 6 rows 
head(diamonds)

# Use tail to view the last 6 rows
tail(diamonds)

# Use dim to view dimensions of the dataframe
dim(diamonds)
# It has 53,940 rows and 10 columns. 

# To view the data in a separate window
View(diamonds)

#Use glimpse from the dplyr package for a vertical preview of the data
glimpse(diamonds)

#Use summary to get a set of summary statistics for each variable 
summary(diamonds)

### Note on object types ---- 

# Each variable in the dataset is an object. Get into the habit of checking what type of object it is! 

# Use class to find out what you are working with 
class(diamonds$carat) #it is numeric 

# Use typeof to find out how R stores it 
typeof(diamonds$carat) #it is double 

# We can change the class of an object but not how R stores it in its memory. 

# Why do we care? One of the most common sources of errors or conflicts in R is conflicting object types. 
# In more advanced programming, coercion is used to select the more flexible object type when there is conflict. 
# Coercion is often useful. The hierarchy of coercion is logical < integer < numeric < character. 

# For example 

c(1.5, "hello") #R coerces 1.5 into a character object in the output 
              # because we are trying to combine conflicting arguments.

--------------------------------------------------------------------------------------------------------------------

### Basic visualizations ----

#### Bar charts ----

# to plot the cut (quality) of diamonds
ggplot(diamonds, aes(x = cut)) + #using the diamonds dataset, we want to plot cut on the x axis, count is the default on the y axis
  theme_minimal() + #using the bw theme for the plot region                     
  geom_bar()+ #for plotting bar charts 
  labs(x = "Quality of Diamonds", #label for x axis)
       y = "Count",       #label for y axis
       title = "Quality of the Diamonds") #label for title 

# We add fill to add color based on quality type
ggplot(diamonds, aes(x = cut, fill = cut)) + 
  theme_minimal() +
  geom_bar()+
  labs(x = "Quality of Diamonds",
       y = "Count",
       title = "Quality of the Diamonds")

# You can do the same for another variable, let's try it on clarity 
ggplot(diamonds, aes(x = clarity, fill = clarity)) +
  theme_minimal()+
  geom_bar()+
  labs(x = "Clarity of Diamonds",
       y = "Count",
       title = "Clarity of the Diamonds")

# We can combine variables into a stacked bar chart, let's plot quality of diamonds with clarity
ggplot(diamonds, aes(x = cut, fill = clarity)) +
  theme_minimal()+
  geom_bar()+
  labs(x="Quality of Diamonds",
       y="Count",
       title="Quality of the Diamonds with Clarity")


#### Histograms ----

# to plot a histogram for price of diamonds 
ggplot(diamonds, aes(x=price)) + 
  theme_minimal() + 
  geom_histogram() +
  labs(y="Count",
       x="Price",
       title="Price of Diamonds") #note what happens when you don't specify a theme 

# to plot a histogram of price of diamonds by cut 
ggplot(diamonds, aes(x=price, fill=cut)) + 
  theme_minimal() + 
  geom_histogram() +
  labs(y="Count",
       x="Price",
       title="Price of Diamonds by Cut")

# vary the bin size of histogram
ggplot(diamonds, aes(x=price, fill=cut)) + 
  theme_minimal() + 
  geom_histogram(bins = 50) + #adding binsize to plot, play around to find what works for your data 
  labs(y="Count",
       x="Price",
       title="Price of Diamonds by Cut")

# to plot a histogram of price of diamonds by clarity  
ggplot(diamonds, aes(x=price, fill=clarity)) +
  theme_minimal() + 
  geom_histogram(bins = 50) +
  labs(y="Count",
       x="Price",
       title="Price of Diamonds by Clarity")

# what else can we add to geom_histogram? Add color and outlines! 
ggplot(diamonds, aes(x=price, fill=clarity)) + 
  theme_minimal() + 
  geom_histogram(bins = 50, fill = "green", color = "black") +
  labs(y="Count",
       x="Price",
       title="Price of Diamonds by Clarity")

# to plot histograms by different groups 
ggplot(data = diamonds) +
  theme_minimal() + 
  geom_bar(aes(x = cut, fill = color), position = "dodge") + #position = dodge or dodge2 creates side by side bar charts)
  labs(y="Count",
       x="Cut",
       title="Diamonds by Cut and Color")

# customizing the legend 
install.packages("ggthemes")
library(ggthemes)

ggplot(data = diamonds) +
  geom_bar(aes(x = cut, fill = color), position = "dodge") + #position = dodge or dodge2 creates side by side bar charts)
  labs(y="Count",
       x="Cut",
       title="Diamonds by Cut and Color",
       fill = "Color") + #customizes the name of the legend generated using fill 
  theme_tufte() #try theme_economist 

# customizing the theme colors 
ggplot(data = diamonds) +
  geom_bar(aes(x = cut, fill = color), position = "dodge") + #position = dodge or dodge2 creates side by side bar charts)
  theme_minimal() + #comment out a chunk of code to see what happens if you remove or change it 
  scale_fill_brewer() + #there are several preset scales available in ggplot2 and ggthemes  
  labs(y="Count",
       x="Cut",
       title="Diamonds by Cut and Color",
       fill = "Color") #customizes the name of the legend generated using fill 


#### Density Plots ----

# These are smoothed versions of histograms.

ggplot(diamonds, aes(x=price)) +
  geom_density(aes(fill=factor(cut)), alpha=0.5) + #factor creates levels of the variable cut for the plot, alpha is for transparency
  theme_minimal() +
  #scale_fill_brewer() +
  labs(y="Count",
       x="Price",
       fill="Cut",
       title="Price of Diamonds by Cut")


ggplot(diamonds, aes(x=price)) +
  geom_density(aes(fill=factor(clarity)), alpha=0.3) + #factor creates levels of the variable cut for the plot, alpha is for transparency
  theme_minimal() +
  scale_fill_colorblind() +
  labs(y="Count",
       x="Price",
       fill="Cut",
       title="Price of Diamonds by Clarity")

#### Box Plots ---- 

# to plot price of diamonds by cut using box plots 
ggplot(diamonds, aes(x=cut, y=price)) + 
  theme_minimal() +
  geom_boxplot(fill = "grey") + #you can use fill to add color just like geom_bar 
  labs(y="Price",
       x="Cut",
       title="Box Plots of Price of Diamonds, Grouped by Cut")


# to plot price of diamonds by clarity using box plots 
ggplot(diamonds, aes(x=clarity, y=price)) + 
  theme_minimal() +
  geom_boxplot(fill = "grey") + #you can use fill to add color just like geom_bar 
  labs(y="Price",
       x="Cut",
       title="Box Plots of Price of Diamonds, Grouped by Cut")

# Invert the plots using coord_flip
ggplot(diamonds, aes(x=clarity, y=price)) + 
  theme_minimal() +
  geom_boxplot(fill = "grey") +  
  coord_flip() + #invert the scale of the plot 
  labs(y="Price",
       x="Cut",
       title="Box Plots of Price of Diamonds, Grouped by Cut")

#### Line Graphs ----

# Let's find out the relationship between carats and price.
ggplot(diamonds, aes(x=carat, y=price)) +
  theme_minimal() + 
  geom_smooth() + #try se=F to remove the confidence interval shading 
  labs(y="Price",
       x="Carat")

# To produce a straight line, we use the linear method. Note: the default is the generalized additive model (GAM). 

ggplot(diamonds, aes(x=carat, y=price)) +
  theme_minimal() + 
  geom_smooth(method="lm", size=2) + #how do we add color here? 
  labs(y="Price",
       x="Carat")

# We can plot multiple line graphs as well. 

ggplot(diamonds, aes(x=carat, y=price)) +
  theme_minimal() + 
  geom_smooth(aes(color=clarity)) + 
  labs(y="Price",
       x="Carat") + 
  scale_color_hue()

# How would you plot the previous graph using the linear method? 



# Let's start using the %>% (pipe) operator to write lines of code. 

#### Violin Plots ---- 

diamonds %>% #think of the %>% as "and then", you're telling R to perform the next function 
  ggplot(aes(x = clarity, y = price, group = cut, fill = cut)) +
  theme_minimal() + 
  geom_violin() +
  labs(y="Price",
       x="Clarity", 
       fill="Cut")

#### Scatter Plots ----

# Let's start with a very simple scatter plot of carat and price. 
diamonds %>% 
  ggplot(aes(x = carat, y = price)) +
  theme_minimal() + 
  geom_point() +
  labs(y="Price",
       x="Carat")

# Add another layer: clarity. 
diamonds %>% 
  ggplot(aes(x = carat, y = price, color=clarity)) +
  theme_minimal() + 
  geom_point() +
  labs(y="Price",
       x="Carat", 
       color="Clarity")

# Add another layer: cut. 
diamonds %>% 
  ggplot(aes(x = carat, y = price, color=clarity, size=cut)) + #or use shape=cut and see what happens. Be sure to change the label.
  theme_minimal() + 
  geom_point() +
  labs(y="Price",
       x="Carat", 
       color="Clarity",
       size="Cut")

# Let's combine some geom elements!
diamonds %>% 
  ggplot(aes(x=carat, y=price)) + 
  geom_point() + 
  geom_smooth() + #you can manipulate se, method, size, color as usual. 
  labs(y="Price",
       x="Carat") 

#### Faceting ----

diamonds %>% 
  ggplot(aes(x=carat, y=price, color=clarity)) + 
  geom_point() + 
  #geom_smooth(method="lm") + 
  facet_wrap(~ cut) + 
  labs(y="Price",
       x="Carat") 

# Another example using some data manipulation. 

# Let's re-categorize color and clarity. 

df_diamonds<- diamonds %>% 
  mutate(color = ifelse(color == "D" | color == "E" | color == "F", 
                        "Colorless", 
                        "Yellowish"),
         clarity = ifelse(clarity == "I1" | clarity == "SI2" | clarity == "SI1", 
                          "Included", 
                          "Nearly Flawless"))

# Generate the base plot
plot_base <- ggplot(df_diamonds) +
  theme_minimal() + 
  geom_histogram(aes(x = price),
                 color = "#403636",  
                 fill = "#be6380",  #use color-hex.com to find hex codes and color palettes. 
                 alpha = 0.7) +
  labs(x = "Price",
       y="Count") ; plot_base 

# You can also view the base plot separately. 
plot_base

# We can then add lines of code to the base plot. 
plot_base +
  facet_grid(facets = color ~ cut + clarity) + #this will visualize our data manipulation in one way. 
  scale_x_continuous(breaks = c(5000, 15000)) #reduces x-axis breaks

#Alternate labeling strategies
plot_base +
  facet_grid(facets = color ~ cut + clarity) + #this will visualize our data manipulation in one way. 
  scale_x_continuous(breaks = c(5000, 15000)) + #reduces x-axis breaks
  ggtitle("Price of Diamonds by Cut, Color and Clarity")

  #xlab() + #label for x axis
  #xlim() + #set x axis limits, eg. xlim (5000, 15000)
  #ylab() + #label y axis
  #ylim()   #set y axis limits 

ggsave("myplot.pdf", width=15, height=5) #saves your file in your project folder. You can vary file type, png, jpeg, pdf etc. 
#manually change size using height =  and width = as options after the file name. 

#### Bonus Code ----

# Visualize summary statistics
diamonds %>%
ggplot() + 
  theme_minimal() + 
  stat_summary(aes(x = cut, y = depth), fun.ymin = min, fun.ymax = max, fun.y = median) + 
  labs(x = "Cut", 
       y = "Depth",       
       title = "Median Depth of Diamonds by Cut") 

# Heatmap with mtcars data 
data("mtcars")
data <- as.matrix(mtcars) #the data needs to be in matrix form for heatmaps 
heatmap(data)

heatmap(data, Colv = NA, Rowv = NA, scale="column")

----------------------------------------------------------------------------------------------------------------------------------------------------
  
## Visualization Using the WIID Dataset ---- 

# The following visualizations use the World Income Inquality Database (version 31 May 2021), available here:
# https://www.wider.unu.edu/database/previous-versions-wiid 

# Go ahead and clear your R environment - this is good practice if you're shifting from one dataset to another. 
rm(list = ls())
# This will not unload any packages loaded in the same R session. 

#install.packages("readxl")
library(readxl)

# I highly recommend using R projects because all your files stay in one place. You can use the following code to load a file.
wiid <- read_excel(file.choose())

# Explore the data 
head(wiid)
tail(wiid)
glimpse(wiid)
summary(wiid)

# To view the dataset
view(wiid)

### Scatter Plots ---- 

# Let's start with a scatter plot. 
wiid %>% 
  filter(country == "Canada" | country == "United States" | country == "Mexico") %>%
  ggplot(aes(x = year, y = gini, color = country)) +
  geom_point() 

#this plot isn't very meaningful. How do we make this better? Take the mean of gini. 
wiid %>% 
  filter(country == "Canada" | country == "United States" | country == "Mexico") %>%
  group_by(country, year) %>%
  summarize(gini_mean = mean(gini, na.rm = TRUE)) %>%
  ggplot(aes(x = year, y = gini_mean, color = country)) +
  geom_point() +
  theme_minimal() +
  labs(x = "Year",
       y="Mean of Gini",
       color="Country",
       title="Mean Gini for North America by Year")

# Slightly advanced scatter plot for income inequality in Europe. 
wiid %>%
  filter(region_un == "Europe") %>%
  group_by(country) %>%
  summarize(mean_gini = mean(gini, na.rm = TRUE)) %>%
  ggplot(., aes(x = reorder(country, mean_gini, na.rm = TRUE), y = mean_gini)) +
  geom_point() +
  labs(x = "", y = "Average Gini Index Scores", 
       title = "Income Inequality in Europe") +
  coord_flip() +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 7))

# Let's do a combination of scatter and line plots.

wiid$newginimean <- mean(wiid$gini, na.rm=TRUE)
#created a new variable average of gini across the dataset. 

wiid %>%
  filter(region_un=="Americas")%>%
  group_by(region_un_sub, year, newginimean)%>%
  summarize(amgini_median = median(gini, na.rm=TRUE)) %>%
  ggplot(aes(x = year, y = amgini_median, color = region_un_sub)) + 
  geom_point(alpha = 0.3, aes(color = region_un_sub)) +
  geom_smooth(method="lm", alpha = 0.2, size = 1, se=FALSE) +
  geom_smooth(aes(x = year, y = newginimean), method = "lm", color = "#999999",
              inherit.aes = FALSE) + 
  #geom_smooth(method=lm, color="light gray", size = 1, se=FALSE) + #I initially used this code
  scale_color_manual(values = c("#c90076", "#6aa84f", "#2986cc", "#f1c232")) +
  labs(x = "Year", y = "Median Gini Index Scores", 
       title = "Income Inequality in the Americas",
       color="Americas") + 
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5)) #center align the title 


### Density Plots ----

# Let's say we want to create a density plot for Gini scores in Asia. First we need to figure what sub-regions exist in the data.
wiidsubregions <- unique(wiid$region_un_sub) #create a new object for sub-regions
wiidsubregions #view subregions

wiidregions <- unique(wiid$region_un) #do the same for regions
wiidregions #view regions

# Since we're plotting sub-regions here, check the class of the object. Good practice!
class(wiid$region_un_sub) #should be character 

# Let's plot.
wiid %>%
  filter(region_un_sub == c("Southern Asia", "Western Asia", "Eastern Asia", "South-eastern Asia", "Central Asia")) %>%
  ggplot(aes(x = gini, fill = region_un_sub)) +
  geom_density(alpha = 0.3) +
  labs(x = "Gini Index Density",
       y = "Asia Sub-Regions",
       title = "Income Inequality in Asia", 
       fill = "Asia Sub-Regions") +
  scale_fill_manual(values = c("#80182f", "#ff8916", "#00889f", "#d16446", "#e6d1d5")) +
  theme_minimal() 

### Histogram ----

wiid %>%
  ggplot(aes(x = gini, fill = region_un)) +
  geom_histogram(alpha = 0.6, color = "black") +
  labs(x = "Gini Index",
       y = "UN Region",
       fill = "UN Region") + 
  scale_fill_manual(values = c("#cc3300", "#ff9966", "#ffcc00", "#99cc33", "#339900")) +
  theme_minimal()

### Faceting ---- 

wiid %>%
  filter(year >= "1940") %>% #scores for 1940 and after
  group_by(year, gini) %>%
  ggplot(aes(x = year, y = gini, color = region_un)) +
  geom_point() +  
  facet_grid(~ region_un) +
  labs(x = "Year",
       y = "Gini Index",
       fill = "Gini Index",
       title="Income Inequality by UN Region") +
  scale_color_manual(values= c("#d01f31", "#f68121", "#fbdd0b", "#007b61", "#0072b9")) +
  theme_minimal() %+replace%
  theme(legend.position = "none", axis.text.x = element_text(size = 9)) +
  guides(x = guide_axis(n.dodge = 1, angle = 45)) 

### Animated Plots* ---- 

# This code is glitching last I checked, I will try to see what the issue is. 

#install.packages("gganimate")
#install.packages("devtools")
library(gganimate)
library(devtools)

wiid_animated <- wiid %>%
  filter(year > 2000 & country == c("Austria", "Belgium", "France", "Germany",
                                    "Luxembourg", "Netherlands", "Switzerland", 
                                    "United States")) %>%
  group_by(country, year) %>%
  summarize(mean_gini = mean(gini)) %>%
  ggplot(aes(x = year, y = mean_gini, color = country)) +
  geom_path() +
  geom_point(size = 0.5) +
  labs(x = "Year", 
       y = "Gini Index",
       title = "Income Inequality in Western European Countries vs. United States") +
  scale_color_manual(values = c("#e06666", "#93c47d", "#6fa8dc", "#741b47", "#e69138", 
                                "#8183dd", "#d7d203",
                                "#000000"), name = "Country") +
  theme(legend.position = "none") +
  transition_reveal(along = year) + 
  shadow_wake(wake_length = 0.2, size = 1, alpha = FALSE, colour = 'grey92') +
  theme_minimal()

wiid_animated

animate(wiid_animated)

anim_save("wiid_animated.gif")
  

# Sources ----

# https://bookdown.org/yih_huynh/Guide-to-R-Book/tidyverse.html
# https://ggplot2-book.org/introduction.html
# https://englelab.gatech.edu/useRguide/introduction-to-ggplot2.html
# http://varianceexplained.org/RData/code/code_lesson2/
# https://bookdown.org/yih_huynh/Guide-to-R-Book/diamonds.html



###################################################################End of R Script #################################################################



