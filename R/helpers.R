#' @keywords internal
get_var_label <- function(varId, lang = "pl") {
  var_suffix <- get_request(dir = "variables", id = toString(varId), filters = list(lang = lang))

  var_prefix <- get_request(dir = "subjects", id = var_suffix$subjectId, filters = list(lang = lang))
  var_suffix <- tibble::as_tibble(var_suffix)
  var_suffix <- var_suffix %>%
    utils::head(1) %>%
    dplyr::select(dplyr::starts_with("n"))
  
  temp <- list()
  for(val in 1:length(var_prefix$dimensions)){
    temp[val] <- paste(var_prefix$dimensions[val], var_suffix[val], sep = ":")
  }
  
  var_suffix <- paste(temp, collapse = ", ")
  variable_label <- paste(var_prefix$name, var_suffix, sep = " - ")
  variable_label
}
#' @keywords internal
get_measure_label <- function(varId, lang = "pl") {
  var_suffix <- get_request(dir = "variables", id = toString(varId), filters = list(lang = lang))

  var_suffix <- tibble::as_tibble(var_suffix)
  var_suffix <- var_suffix %>%
    utils::head(1)
  measure_label <- toString(var_suffix$measureUnitName)

  measure_label
}
#' @keywords internal
get_attr_label <- function(attrId, lang = "pl") {
  attr_suffix <- attribute_info(attrId)
  attr_label <- toString(attr_suffix$description)
  attr_label
}
#' @keywords internal
nchar_length <- function(x) {`if`(any(is.na(x)), 0, nchar(x)) }

