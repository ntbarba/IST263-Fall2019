# Install and load packages
install.packages("quantmod"/"PerformanceAnalytics"/"")
library(quantmod)

# Retrieve stock data
getSymbols("TICKER", from="YYYY-MM-DD", to="YYYY-MM-DD")
# Retrieve index data
getSymbols("^GSPC", from="YYYY-MM-DD", to="YYYY-MM-DD")
# Retrieve treasury data
getSymbols("DGS3MO", src="FRED")
# Fix the treasury data for use
DGS3MO/1200 -> risk.free
# Retrieve multiple stock data
getSymbols(c("TICKER", "TICKER", "TICKER"), from="YYYY-MM-DD", to="YYYY-MM-DD")

# View the object data
head(object)
tail(object)

# Compute the daily/monthly return
monthlyReturn(object$object.Adjusted)->object.returns
dailyReturn(object$object.Adjusted)->object.returns

# Combine return data from multiple objects
cbind(object.returns, object.returns, object.returns) -> newobject
# Rename the columns of your new object
c("One", "Two", "Three") -> colnames(newobject)

# Compute wealth index of stock - the object is return values
Return.portfolio(object, wealth.index=TRUE) -> object.wi

# Calculate the means of the return data for a stock
# For a HISTORICAL average, use geometric mean
mean.geometric(object.returns)
# For the EXPECTED return, use mean
mean(object.returns)

# Count the number of rows in a dataset
nrow(object)

# Plot the frequency histogram of monthly returns
chart.Histogram(object.returns)

# Compute the Value at Risk - the value at risk of loss if certain level is reached
VaR(object.returns, p=0.05)

# Compute the Estimated Shortfall if VaR is breached
ES(object.returns, p=0.05)

# Plot time series data
plot(object, legend.loc="top", main="Title")

# Compute excess return for a stock
object.return - risk.free = object.excess.return
# Compute excess return for the market
market.return - risk.free = market.excess.return

# Compute the monthly risk premium of a stock
mean(object.excess.return)

# Plot Y(stock excess return) vs. X(market excess return)
chart.Regression(market.excess.return, object.excess.return, fit=FALSE)
# Use the robust linear model for a line of best fit - it is less affected by unusual observations (outliers)
rlm(object.excess.returns ~ market.excess.returns) -> mymodel
# Display the robust linear model line on the regression
abline(mymodel)
# Display the coefficient and slope(predicted stock beta)
mymodel