### 기본 rvest 배우기 ###

library(rvest)
library(httr)
library(stringr)

# html 불러오기
url = "https://news.naver.com/main/main.nhn?mode=LSD&mid=shm&sid1=105#&date=%2000:00:00&page=2"

hdoc = read_html(url)


# 필요한 node 찾기 불러오기
css = ".title"
tnodes = html_nodes(hdoc,css = css)

# text 추출
t_text = html_text(tnodes)
t_text

### 쇼핑몰 정보 ###
library(stringr)

site_URL = "https://shopping.naver.com/"

mall_name = character()
mall_img = character()
mall_href = character()

for (i in 1:5) {
  node = stringr::str_c("#mallListPage",i)
  
  name = read_html(site_URL) %>% html_nodes(str_c(node," img")) %>% html_attr("alt")
  img = read_html(site_URL) %>% html_nodes(str_c(node," img")) %>% html_attr("src")
  href = read_html(site_URL) %>% html_nodes(str_c(node," li a")) %>% html_attr("href")
  
  mall_name = append(mall_name,name)
  mall_img = append(mall_img,img)
  mall_href = append(mall_href,href)
}

  #해당문구가 들어간 글자위치 찾기
a=str_locate(mall_href,pattern = "\\.kr")[,2]
b=str_locate(mall_href,pattern = "\\.com")[,2]

a[is.na(a)] = 0
b[is.na(b)] = 0

mall_href = str_sub(mall_href,end = a+b)  
mall_list = data.frame(mall_name,mall_href,mall_img)
View(mall_list)

### 검색어 key word ###

Naver_Real_Time_Search <- (html_nodes(read_html("http://www.naver.com"), ".ah_k") %>% html_text())[1:20]
Naver_Real_Time_Search_Area_Time <- (html_nodes(read_html("http://www.naver.com"), ".ah_time") %>% html_text())

Naver_News_Topic <- (html_nodes(read_html("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=a"), ".keyword span") %>% html_text())[c(1:10)]
Naver_News_Topic_Area_Time <- (html_nodes(read_html("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=a"), ".realtime_srch_area time") %>% html_text())[1]


### 쇼핑검색어 key word ###
read_html(x = "https://datalab.naver.com/") %>% html_nodes(".list_area .title")


best100_URL = "https://search.shopping.naver.com/best100v2/main.nhn"
best100_item = read_html(x = best100_URL) %>% html_nodes("._popular_srch_lst_li") %>% html_text()
best100_time = read_html(x = best100_URL) %>% html_nodes(".h_real em") %>% html_text()

str_split(best100_time, pattern = "현재")
best100_time = gsub("\\.","\\-",str_sub(best100_time,end = 17)[1])
best100_time = gsub("\\-+\\s","\\ ",best100_time)

### 쇼핑검색어 세부 Item ###

best100_Detail_URL = "https://search.shopping.naver.com/search/all.nhn?frm=NVBT100&query="

i=1
str_c(best100_Detail_URL,URLencode(best100_item[i]))

url1 = read_html(str_c(best100_Detail_URL,URLencode(best100_item[i])))


//*[@id="section_popular_brand"]/ul[2]/li[1]/span[1]/a

for (i in 1:5) {
  read_html(str_c(best100_Detail_URL,URLencode(best100_item[i]))) %>% html_nodes("#_search_keyword_list_keyword a") 
}

read_html("https://search.shopping.naver.com/search/all.nhn?frm=NVBT100&query=%EC%97%AC%EC%84%B1%ED%8C%A8%EB%94%A9") %>% html_nodes(xpath = "//*[@id="section_popular_brand"]/ul[2]/li[1]/span[1]/a") 

read_html("https://search.shopping.naver.com/search/all.nhn?frm=NVBT100&query=%EC%97%AC%EC%84%B1%ED%8C%A8%EB%94%A9") %>% html_nodes(xpath = //*[@id="_search_list"]/div[1]/ul/li[8]/div[2]/span[1]/em/span[2])

a = read_html("https://search.shopping.naver.com/search/all.nhn?frm=NVBT100&query=%EC%97%AC%EC%84%B1%ED%8C%A8%EB%94%A9")

a %>% html_nodes(xpath = //*[@id="_search_keyword_list_keyword"]/li[1]/span[1]/a) 




best100_Detail_ITEM
best100_item[1]

encoding(best100_item[1],from = 'utf-8')

URLencode(best100_item[1])

https://search.shopping.naver.com/search/all.nhn?frm=NVBT100&query=%EC%97%AC%EC%84%B1%ED%8C%A8%EB%94%A9
read_html("https://search.shopping.naver.com/search/all.nhn?frm=NVBT100&query=%EC%97%AC%EC%84%B1%ED%8C%A8%EB%94%A9")



### API ###
# id : OPGJVCpUndtfPyw_E9lV
# pw : pGZFExtmFV


api_url = "https://openapi.naver.com/v1/datalab/shopping/categories"

r = POST(api_url)

status_code(r)
headers(r)
str(content(r))

query = URLencode(iconv("안드로이드", to="UTF-8"))
query
library(stringr)
query = str_c("?query=", query)
query

### ###
require(rvest)
aa=POST(url = api_url,
        query = api_list,
        add_headers("X-Naver-Client-Id" = client_id, "X-Naver-Client-Secret" = client_secret))


api_list = list(
  startDate = "20191220",
  endDate = "20191222",
  timeUnit = "date",
  cateogry = "50001234"
)
### GET 으로 API 호출 ###

require(httr)
require(stringr)
install.packages("XML")
require(XML)

api_url = "https://openapi.naver.com/v1/search/webkr.xml"

query = URLencode(iconv("안드로이드", to="UTF-8"))
query = str_c("?query=", query)

client_id     = "OPGJVCpUndtfPyw_E9lV"
client_secret = "pGZFExtmFV"

result = GET(str_c(api_url, query), 
             add_headers("X-Naver-Client-Id" = client_id, "X-Naver-Client-Secret" = client_secret))

xml_ = xmlParse(result)

xpathSApply(xml_, "/rss/channel/item/title", xmlValue)
xpathSApply(xml_, "/rss/channel/item/link", xmlValue)
xpathSApply(xml_, "/rss/channel/item/description", xmlValue)

# 검색 결과를 50건 출력 (최대 100건)

display_ = "&display=50"

result = GET(str_c(api_url, query, display_), 
             add_headers("X-Naver-Client-Id" = client_id, "X-Naver-Client-Secret" = client_secret))
xml_ = xmlParse(result)
xpathSApply(xml_, "/rss/channel/item/title", xmlValue)


# 101번째 검색 결과부터 출력 (최대 1000건)

start_ = "&start=50"

result = GET(str_c(api_url, query, start_), 
             add_headers("X-Naver-Client-Id" = client_id, "X-Naver-Client-Secret" = client_secret))
xml_ = xmlParse(result)
xpathSApply(xml_, "/rss/channel/item/title", xmlValue)

# 유사도가 아닌 날짜순으로 검색된 결과 출력

sort_ = "&sort=date"

result = GET(str_c(api_url, query, sort_), 
             add_headers("X-Naver-Client-Id" = client_id, "X-Naver-Client-Secret" = client_secret))
xml_ = xmlParse(result)
xpathSApply(xml_, "/rss/channel/item/title", xmlValue)

# 위의 결과 전부 적용

result = GET(str_c(api_url, query, display_, start_, sort_), 
             add_headers("X-Naver-Client-Id" = client_id, "X-Naver-Client-Secret" = client_secret))
xml_ = xmlParse(result)
xpathSApply(xml_, "/rss/channel/item/title", xmlValue)
