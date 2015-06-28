# reference.R

#' Write hisco reference file to csv
#'
#' To manually update the hisco classifications you can
#'   start with the package reference file as a template. 
#'   This function writes the reference file as csv file to 
#'   a specified path.
#'
#' @param path character sting with name of file
#' @author Johan Junkka \email{johan.junkka@@gmail.com}
#' @export
#' @examples
#' write_reference("my_hisco.csv")
#' unlink("my_hisco.csv")
#' 

write_reference <- function(path) { 
  e <- environment()
  data(hisco, package = "hisco", envir = e)
  write.csv(hisco, file = path, row.names = FALSE)
  message(sprintf('Reference file saved to "%s"', path))
}

validate_ref <- function(x) {
  if (x == "hisco_hsn")
    return(hisco_hsn)
  # check if file exists
  assert_that(file.exists(x), msg = sprintf('Cannot open %s', x))

  e <- environment()
  data(hisco, package = "hisco", envir = e)

  raw <- read.csv(x)
  colnames(raw) <- tolower(colnames(raw))

  assert_that(all(colnames(hisco)[1:9] %in% colnames(raw)), 
    msg = sprintf("Cannot find column(s): %s. \n\tColumn names do not match reference table \n\tsee 'vignette(\"manual_reference\")'",
        paste(colnames(hisco)[1:9][!colnames(hisco)[1:9] %in% colnames(raw)], collapse = ", ")
        ))

  assert_that(all(unique(raw$hisco) %in% unique(hisco$hisco)))

  res <- raw %>% filter(is.na(status), is.na(relation), is.na(product)) %>% 
    count(hisco) %>% 
    filter(n > 1)

  assert_that(all(unique(res$hisco) %in% unique(hisco$hisco)))
  assert_that(nrow(res) == 0)
  d <- raw[ ,colnames(hisco)[1:9]] 

  data(hisclass, package = "hisco", envir = e)
  
  d2 <- hisclass %>% select(hisclass, hisclass_label) %>% 
    left_join(d, ., by = "hisclass")

  assert_that(nrow(d) == nrow(d2))

  d <- d2

  data(hisclass_5, package = "hisco", envir = e)
  
  d2 <- hisclass_5 %>% select(hisclass_5, hisclass_5_label) %>% 
    left_join(d, ., by = "hisclass_5")

  assert_that(nrow(d) == nrow(d2))

  d <- d2


  data(socpo, package = "hisco", envir = e)
  
  d2 <- socpo %>% select(socpo, socpo_label) %>% 
    left_join(d, ., by = "socpo")

  assert_that(nrow(d) == nrow(d2))

  d <- d2

  return(d)
}