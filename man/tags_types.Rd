% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tags_types.R
\name{tags_types}
\alias{tags_types}
\title{List acceptable variable types for tags}
\usage{
tags_types(..., allow_extra = TRUE)
}
\arguments{
\item{...}{<\code{\link[rlang:dyn-dots]{dynamic-dots}}> A series of tags provided as
\code{tag_name = "column_name"}. When specifying tags, please also see
\code{tag_defaults} to specify default values.}

\item{allow_extra}{a \code{logical} indicating if additional data tags not
currently recognized by \code{datatagr} should be allowed; if \code{FALSE}, unknown
tags will trigger an error}
}
\value{
A named \code{list}.
}
\description{
This function returns a named list providing the acceptable data types for
the default tags. If no argument is provided, it returns default
values. Otherwise, provided values will be used to define the defaults.
}
\examples{
# list default values
tags_types()

# change existing values
tags_types(date_onset = "Date") # impose a Date class

# add new types e.g. to allow genetic sequences using ape's format
tags_types(sequence = "DNAbin", allow_extra = TRUE)

}
\seealso{
\itemize{
\item \code{\link[=validate_types]{validate_types()}} uses \code{\link[=tags_types]{tags_types()}} for validating tags
\item \code{\link[=validate_datatagr]{validate_datatagr()}} uses \code{\link[=tags_types]{tags_types()}} for validating tags
}
}
