% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/to_label.R
\name{to_character}
\alias{to_character}
\title{Convert variable into character vector and replace values with associated value labels}
\usage{
to_character(x, add.non.labelled = FALSE, prefix = FALSE, drop.na = TRUE)
}
\arguments{
\item{x}{A labelled vector (see \code{\link{set_labels}}),
respectively a data frame with such variables.}

\item{add.non.labelled}{logical, if \code{TRUE}, values without associated
value label will also be converted to labels (as is). See 'Examples'.}

\item{prefix}{Logical, if \code{TRUE}, the value labels used as factor levels
or character values will be prefixed with their associated values. See 'Examples'.}

\item{drop.na}{Logical, if \code{TRUE}, tagged \code{NA} values with value labels
will be converted to regular NA's. Else, tagged \code{NA} values will be replaced
with their value labels. See 'Examples' and \code{\link{get_na}}.}
}
\value{
A character vector with the associated value labels as values, or a
          data frame with such factor variables (if \code{x} was a data frame).
}
\description{
This function converts (replaces) variable values (also of factors
               or character vectors) with their associated value labels and returns
               them as character vector. This is just a convenient wrapper for
               \code{as.character(to_label(x))}.
}
\details{
See 'Details' in \code{\link{get_na}}.
}
\note{
Value and variable label attributes (see, for instance, \code{\link{get_labels}}
        or \code{\link{set_labels}}) will be removed  when converting variables to factors.
}
\examples{
data(efc)
print(get_labels(efc)['c161sex'])
head(efc$c161sex)
head(to_character(efc$c161sex))

print(get_labels(efc)['e42dep'])
table(efc$e42dep)
table(to_character(efc$e42dep))

head(efc$e42dep)
head(to_character(efc$e42dep))

# numeric values w/o value labels will also be converted into character
str(efc$e17age)
str(to_character(efc$e17age))


# factor with non-numeric levels, non-prefixed and prefixed
x <- factor(c("a", "b", "c"))
set_labels(x) <- c("ape", "bear", "cat")

to_character(x, prefix = FALSE)
to_character(x, prefix = TRUE)


# create vector
x <- c(1, 2, 3, 2, 4, NA)
# add less labels than values
x <- set_labels(x, c("yes", "maybe", "no"),
                force.labels = FALSE,
                force.values = FALSE)
# convert to character w/o non-labelled values
to_character(x)
# convert to character, including non-labelled values
to_character(x, add.non.labelled = TRUE)


# create labelled integer, with missing flag
library(haven)
x <- labelled(c(1:3, tagged_na("a", "c", "z"), 4:1, 2:3),
              c("Agreement" = 1, "Disagreement" = 4, "First" = tagged_na("c"),
                "Refused" = tagged_na("a"), "Not home" = tagged_na("z")))
# to character, with missing labels
to_character(x, drop.na = FALSE)
# to character, missings removed
to_character(x, drop.na = TRUE)
# keep missings, and use non-labelled values as well
to_character(x, add.non.labelled = TRUE, drop.na = FALSE)

}

