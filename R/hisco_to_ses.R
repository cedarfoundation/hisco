#' Hisco to SES classification
#'
#' Function to classify historical occupations coded in HICSO 
#'   (Historical International Standard Classification of Occupations) 
#'   to HISCLASS 12, HISCLASS 5, SOCPO or HISCAM social class systems.
#'
#' @param x a vector of HISCO codes, a path to a csv file or data.frame that holds HISCO and
#'   optional STATUS, RELATION and PRODUCT mappigns
#' @param class ouput class system
#' @param status name of STATUS variable or vector of STATUS codes
#' @param relation name of RELATION variable or vector of RELATION codes
#' @param product name of PRODUCT variable or vector of PRODUCT codes
#' @param output vector or data.frame
#' @param name name of variable con
#' @param reference A data.frame or a path to a csv file containing a reference table. 
#'   Not yet implemented.
#' @param messages Print summary statistics on classification result.
#' @author Johan Junkka \email{johan.junkka@@gmail.com}
#' @export
#' @import dplyr
#' @import assertthat

hisco_to_ses <- function(x, 
    class = c("hisclass", "hisclass_5", "socpo", "hiscam_u1", "all"),
    status = NULL,
    relation = NULL,
    product = NULL,
    output = c(NULL, "vector", "labled", "full"),
    name = "hisco",
    reference = NULL,
    messages = FALSE) {
  
  if (!is.null(reference)) 
    reference <- validate_ref(reference)

  in_class <- class(x)
  out_class <- match.arg(class)

  if (!is.null(output)){
    output_format <- match.arg(output)
  } else {
    ouput_fomat = switch(in_class,
      "data.frame" = "full",
      "character" = "full",
      "integer" = "vector",
      "numeric" = "vector"
    )
  }

  if (out_class == "hiscam_u1" & output_format == "labled")
    output_format <- "vector"
  
  
  dat <- switch(in_class, 
    "data.frame" = hisco_in.data_frame(x, name, status, relation, product),
    "character" = hisco_in.character(x, name, status, relation, product),
    "integer" = hisco_in.integer(x, status, relation, product),
    "numeric" = hisco_in.numeric(x, status, relation, product)
  )

  filtered <- filter_hisco(dat, reference)
  
  res <- left_join(dat, filtered$hisco, by = filtered$join_by) 

  if (messages) {
    message("\n\nHISCLASS matches:")
    print(knitr::kable(res %>% count(hisclass_label) %>% mutate( prop = round(n/sum(n),2))))
    message("\n\nHISCLASS 5 matches:")
    print(knitr::kable(res %>% count(hisclass_5_label) %>% mutate( prop = round(n/sum(n),2))))
    message("\n\nSOCPO matches:")
    print(knitr::kable(res %>% count(socpo_label) %>% mutate( prop = round(n/sum(n),2))))
    message("\n\nHISCAM_U1 matches:")
    print(knitr::kable(
      res %>% mutate(match = factor(!is.na(hiscam_u1))) %>% count(match) %>% mutate( prop = round(n/sum(n),2))
      ))

  }
  if (out_class == "all")
    return(res)
  
  if (output_format == "labled"){
    lbl = paste0(out_class, "_label")
    res <- res %>% select_("hisco", out_class, lbl)
  } else if (output_format == "vector"){  
    res <- res %>% select_("hisco", out_class)
  }
  return(switch(output_format, 
    "vector" = res[ ,2],
    "labled" = res[ ,c(2:3)],
    "full" = res
  ))
}

filter_hisco <- function(x, ref) {
  env <- environment()

  if (!is.null(ref)){
    hisco <- ref
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

hisco_in.data_frame <- function(x, name = NULL, status = NULL, relation = NULL, product = NULL){
  
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

hisco_in.character <- function(x, ...){
  # read data from csv and use data.frame
  assert_that(file.exists(x), msg = sprintf("Cannot open file '%s'", x))
  raw <- read.csv(x)
  colnames(raw) <- tolower(colnames(raw))
  return(hisco_in.data_frame(raw, ...))
}

hisco_in.integer <- function(x, status_codes = NULL, relation_codes = NULL, product_codes = NULL){
  
  y <- data.frame(hisco = x)

  if (!is.null(status_codes))
    y$status <- status_codes
  if (!is.null(relation_codes))
    y$relation <- relation_codes  
  if (!is.null(product_codes))
    y$product <- product_codes

  return(y)
}

hisco_in.numeric <- function(x, ...){
  x <- as.integer(x)
  return(hisco_in.integer(x, ...))
}
