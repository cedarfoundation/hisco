library(assertthat)
library(stringr)
library(dplyr)

hisco <- read.csv("data-raw/hisco-ses.csv.gz", stringsAsFactors = FALSE)
colnames(hisco) <- tolower(colnames(hisco))

hisco <- hisco %>% 
  mutate(en_hisco_text = str_replace_all(en_hisco_text, "â€™", "'"))

res <- hisco %>% filter(is.na(status), is.na(relation), is.na(product)) %>% 
  count(hisco) %>% 
  filter(n > 1)

assert_that(nrow(res) == 0)

hisclass <- read.csv("data-raw/hisclass.csv")
colnames(hisclass) <- tolower(colnames(hisclass))

save(hisclass, file = "data/hisclass.rda")

hisco2 <- hisclass %>% select(hisclass, hisclass_label) %>% 
  left_join(hisco, ., by = "hisclass")

assert_that(nrow(hisco) == nrow(hisco2))

hisco <- hisco2

hisclass_5 <- read.csv("data-raw/hisclass_5.csv")
colnames(hisclass_5) <- tolower(colnames(hisclass_5))

save(hisclass_5, file = "data/hisclass_5.rda")

hisco2 <- hisclass_5 %>% select(hisclass_5, hisclass_5_label) %>% 
  left_join(hisco, ., by = "hisclass_5")

assert_that(nrow(hisco) == nrow(hisco2))

hisco <- hisco2

socpo <- read.csv("data-raw/socpo.csv", encoding = "utf8")
colnames(socpo) <- tolower(colnames(socpo))
levels(socpo$socpo_description) <- iconv(levels(socpo$socpo_description), "utf8", "utf8")

save(socpo, file = "data/socpo.rda")

hisco2 <- socpo %>% select(socpo, socpo_label) %>% 
  left_join(hisco, ., by = "socpo")

assert_that(nrow(hisco) == nrow(hisco2))

hisco <- hisco2

save(hisco, file = "data/hisco.rda", compress = "xz")


