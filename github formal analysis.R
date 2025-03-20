Here we will fit a simple linear regression model to the `measles` data.

```{r}
#|eval: true

library(ggplot2)
library(tidymodels)

measles <- read.csv("DAProject14.csv")
prop  <- measles$Y/measles$N

measles$prop <- prop

model <- linear_reg() |>
  fit(Year~prop, data=measles)
model$fit
```

Our best-fitting line to the data is:
  
  $$
  \widehat{prop}= \hat{\alpha} + \hat{\beta}x_i = 2014.49 - 65.02\cdot{year}
$$
  
  where:
  
  -   $\hat{\alpha}$=2014.49 is the intercept coefficient and means that for a given IZ with a `Year=0`, their average `prop` would be 2014.49. Note that `Year=0` is not actually possible in our data set.

-   $\hat{\beta}$=-65.02 is the slope coefficient associated with the explanatory variable `proportion`. This summarises the relationship between our response variable, `Year`, and our explanatory variable `prop`. Since the slope coefficient is negative, this means that `Year` and `prop` have a negative linear relationship, i.e. as `prop` increases, `Year` decreases. Furthermore, for every 1 unit increase in `prop`, there is an associated decrease of, on average 65.02 units of `Year`.

Here is the model summary.

```{r}
#|eval: true

tidy(model)

```

@fig-prop-year-lm is a plot of our data with a line of best fit superimposed.

```{r}
#| eval: true
#| fig-cap: Jittered scatterplot of measles susceptibility by year
#| fig-align: center
#| label: fig-prop-year-lm
ggplot(measles, aes(x=Year, y=prop)) +
  geom_jitter() +
  labs(x= "Year", y="Proportion of measle susceptibility", title="Measles susceptibility by year") +
  geom_smooth(method="lm", se=FALSE)

```
