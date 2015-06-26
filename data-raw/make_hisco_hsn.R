# make_hisco_hsn.R

library(assertthat)
library(dplyr)

file_name <- "HSN_HISCO_release_2013_01.csv"

if (!file.exists(file.path("data-raw", file_name))){
  url <- "http://www.iisg.nl/hsn/data/zip/release_hsn_hisco_2013_01_csv.zip"
  temp_dir <- tempdir()
  temp_file <- tempfile()
  download.file(url, temp_file)
  unzip(temp_file, file_name, exdir = "data-raw")  
}

hisco_hsn <- read.csv(file.path("data-raw", file_name), 
  header = FALSE, sep = ";", encoding = "latin1", stringsAsFactors = FALSE)

colnames(hisco_hsn) <- c("id", "original", "standard", "hisco", "status", 
  "relation", "product", "hisclass", "hisclass_5", "hiscam_u1", "hiscam_nl", 
  "socpo", "release")
hisco_hsn$original <- iconv(hisco_hsn$original, "latin1", "utf8")
hisco_hsn$standard <- iconv(hisco_hsn$standard, "latin1", "utf8")

code_na <- function(a){
  ifelse(a == -9, NA, a)
}

clean_cam <- function(a){
  x <- stringr::str_replace(a, ",", ".")
  ifelse(x == "", NA, x)
}

hisco_hsn <- hisco_hsn %>% select(hisco:release) %>%
  mutate(
    status = code_na(status),
    relation = code_na(relation),
    product = code_na(product),
    hisclass = code_na(hisclass),
    hisclass_5 = code_na(hisclass_5),
    hiscam_u1 = clean_cam(hiscam_u1),
    hiscam_nl = clean_cam(hiscam_nl),
    socpo = ifelse(socpo == 999, NA, socpo)
  ) %>% distinct() %>%
  group_by(hisco, status, relation, product) %>%
  arrange(hisclass) %>%
  filter(row_number() == 1) %>%
  ungroup()

res <- hisco_hsn %>% group_by(hisco, status, relation, product) %>% 
  tally() %>% 
  filter(n > 1)

assert_that(nrow(res) == 0)

hisclass <- read.csv("data-raw/hisclass.csv")
colnames(hisclass) <- tolower(colnames(hisclass))

hisco_hsn2 <- hisclass %>% select(hisclass, hisclass_label) %>% 
  left_join(hisco_hsn, ., by = "hisclass")

assert_that(nrow(hisco_hsn) == nrow(hisco_hsn2))

hisco_hsn <- hisco_hsn2

hisclass_5 <- read.csv("data-raw/hisclass_5.csv")
colnames(hisclass_5) <- tolower(colnames(hisclass_5))


hisco_hsn2 <- hisclass_5 %>% select(hisclass_5, hisclass_5_label) %>% 
  left_join(hisco_hsn, ., by = "hisclass_5")

assert_that(nrow(hisco_hsn) == nrow(hisco_hsn2))

hisco_hsn <- hisco_hsn2

socpo <- read.csv("data-raw/socpo.csv", encoding = "utf8")
colnames(socpo) <- tolower(colnames(socpo))
levels(socpo$socpo_description) <- iconv(levels(socpo$socpo_description), "utf8", "utf8")

hisco_hsn2 <- socpo %>% select(socpo, socpo_label) %>% 
  left_join(hisco_hsn, ., by = "socpo")

assert_that(nrow(hisco_hsn) == nrow(hisco_hsn2))

hisco_hsn <- hisco_hsn2

save(hisco_hsn, file = "data/hisco_hsn.rda", compress = "xz")


