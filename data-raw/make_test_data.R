# make_test_data.R
d <- data.frame(
  hisco_codes = c(51050, 22670, 22675, 22680, 22680, 22690, 30000, 31000, 31020, 31030, 31040, 45220, 45220, 51050),
  a = 1
)

d <- hisco %>% 
  filter(is.na(product), is.na(status), is.na(relation)) %>%
  left_join(d, ., by = c("hisco_codes" = "hisco"))  %>% 
  select(-a, -status, -relation, -product, -en_hisco_text)

colnames(d) <- c(colnames(d)[1], paste0("exp_", colnames(d)[2:8]))
write.csv(d, file = "inst/extdata/test.csv", row.names = FALSE)