context("hisco_to_ses data.frame")

test_that("df hisclass", {
  d <- read.csv(system.file("extdata/test.csv", package = "hisco"))
  colnames(d)[1] <- "hisco"

  x <- hisco_to_ses(d)
  expect_equal(x$exp_hisclass, x$hisclass)
  expect_equal(d$exp_hisclass, x$hisclass)
  expect_true(ncol(x) == (ncol(d) + 1))
  expect_equal(colnames(x), c(colnames(d), "hisclass"))
  
  x <- hisco_to_ses(d, label = TRUE)
})

test_that("df hisclass with name", {
  d <- read.csv(system.file("extdata/test.csv", package = "hisco"))

  x <- hisco_to_ses(d, name = "hisco_codes")
  expect_equal(x$exp_hisclass, x$hisclass)
  expect_equal(d$exp_hisclass, x$hisclass)
  expect_true(ncol(x) == (ncol(d) + 1))
  expect_equal(colnames(x), c(colnames(d), "hisclass"))
  
  x <- hisco_to_ses(d, label = TRUE, name = "hisco_codes")
})

