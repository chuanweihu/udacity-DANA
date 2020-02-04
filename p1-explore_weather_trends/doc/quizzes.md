# Quizzes

## Q1: What tools did you use for each step?

* Python
* Pandas
* Matplotlib

## Q2: How did you calculate the moving average?

Use Pandas dataframe. rolling() function, which provides the feature of rolling window calculations.

**For example**:

* calculate 10 simple moving average
`df['SMA_10_gz'] = df.iloc[:, 1].rolling(window=10).mean().round(2)`

## Q3: What were your key considerations when deciding how to visualize the trends?

I'll take smooth and clearly trend lines for the first consideration.

## Q4: What are observations about the similarities and/or differences in the trends?

**Similarities**

* Guangzhou and global average temperature are both observed to be generally increasing trend in the same upwards pattern over the last few hundred years.
* Guangzhou and global average temperature have similar local maximum or minimum in the same year.
* Both Guangzhou and global have a generally consistent increasing trend over the last few hundred years.

**Differences**

* Guangzhou is hotter on average compared to the global average, and the mean annual temperature over Guangzhou was 21.61 degree Celsius(°C) higher than 13.09 degree Celsius(°C)degree Celsius compared with the global.
* The range average temperature of Guangzhou is between 20 to 23 degree Celsius(°C) while the global average is between 7 to 10 degree Celsius(°C).
* The difference between Guangzhou and Global average is decresing since last 50 years (1963-2013), which means the increase of average temperature in global has generally been faster than Guangzhou.
* Guangzhou average temperature has decreased over recent five years, while the global average temperature show a rising sharply trend.
