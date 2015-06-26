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
test_that("hiscam_u1", {
  hisco_codes <- c(51050, 22670, 22675, 22680, 22680, 22690, 30000, 31000, 31020, 31030, 31040, 45220, 45220, 51050)
  expected <- c(58.02,66.93,78.55,73.41,73.41,57.72,72.87,88.41,90.51,
    69.38,68.18,51.90,51.90,58.02)
  x <- hisco_to_ses(hisco_codes, "hiscam_u1")
  expect_equal(x, expected)
  expect_error(hisco_to_ses(hisco_codes, "hiscam_u1", label = TRUE))
})
# test status
# test relation
# test product
# test csv
# test dat.frame