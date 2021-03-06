#' Hisco to SES classification
#'
#' Function to classify historical occupations coded in HICSO 
#'   (Historical International Standard Classification of Occupations) 
#'   to HISCLASS 12, HISCLASS 5, SOCPO or HISCAM social class systems.
#'
#' @param x a vector of HISCO codes, a path to a csv file or data.frame that holds HISCO and
#'   optional STATUS, RELATION and PRODUCT mappigns
#' @param ses ouput SES system
#' @param status name of STATUS variable or vector of STATUS codes
#' @param relation name of RELATION variable or vector of RELATION codes
#' @param product name of PRODUCT variable or vector of PRODUCT codes
#' @param label logical. TRUE will display label for SES such as "Forman". 
#'   FALSE will display the SES as a numeric code.
#' @param name character. Used when input is a data.frame to specify the
#'   name of the column containing hisco codes.
#' @param reference character. Path to a csv file containing a reference table.
#' @param messages Print summary statistics on classification result.
#' @author Johan Junkka \email{johan.junkka@@gmail.com}
#' @export
#' @import dplyr
#' @import assertthat
#' @examples
#' hisco_codes <- c(22670, 22675, 22680, 22690, 30000, 31000, 31020, 
#'                  31030, 31040)
#' hisco_to_ses(hisco_codes)
#' hisco_to_ses(hisco_codes, ses = "socpo", label = TRUE)
#'


hisco_to_ses <- function(x,
    ses = c("hisclass", "hisclass_5", "socpo", "hiscam_u1", "all"),
    status = NULL,
    relation = NULL,
    product = NULL,
    label = FALSE, 
    name = 'hisco',
    reference = NULL,
    messages = FALSE) {
  
  clss <- c("integer", "numeric", "data.frame")
  if (!inherits(x, clss))
    stop(paste("No method for:", paste(class(x), collapse = ", ")))
  format <- class(x)[min(match(clss, class(x)), na.rm = TRUE)]
  out_ses <- match.arg(ses)

  codes <- do.call(
    paste('tohisco', format, sep = '_'),
    list(x = x, status = status, relation = relation, 
      product = product, name = name)
  )

  filtered <- filter_hisco(codes, reference)
  res <- left_join(codes, filtered$hisco, by = filtered$join_by) 
  if (messages) print_message(res)

  # output
  simp_res <- hiscoout_simple(res, label, out_ses)



  result <- do.call(
    paste('hiscoout', format, sep = '_'),
    list(x = x, res = simp_res)
  )
  result
}

hiscoout_simple <- function(res, label, out_ses){
  if (label){
    lbl = paste0(out_ses, "_label")
    res <- res %>% select_("hisco", lbl)
  } else {
    res <- res %>% select_("hisco", out_ses)
  }
  res
}

hiscoout_integer <- function(x, res){
  res[ ,2]
}

hiscoout_numeric <- function(x, res){
  res[ ,2]
}

hiscoout_data.frame <- function(x, res){
  cbind(x, select(res, 2))
}

# Print message

print_message <- function(res){
  
  message("\n\nHISCLASS matches:")
  print(knitr::kable(res %>% count(hisclass_label) %>% mutate( prop = round(n/sum(n),2)),caption=))
  message("\n\nHISCLASS 5 matches:")
  print(knitr::kable(res %>% count(hisclass_5_label) %>% mutate( prop = round(n/sum(n),2))))
  message("\n\nSOCPO matches:")
  print(knitr::kable(res %>% count(socpo_label) %>% mutate( prop = round(n/sum(n),2))))
  message("\n\nHISCAM_U1 matches:")
  print(knitr::kable(
    res %>% mutate(match = factor(!is.na(hiscam_u1))) %>% count(match) %>% mutate( prop = round(n/sum(n),2))
    ))
  message("\n")
}


filter_hisco <- function(x, ref) {
  env <- environment()

  if (!is.null(ref)){
    hisco <- validate_ref(ref)
  } else{
    data(hisco, package = "hisco", envir = env)
  }
  
  join_by <- "hisco"
  if ("status" %in% colnames(x)) {
    join_by <- c(join_by, "status")
    hisco <- hisco %>% filter(!is.na(status))
  } else {
    hisco <- hisco %>% filter(is.na(status))
  }
  if ("relation" %in% colnames(x)){
    join_by <- c(join_by, "relation")
    hisco <- hisco %>% filter(!is.na(relation))
  } else {
    hisco <- hisco %>% filter(is.na(relation))
  }
  if ("product" %in% colnames(x)){
    join_by <- c(join_by, "product")
    hisco <- hisco %>% filter(!is.na(product))
  } else {
    hisco <- hisco %>% filter(is.na(product))
  }
  return(list(hisco = hisco, join_by = join_by))
}

tohisco_data.frame <- function(x, status = NULL, relation = NULL, product = NULL, name = "hisco"){
  
  assert_that(name %in% colnames(x))
  res <- data.frame(hisco = x[ ,name])
  
  if (!is.null(status))
    if (status %in% colnames(x)) res$status <- x[ ,status]
  if (!is.null(relation))
    if (relation %in% colnames(x)) res$relation <- x[ ,relation]  
  if (!is.null(product))
    if (product %in% colnames(x)) res$product <- x[ ,product]
  
  return(res)
}

tohisco_character <- function(x, ...){
  # read data from csv and use data.frame
  assert_that(file.exists(x), msg = sprintf("Cannot open file '%s'", x))
  raw <- read.csv(x)
  colnames(raw) <- tolower(colnames(raw))
  return(tohisco_data.frame(raw, ...))
}

tohisco_integer <- function(x, status_codes = NULL, relation_codes = NULL, product_codes = NULL, ...){
  
  y <- data.frame(hisco = x)

  if (!is.null(status_codes))
    y$status <- status_codes
  if (!is.null(relation_codes))
    y$relation <- relation_codes  
  if (!is.null(product_codes))
    y$product <- product_codes

  return(y)
}

tohisco_numeric <- function(x, ...){
  x <- as.integer(x)
  return(tohisco_integer(x, ...))
}
