##################################################
############ scrape Data #########################
##################################################
## Scrape Data from Reddit Post 
# Save url
url <- 'https://www.reddit.com/r/AskReddit/comments/7dcpis/drug_users_of_reddit_did_you_ever_take_something/'

# Start chrome server
rD <- rsDriver(verbose = FALSE)
remDr <- rD[["client"]]

# Navigate to the page and retrieve the raw HTML
remDr$navigate(url)

# Load all comments
xpath <- '//div[@id="moreComments-t1_dpxks1w"]/div/p'
elem <- remDr$findElement(using = 'xpath', value = xpath)
elem$clickElement()
# wait until it has been loaded
elem <- remDr$findElement(using = 'xpath', value = xpath)
elem$clickElement()
# wait until it has been loaded
xpath <- '//div[@id="moreComments-t1_dpxwgen"]/div/p'
elem <- remDr$findElement(using = 'xpath', value = xpath)
elem$clickElement()
# wait until it has been loaded
elem <- remDr$findElement(using = 'xpath', value = xpath)
elem$clickElement()
# wait until it has been loaded
xpath <- '//div[@id="moreComments-t1_dpyckqp"]/div/p'
elem <- remDr$findElement(using = 'xpath', value = xpath)
elem$clickElement()
# wait until it has been loaded
elem <- remDr$findElement(using = 'xpath', value = xpath)
elem$clickElement()
# wait until it has been loaded
elem <- remDr$findElement(using = 'xpath', value = xpath)
elem$clickElement()
# wait until it has been loaded
xpath <- '//div[@id="moreComments-t1_dpxhb28"]/div/p'
elem <- remDr$findElement(using = 'xpath', value = xpath)
elem$clickElement()

elem <- remDr$findElement(using="css selector", value="html")
elemtxt <- elem$getElementAttribute("outerHTML")[[1]]

# Parse the HTML into an XML object
doc <- htmlParse(elemtxt)

# Stop server
remDr$close()
rD[["server"]]$stop()

tmp <- getNodeSet(doc, "//p")
temp <- sapply(tmp, xmlValue)
temp <- temp[!str_detect(temp, 'more replies')]
comment <- temp[str_length(temp)>80]

# Transform data to dataframe and write to csv. Table will be imported to SQL by importing table as csv
data <- data.frame(comment)
write.csv(data, 'comments.csv', row.names = F)
