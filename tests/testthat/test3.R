context("reference")

test_that("hisco_hsn", {
  d <- read.csv(system.file("extdata/test.csv", package = "hisco"))
  x <- hisco_to_ses(d$hisco_codes, reference = "hisco_hsn")
  expect_equal(length(x), nrow(d))
})