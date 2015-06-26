context("hisco_to_ses")

test_that("hisclass", {
  hisco_codes <- c(51050, 22670, 22675, 22680, 22680, 22690, 30000, 31000, 31020, 31030, 31040, 45220, 45220, 51050)
  expected <- c(4,6,6,6,6,6,5,5,4,2,4,11,11,4)
  expected_l <- c(
    "Lower professionals, and clerical and sales personnel",
    "Foreman",
    "Foreman",
    "Foreman",
    "Foreman",
    "Foreman",
    "Lower clerical and sales personnel",
    "Lower clerical and sales personnel",
    "Lower professionals, and clerical and sales personnel",
    "Higher professionals",
    "Lower professionals, and clerical and sales personnel",
    "Unskilled workers",
    "Unskilled workers",
    "Lower professionals, and clerical and sales personnel"
  )
  x <- hisco_to_ses(hisco_codes)
  expect_equal(x, expected)
  x <- hisco_to_ses(hisco_codes, label = TRUE)
  expect_equal(as.character(x), expected_l)
})

# test hisclass_5
# test socpo
# test hiscam_u1
# test status
# test relation
# test product
# test csv
# test dat.frame