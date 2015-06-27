context("hisco_to_ses vector")

test_that("ses default", {
  d <- read.csv(system.file("extdata/test.csv", package = "hisco"))
  x <- hisco_to_ses(d$hisco_codes)
  expect_equal(x, d$exp_hisclass)
  x <- hisco_to_ses(d$hisco_codes, label = TRUE)
  expect_equal(as.character(x), as.character(d$exp_hisclass_label))
})


test_that("ses specified", {
  d <- read.csv(system.file("extdata/test.csv", package = "hisco"))
  sess <- c("hisclass", "hisclass_5", "socpo")
  plyr::l_ply(sess, function(a){
    x <- hisco_to_ses(d$hisco_codes, a)
    expect_equal(x, d[ ,paste0("exp_", a)])
    x <- hisco_to_ses(d$hisco_codes, a, label = TRUE)
    expect_equal(as.character(x), as.character(d[ ,paste0("exp_", a, "_label")]))
  })
})

test_that("hiscam_u1", {
  d <- read.csv(system.file("extdata/test.csv", package = "hisco"))
  x <- hisco_to_ses(d$hisco_codes, "hiscam_u1")
  expect_equal(x, d$exp_hiscam_u1)
  expect_error(hisco_to_ses(d$hisco_codes, "hiscam_u1", label = TRUE))
})