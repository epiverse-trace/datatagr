% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/labels_df.R
\name{labels_df}
\alias{labels_df}
\title{Extract a data.frame of all labelled variables}
\usage{
labels_df(x)
}
\arguments{
\item{x}{a \code{datatagr} object}
}
\value{
A \code{data.frame} of with variables renamed according to their labels.
}
\description{
This function returns a \code{data.frame}, where labelled variables (as stored in
the \code{datatagr} object) are renamed. Note that the output is no longer a
\code{datatagr}, but a regular \code{data.frame}. Unlabeled variables are unaffected.
}
\examples{

x <- make_datatagr(cars,
  speed = "Miles per hour",
  dist = "Distance in miles"
)

## get a data.frame with variables renamed based on labels
labels_df(x)
}
