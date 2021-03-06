#' @title Retrieve values of labelled variables
#' @name get_values
#'
#' @description This function retrieves the values associated with value labels
#'                of an imported SPSS, SAS or STATA data set (via \code{\link{read_spss}},
#'                \code{\link{read_sas}} or \code{\link{read_stata}}),
#'                or of a \code{\link[haven]{labelled}} vector.
#'
#' @seealso \code{\link{get_labels}} for getting value labels and \code{\link{get_na}}
#'            to get values for missing values.
#'
#' @param x Variable (vector) with value label attributes.
#' @param sort.val Logical, if \code{TRUE} (default), values of associated value labels
#'          are sorted.
#' @param drop.na Logical, if \code{TRUE}, missing code values are excluded from
#'          the return value. See 'Examples' and \code{\link{get_na}}.
#' @return The values associated with value labels from \code{x},
#'           or \code{NULL} if \code{x} has no label attributes.
#'
#' @details \code{\link[haven]{labelled}} vectors are numeric by default (when imported with read-functions
#'            like \code{\link{read_spss}}) and have variable and value labels attributes.
#'            The value labels are associated with those values from the labelled vector.
#'            This function returns the values associated with the vector's value labels,
#'            which may differ from actual values in the vector (e.g. due to missings)
#'            or are not represented in sorted order.
#'
#' @examples
#' data(efc)
#' str(efc$e42dep)
#' get_values(efc$e42dep)
#' get_labels(efc$e42dep)
#'
#' library(haven)
#' x <- labelled(c(1:3, tagged_na("a", "c", "z"), 4:1),
#'               c("Agreement" = 1, "Disagreement" = 4, "First" = tagged_na("c"),
#'                 "Refused" = tagged_na("a"), "Not home" = tagged_na("z")))
#' # get all values
#' get_values(x)
#' # drop NA
#' get_values(x, drop.na = TRUE)
#'
#' @importFrom haven is_tagged_na na_tag
#' @export
get_values <- function(x, sort.val = FALSE, drop.na = FALSE) {
  # haven or foreign?
  attr.string <- getValLabelAttribute(x)
  # nothing found? then leave...
  if (is.null(attr.string)) return(NULL)
  # get values
  if (is.character(x) || (is.factor(x) && !is_num_fac(x)))
    values <- unname(attr(x, attr.string, exact = T))
  else
    values <- as.numeric(unname(attr(x, attr.string, exact = T)))
  # do we have any tagged NAs?
  if (any(haven::is_tagged_na(values)) && !drop.na) {
    values[haven::is_tagged_na(values)] <- paste0("NA(", haven::na_tag(values[haven::is_tagged_na(values)]), ")")
  }
  # sort values
  if (sort.val) values <- sort(values)
  # remove missing value codes?
  if (drop.na) values <- values[!is.na(values)]
  # foreign? then reverse order
  if (is_foreign(attr.string)) values <- rev(values)
  # return sorted
  return(values)
}
