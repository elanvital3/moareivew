### POST ###
library(httr)
res = POST(url = "https://openapi.naver.com/v1/datalab/shopping/category/device",
     encode = 'json',
     body = list(startDate = "2019-12-01",
                 endDate = "2019-12-10",
                 timeUnit = "date",
                 category = "50000000"),
     config = add_headers('X-Naver-Client-Id' = Sys.getenv('NAVER_API_ID'),
                          'X-Naver-Client-Secret' = Sys.getenv('NAVER_API_PW'))
     )

json = content(res)

str(json)
json$results

### GET ###

# https://mrkevinna.github.io/Naver-Papago-API%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%9C-NMT-%EB%B2%88%EC%97%AD/

require(jsonlite)
res <- GET(url = 'https://openapi.naver.com/v1/search/blog.json',
           query = list(query = '미세먼지',
                        display = '100',
                        start = '1', 
                        sortt = 'data'), 
           config = add_headers('X-Naver-Client-Id' = Id,
                                'X-Naver-Client-Secret' = Secret
           )
)

print(res)

content(res,as = 'text') %>% fromJSON()
json = res %>% content(as = 'text') %>% fromJSON()
str(json)

(json$items)

### 환경변수에 ID, KEY 넣기
usethis::edit_r_environ()

Sys.getenv('NAVER_API_ID')
Sys.getenv('NAVER_API_PW')


