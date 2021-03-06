% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/merge_imputations.R
\name{merge_imputations}
\alias{merge_imputations}
\title{Merges multiple imputed data frames into a single data frame}
\usage{
merge_imputations(dat, imp, ori = NULL)
}
\arguments{
\item{dat}{The data frame that imputed and used as argument in the
\code{\link[mice]{mice}}-function call.}

\item{imp}{The \code{\link[mice]{mids}}-object with the imputed data frames
from \code{dat}.}

\item{ori}{Optional, data frame specifying the original data frame with
missing values, if \code{dat} was only a subset of \code{ori} that
was imputed. If \code{ori} is specified, the imputed variables are
appended to this data frame; else, they are appended to \code{dat}.}
}
\value{
\code{dat}, with appended imputed variables; or \code{ori} with
        imputed variables, if \code{ori} was specified.
}
\description{
This function merges multiple imputed data frames from
               \code{\link[mice]{mids}}-objects into a single data frame
               by appending the imputed variables to the original data frame.
}
\details{
This method merges multiple imputations of variables into a single
         variable by calculation the (rounded) mean of all imputed values
         of missing values. By this, each missing value is replaced by
         those values that have been imputed the most times.
         \cr \cr
         \code{imp} must be a \code{mids}-object, which is returned by the
         \code{mice}-function of the \pkg{mice}-package. This function than
         creates a data frame for each imputed variable, by combining all
         imputations (as returned by the \code{\link[mice]{complete}}-function)
         of each variable, and computing the row means of this data frame.
         The mean value is then rounded for non-integer values (numerical
         values with fractional part), which corresponds to the most frequent
         imputed value for a missing value. The original variable with missing
         is then copied, missing values replaced by the most frequent imputed
         value and appended as new column to the original data frame.
}
\examples{
library(mice)
imp <- mice(nhanes)
merge_imputations(nhanes, imp)

}

