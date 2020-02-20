
# Exploring Weather Trends

In this project, I will analyze local and global temperature data and compare the temperature trends where you live (ShenZhen, China) to overall global temperature trends.

My goal is to create a visualization and prepare a write up describing the similarities and differences between global temperature trends and temperature trends in the closest big city to where you live.
there are five steps below:

- Find the Nearest City
- Find the Period of Time
- Merge Two Tables
- Calculate Years Simple Moving Average
- Create a Line Chart
- Make Observations about Similarities and Differences

There are three tables in the database:

- city_list - This contains a list of cities and countries in the database. Look through them in order to find the city nearest to you
- city_data - This contains the average temperatures for each city by year (ºC)
- global_data - This contains the average global temperatures by year (ºC)


```python
import pandas as pd
import matplotlib.pyplot as plt
%matplotlib inline

import os

PROJECT_ROOT_DIR = ".."
IMAGES_PATH = "../images"

def save_fig(fig_id, tight_layout=True, fig_extension="png", resolution=300):
    path = os.path.join(IMAGES_PATH, fig_id+"."+fig_extension)
    print("Saving figure", fig_id)
    if tight_layout:
        plt.tight_layout()
    plt.savefig(path, format=fig_extension, dpi=resolution)
```

## 1. Nearest City


```python
ls ../data/
```

    [31mcity_data.csv[m[m*   [31mcity_list.csv[m[m*   [31mglobal_data.csv[m[m*



```python
df_city = pd.read_csv("../data/city_list.csv")
```


```python
df_city.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>city</th>
      <th>country</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Abidjan</td>
      <td>Côte D'Ivoire</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Abu Dhabi</td>
      <td>United Arab Emirates</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Abuja</td>
      <td>Nigeria</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Accra</td>
      <td>Ghana</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Adana</td>
      <td>Turkey</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_city.country.value_counts()
```




    United States    52
    China            34
    India            22
    Brazil           11
    Pakistan          9
                     ..
    France            1
    Latvia            1
    Mongolia          1
    Ghana             1
    Angola            1
    Name: country, Length: 137, dtype: int64




```python
df_cn = df_city.query("country=='China'")
```


```python
df_cn.city.value_counts()
```




    Chengdu      1
    Foshan       1
    Hefei        1
    Hangzhou     1
    Lanzhou      1
    Datong       1
    Jinan        1
    Luoyang      1
    Nanchang     1
    Changzhou    1
    Jilin        1
    Suzhou       1
    Xuzhou       1
    Kunming      1
    Shenyang     1
    Guangzhou    1
    Taiyuan      1
    Xian         1
    Anshan       1
    Dalian       1
    Wuhan        1
    Wuxi         1
    Qiqihar      1
    Shanghai     1
    Nanjing      1
    Tangshan     1
    Fuzhou       1
    Harbin       1
    Tianjin      1
    Nanning      1
    Changchun    1
    Qingdao      1
    Guiyang      1
    Handan       1
    Name: city, dtype: int64



**Solution**

By looking through the upper table, I found that `Guangzhou` is nearest from `ShenZhen`.

## 2. Period of Time


```python
df_city = pd.read_csv("../data/city_data.csv")
```


```python
df_city.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 71311 entries, 0 to 71310
    Data columns (total 4 columns):
    year        71311 non-null int64
    city        71311 non-null object
    country     71311 non-null object
    avg_temp    68764 non-null float64
    dtypes: float64(1), int64(1), object(2)
    memory usage: 2.2+ MB



```python
df_gz = df_city.query("city=='Guangzhou'")
```


```python
df_gz.info()
```

    <class 'pandas.core.frame.DataFrame'>
    Int64Index: 174 entries, 22729 to 22902
    Data columns (total 4 columns):
    year        174 non-null int64
    city        174 non-null object
    country     174 non-null object
    avg_temp    174 non-null float64
    dtypes: float64(1), int64(1), object(2)
    memory usage: 6.8+ KB



```python
df_gz.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>year</th>
      <th>avg_temp</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>174.000000</td>
      <td>174.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>1926.500000</td>
      <td>21.611207</td>
    </tr>
    <tr>
      <th>std</th>
      <td>50.373604</td>
      <td>0.485201</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1840.000000</td>
      <td>20.400000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1883.250000</td>
      <td>21.272500</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1926.500000</td>
      <td>21.590000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>1969.750000</td>
      <td>21.980000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>2013.000000</td>
      <td>22.930000</td>
    </tr>
  </tbody>
</table>
</div>




```python
df_global = pd.read_csv("../data/global_data.csv")
```


```python
df_global.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 266 entries, 0 to 265
    Data columns (total 2 columns):
    year        266 non-null int64
    avg_temp    266 non-null float64
    dtypes: float64(1), int64(1)
    memory usage: 4.3 KB



```python
df_global.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>year</th>
      <th>avg_temp</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>266.000000</td>
      <td>266.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>1882.500000</td>
      <td>8.369474</td>
    </tr>
    <tr>
      <th>std</th>
      <td>76.931788</td>
      <td>0.584747</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1750.000000</td>
      <td>5.780000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1816.250000</td>
      <td>8.082500</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1882.500000</td>
      <td>8.375000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>1948.750000</td>
      <td>8.707500</td>
    </tr>
    <tr>
      <th>max</th>
      <td>2015.000000</td>
      <td>9.830000</td>
    </tr>
  </tbody>
</table>
</div>



**Conclusion**

As we can analysis `Guangzhou` and `global` database, we can get the time interval of year between `1840` to `2013`.


```python
# filter assign year
df_global = df_global.query("year >= 1840 & year <=2013")
```


```python
df_global.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>year</th>
      <th>avg_temp</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>174.000000</td>
      <td>174.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>1926.500000</td>
      <td>8.524713</td>
    </tr>
    <tr>
      <th>std</th>
      <td>50.373604</td>
      <td>0.469801</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1840.000000</td>
      <td>7.560000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1883.250000</td>
      <td>8.172500</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1926.500000</td>
      <td>8.520000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>1969.750000</td>
      <td>8.760000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>2013.000000</td>
      <td>9.730000</td>
    </tr>
  </tbody>
</table>
</div>



## 3. Merge Table


```python
# filter "year" and "avg_temp" columns
df1 = df_gz.loc[:, ["year", "avg_temp"]]
```


```python
df1.rename(columns={"avg_temp":"avg_temp_gz"});
```


```python
df2 = df_global.loc[:, ["year", "avg_temp"]]
```


```python
df2.rename(columns={"avg_temp":"avg_temp_global"});
```


```python
# merge two dataframe with the same columns
df = df1.merge(df2, left_on="year", right_on="year", suffixes=("_gz", "_global"))
```


```python
df['avg_temp_diff'] = df['avg_temp_gz'] - df['avg_temp_global']
```


```python
df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    Int64Index: 174 entries, 0 to 173
    Data columns (total 4 columns):
    year               174 non-null int64
    avg_temp_gz        174 non-null float64
    avg_temp_global    174 non-null float64
    avg_temp_diff      174 non-null float64
    dtypes: float64(3), int64(1)
    memory usage: 6.8 KB



```python
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>year</th>
      <th>avg_temp_gz</th>
      <th>avg_temp_global</th>
      <th>avg_temp_diff</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1840</td>
      <td>20.98</td>
      <td>7.80</td>
      <td>13.18</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1841</td>
      <td>21.02</td>
      <td>7.69</td>
      <td>13.33</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1842</td>
      <td>21.16</td>
      <td>8.02</td>
      <td>13.14</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1843</td>
      <td>21.25</td>
      <td>8.17</td>
      <td>13.08</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1844</td>
      <td>20.86</td>
      <td>7.65</td>
      <td>13.21</td>
    </tr>
  </tbody>
</table>
</div>



## 4. Simple Moving Average


```python
df['SMA_10_gz'] = df.iloc[:, 1].rolling(window=10).mean().round(2)
df['SMA_10_global'] = df.iloc[:, 2].rolling(window=10).mean().round(2)
df['SMA_10_diff'] = df['SMA_10_gz'] - df['SMA_10_global']
```


```python
df.head(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>year</th>
      <th>avg_temp_gz</th>
      <th>avg_temp_global</th>
      <th>avg_temp_diff</th>
      <th>SMA_10_gz</th>
      <th>SMA_10_global</th>
      <th>SMA_10_diff</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1840</td>
      <td>20.98</td>
      <td>7.80</td>
      <td>13.18</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1841</td>
      <td>21.02</td>
      <td>7.69</td>
      <td>13.33</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1842</td>
      <td>21.16</td>
      <td>8.02</td>
      <td>13.14</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1843</td>
      <td>21.25</td>
      <td>8.17</td>
      <td>13.08</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1844</td>
      <td>20.86</td>
      <td>7.65</td>
      <td>13.21</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1845</td>
      <td>20.84</td>
      <td>7.85</td>
      <td>12.99</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>6</th>
      <td>1846</td>
      <td>21.46</td>
      <td>8.55</td>
      <td>12.91</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>7</th>
      <td>1847</td>
      <td>21.07</td>
      <td>8.09</td>
      <td>12.98</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>8</th>
      <td>1848</td>
      <td>20.75</td>
      <td>7.98</td>
      <td>12.77</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>9</th>
      <td>1849</td>
      <td>21.03</td>
      <td>7.98</td>
      <td>13.05</td>
      <td>21.04</td>
      <td>7.98</td>
      <td>13.06</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    Int64Index: 174 entries, 0 to 173
    Data columns (total 7 columns):
    year               174 non-null int64
    avg_temp_gz        174 non-null float64
    avg_temp_global    174 non-null float64
    avg_temp_diff      174 non-null float64
    SMA_10_gz          165 non-null float64
    SMA_10_global      165 non-null float64
    SMA_10_diff        165 non-null float64
    dtypes: float64(6), int64(1)
    memory usage: 10.9 KB



```python
df.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>year</th>
      <th>avg_temp_gz</th>
      <th>avg_temp_global</th>
      <th>avg_temp_diff</th>
      <th>SMA_10_gz</th>
      <th>SMA_10_global</th>
      <th>SMA_10_diff</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>174.000000</td>
      <td>174.000000</td>
      <td>174.000000</td>
      <td>174.000000</td>
      <td>165.000000</td>
      <td>165.000000</td>
      <td>165.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>1926.500000</td>
      <td>21.611207</td>
      <td>8.524713</td>
      <td>13.086494</td>
      <td>21.609636</td>
      <td>8.513576</td>
      <td>13.096061</td>
    </tr>
    <tr>
      <th>std</th>
      <td>50.373604</td>
      <td>0.485201</td>
      <td>0.469801</td>
      <td>0.333156</td>
      <td>0.362001</td>
      <td>0.400309</td>
      <td>0.167898</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1840.000000</td>
      <td>20.400000</td>
      <td>7.560000</td>
      <td>12.120000</td>
      <td>20.950000</td>
      <td>7.970000</td>
      <td>12.610000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1883.250000</td>
      <td>21.272500</td>
      <td>8.172500</td>
      <td>12.862500</td>
      <td>21.310000</td>
      <td>8.190000</td>
      <td>13.020000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1926.500000</td>
      <td>21.590000</td>
      <td>8.520000</td>
      <td>13.090000</td>
      <td>21.580000</td>
      <td>8.530000</td>
      <td>13.120000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>1969.750000</td>
      <td>21.980000</td>
      <td>8.760000</td>
      <td>13.310000</td>
      <td>21.920000</td>
      <td>8.690000</td>
      <td>13.210000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>2013.000000</td>
      <td>22.930000</td>
      <td>9.730000</td>
      <td>14.130000</td>
      <td>22.330000</td>
      <td>9.560000</td>
      <td>13.440000</td>
    </tr>
  </tbody>
</table>
</div>



## 5. Line Chart


```python
?plt.subplot
```


```python
x = df['year']

y1 = df['avg_temp_gz']
y2 = df['avg_temp_global']
y3 = df['avg_temp_diff']
y4 = df['SMA_10_gz']
y5 = df['SMA_10_global']
y6 = df['SMA_10_diff']
```


```python
plt.figure(figsize=[15, 10])

ax1 = plt.subplot(212)
ax1.margins(0.05)
ax1.plot(x, y1, label='Years of Guangzhou')
ax1.plot(x, y2, label='Years of Global')
ax1.plot(x, y3, label="Diff", linestyle='--')
ax1.set_title('Guangzhou VS. Global Temperature by Years')
ax1.grid(True)
ax1.set(xlabel='Year', ylabel='Temperature')

ax2 = plt.subplot(221)
ax2.margins(x=0.01, y=0.1)
ax2.plot(x, y1,)
ax2.set_title('Zoomed in Guangzhou')
ax2.grid(True)
ax2.set(xlabel='Year', ylabel='Temperature')

ax3 = plt.subplot(222)
ax3.margins(x=0.01, y=0.1)
ax3.plot(x, y2)
ax3.set_title('Zoomed in Global')
ax3.grid(True)
ax3.set(xlabel='Year', ylabel='Temperature')
plt.show();
```


![png](output_42_0.png)



```python
plt.figure(figsize=[15, 10])

ax4 = plt.subplot(212)
ax4.grid(True)
ax4.margins(0.05)
ax4.plot(x, y4, label='Years of Guangzhou')
ax4.plot(x, y5, label='Years of Global')
ax4.plot(x, y6, label="Diff of Guangzhou and Global", linestyle='--')
ax4.set_title('Guangzhou VS. Global Temperature by SMA 10 Years')
ax4.legend()

ax5 = plt.subplot(221)
ax5.grid(True)
ax5.margins(x=0.01, y=0.1)
ax5.plot(x, y4)
ax5.set_title('Zoomed in Guangzhou')


ax6 = plt.subplot(222)
ax6.grid(True)
ax6.margins(x=0.01, y=0.1)
ax6.plot(x, y5)
ax6.set_title('Zoomed in Global')
save_fig("line_chart_trends")
```

    Saving figure line_chart_trends



![png](output_43_1.png)


## 6. Observations


```python
# calculate the difference temperature between 1840 to 2013 in Guangzhou
(df.query("year==2013").avg_temp_gz.values - df.query("year==1840").avg_temp_gz.values)[0]
```




    1.9499999999999993




```python
# calculate the difference temperature between 1840 to 2013 in global
(df.query("year==2013").avg_temp_global.values - df.query("year==1840").avg_temp_global.values)[0]
```




    1.8099999999999996




```python
# show the average temperature of Guangzhou and global over the last few hundread years
df['avg_temp_gz'].mean().round(2), df['avg_temp_global'].mean().round(2), (df['avg_temp_gz'].mean() - df['avg_temp_global'].mean()).round(2)
```




    (21.61, 8.52, 13.09)




```python
# show the range of average temperature of Guangzhou
df['avg_temp_gz'].max().round(2), df['avg_temp_gz'].min().round(2),
```




    (22.93, 20.4)




```python
# show the range of average temperature of Guangzhou
df['avg_temp_global'].max().round(2), df['avg_temp_global'].min().round(2),
```




    (9.73, 7.56)



**Similarities**

* Guangzhou and global average temperature are both observed to be generally increasing trend in the same upwards pattern over the last few hundred years.

* Guangzhou and global average temperature have similar local maximum or minimum in the same year.

* Both Guangzhou and global have a generally consistent increasing trend over the last few hundred years.

**Differences**

* Guangzhou is hotter on average compared to the global average, and the mean annual temperature over Guangzhou was 21.61 degree Celsius(°C) higher than 13.09 degree Celsius(°C)degree Celsius compared with the global.

* The range average temperature of Guangzhou is between 20 to 23 degree Celsius(°C) while the global average is between 7 to 10 degree Celsius(°C).

* The difference between Guangzhou and Global average is decresing since last 50 years (1963-2013), which means the increase of average temperature in global has generally been faster than Guangzhou.

* Guangzhou average temperature has decreased over recent five years, while the global average temperature show a rising sharply trend.
