
# Wikipedia Web Crawl

> In this lesson we will apply the skills learned previously by writing a web crawler that explores Wikipedia.

## Case Introduction

**Automating the Wikipedia Crawl**

Go to a Wikipedia page you find interesting, or just a random one and click the first link. Then on that page click the first link in the main body of the article text and just keep going. You could try it multiple times for different pages and see whether you get different behaviour. We're going to work on automating this process, ending up with a program that will go through Wikipedia for us.

## Breaking the Problem into Steps

### The Manual Process

1. Open an article
2. Find the first link in the article
3. Follow the link
4. Record the link in the article_chain data structure.
5. Repeat this process until we reach the Philosophy article, or get stuck in an article cycle

## Laying the Groundwork

* **The Sequence of Steps**
    1. Find target tags
    2. Get html
    3. Parse html


```python
# Find target tag
start_url = 'https://en.wikipedia.org/wiki/Film'
target_url = "https://en.wikipedia.org/wiki/Philosophy"

first_xpath = '/html/body/div[3]/div[3]/div[4]/div/p[2]/a[1]'
first_element = '<a href="/wiki/Visual_art" class="mw-redirect" title="Visual art">visual art</a>'
first_link = 'https://en.wikipedia.org/wiki/Visual_art'
```


```python
# Get HTML
# Tool：requests(text)
import requests
proxies = {"http": "http://127.0.0.1:1087",
           "https": "http://127.0.0.1:1087",
          }
user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36'
headers = {'User-Agent':user_agent}
response = requests.get(start_url, proxies=proxies, headers=headers)
html = response.text
```


```python
# Parse HTML
# Tool：BeautifulSoup
from bs4 import BeautifulSoup
soup = BeautifulSoup(html, "html5lib")

content_div = soup.find(id="mw-content-text").find(class_="mw-parser-output")
for element in content_div.find_all("p", recursive=False):
    if element.find("a", recursive=False):
        first_relative_link = element.find('a', recursive=False).get('href')


# # as we get links in Wikipedia articles are relative urls rather than absolute urls
import urllib
urllib.parse.urljoin('https://en.wikipedia.org/', first_relative_link)
```




    'https://en.wikipedia.org/wiki/Limited_animation'



## Designing the Program

**Design**

* Looping
* Data structures
* Steps to perform
* Specific extra(slowing dow)

**loop**

Steps of loop:
1. Find the first link in the current article's HTML
2. Download the HTML for the current article
3. Add the first link from the current article to article_chain
4. Pause for a couple seconds so we don't flood Wikipedia with requests.

The program should end the while loop when:
1. we reach Philosophy,
2. we reach a page we've already visited, hence find ourselves in a cycle of articles (like the case of Chair,
3. we go on for too long (we think that 25 steps is plenty, but you can adjust this if you like), or 
4. we find a page that has no links on it - we simply can't keep going in this case.

**Pseudo Code**

```
page = a random starting page
article_chain = []
while title of page isn't 'Philosophy' and we have not discovered a cycle:
    append page to article_chain
    download the page content
    find the first link in the content
    page = that link
    pause for a second
```

## Implementing the Program

**Write code** 

* Code to control loop
* Steps inside loop
* Planned find_first_link
* Wrote find_first_link
* Test


```python
# Framework of program
import time
def web_crawl(start_url, target_url):
    article_chain = [start_url]
    while continue_crawl(article_chain, target_url):
        print(article_chain[-1])
        first_link = find_first_link(article_chain[-1])
        if first_link:
            article_chain.append(first_link)
            time.sleep(2)
        else:
            print("We've arrived at an article with no links, aborting search!")
            break 
```


```python
# Branch of program
import urllib
def continue_crawl(search_history, target_url, max_steps=25):
    if search_history[-1] == target_url:
        print("We've found the target article!")
        return False
    elif len(search_history) > max_steps:
        print("The search has gone on suspiciously long, aborting search!")
        return False
    elif search_history[-1] in search_history[:-1]:
        print("We've arrived at an article we've already seen, aborting search!")
        return False
    else:
        return True

def find_first_link(url):
    response = requests.get(url, proxies=proxies, headers=headers)
    html = response.text
    soup = BeautifulSoup(html, "html5lib")
    
    content_div = soup.find(id="mw-content-text").find(class_="mw-parser-output")
    
    article_link = None

    for element in content_div.find_all("p", recursive=False):
        if element.find("a", recursive=False):
            article_link = element.find("a", recursive=False).get('href')
            break

    if not article_link:
        return
    first_link = urllib.parse.urljoin('https://en.wikipedia.org/', article_link)

    return first_link
```


```python
# test
start_url = 'https://en.wikipedia.org/wiki/Film'
target_url = "https://en.wikipedia.org/wiki/Philosophy"

web_crawl(start_url, target_url)
```

    https://en.wikipedia.org/wiki/Film
    https://en.wikipedia.org/wiki/Visual_art
    https://en.wikipedia.org/wiki/Art#Forms,_genres,_media,_and_styles
    https://en.wikipedia.org/wiki/Human_behavior
    https://en.wikipedia.org/wiki/Human
    https://en.wikipedia.org/wiki/Extant_taxon
    https://en.wikipedia.org/wiki/Biology
    https://en.wikipedia.org/wiki/Natural_science
    https://en.wikipedia.org/wiki/Branches_of_science
    https://en.wikipedia.org/wiki/Science
    https://en.wikipedia.org/wiki/Latin
    https://en.wikipedia.org/wiki/Classical_language
    https://en.wikipedia.org/wiki/Language
    https://en.wikipedia.org/wiki/Grammar
    https://en.wikipedia.org/wiki/Linguistics
    We've arrived at an article we've already seen, aborting search!

