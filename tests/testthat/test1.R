context("hisco_to_ses")

test_that("hisclass", {
  hisco_codes <- c(51050, 22670, 22675, 22680, 22680, 22690, 30000, 31000, 31020, 31030, 31040, 45220, 45220, 51050)
  x <- hisco_to_ses(hisco_codes, out = "full")
  x2 <- hisco_to_ses(hisco_codes)
  expect_equal(x$hisco, hisco_codes)
  expect_equal(x2, x$hisclass)
})

# test hisclass_5
# test socpo
# test hiscam_u1
# test status
# test relation
# test product
# test csv
# test dat.frame