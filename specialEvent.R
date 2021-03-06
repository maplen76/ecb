# to covert table as long format and split the event date scope day by day

library(dplyr)
library(xlsx)
library(reshape2)

 a <- read.xlsx(file = "D:/Rtest/test.xlsx", header = T, stringsAsFactors = F, sheetIndex = 1) %>% tbl_df()

d <- data.frame() %>% tbl_df()

for (i in 1:nrow(a)) {
    w <- a[i,]
    dt <- w$sdate
    j <- 8
    w[,7] <- dt
    
    while (dt < w$edate) {
        dt <- dt + 1
        w[,j] <- dt
        j = j + 1
    }
    
    b <- melt(w,id.vars = c("sdate", "edate", "eventId", "appId", "itemId", "itemName")) %>%
        select(sdate:itemName, date = value)
    
    d <- rbind.data.frame(b, d)
    
    print(d)
}

write.xlsx(x = as.data.frame(d), file = "dim_specialMap_daily.xlsx", row.names = F, showNA = F)
 
