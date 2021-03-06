% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/is_odd.R
\name{is_odd}
\alias{is_odd}
\title{Check whether value is odd}
\usage{
is_odd(x)
}
\arguments{
\item{x}{Numeric vector or single numeric value.}
}
\value{
\code{TRUE} for each odd value of \code{x}, \code{FALSE} for
          even values.
}
\description{
Checks whether \code{x} is an odd number or not. Only
               accepts numeric vectors.
}
\examples{
is_odd(4)
is_odd(5)
is_odd(1:4)

}
\seealso{
\code{\link{is_even}}
}

