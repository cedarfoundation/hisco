library(assertthat)
library(dplyr)

url <- "http://www.iisg.nl/hsn/data/zip/release_hsn_hisco_2013_01_csv.zip"
file_name <- "HSN_HISCO_release_2013_01.csv"
temp_dir <- tempdir()
temp_file <- tempfile()
download.file(url, temp_file)
unzip(temp_file, file_name, exdir = temp_dir)

hisco <- read.csv(file.path(temp_dir, file_name), 
  header = FALSE, sep = ";", encoding = "latin1", stringsAsFactors = FALSE)
colnames(hisco) <- c("id", "original", "standard", "hisco", "status", 
  "relation", "product", "hisclass", "hisclass_5", "hiscam_u1", "hiscam_nl", 
  "socpo", "release")
hisco$original <- iconv(hisco$original, "latin1", "utf8")
hisco$standard <- iconv(hisco$standard, "latin1", "utf8")

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

save(hisco, file = "data/hisco.rda")

hisclass_5 <- read.csv("data-raw/hisclass_5.csv")
colnames(hisclass_5) <- tolower(colnames(hisclass_5))

save(hisclass_5, file = "data/hisclass_5.rda")

hisco2 <- hisclass_5 %>% select(hisclass_5, hisclass_5_label) %>% 
  left_join(hisco, ., by = "hisclass_5")

assert_that(nrow(hisco) == nrow(hisco2))

hisco <- hisco2

save(hisco, file = "data/hisco.rda")


socpo <- read.csv("data-raw/socpo.csv", encoding = "utf8")
colnames(socpo) <- tolower(colnames(socpo))
levels(socpo$socpo_description) <- iconv(levels(socpo$socpo_description), "utf8", "utf8")

save(socpo, file = "data/socpo.rda")

hisco2 <- socpo %>% select(socpo, socpo_label) %>% 
  left_join(hisco, ., by = "socpo")

assert_that(nrow(hisco) == nrow(hisco2))

hisco <- hisco2

save(hisco, file = "data/hisco.rda", compress = "xz")


