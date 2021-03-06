% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rules.R
\name{sv_numeric}
\alias{sv_numeric}
\alias{sv_integer}
\title{Validate that a field is a number}
\usage{
sv_numeric(
  message = "A number is required",
  allowMultiple = FALSE,
  allowNA = FALSE,
  allowNaN = FALSE,
  allowInfinite = FALSE
)

sv_integer(
  message = "An integer is required",
  allowMultiple = FALSE,
  allowNA = FALSE,
  allowNaN = FALSE,
  allowInfinite = FALSE
)
}
\arguments{
\item{message}{The validation error message to use if a value fails to match
the rule.}

\item{allowMultiple}{If \code{FALSE} (the default), then the length of the input
vector must be exactly one; if \code{TRUE}, then any length is allowed
(including a length of zero; use \code{\link[=sv_required]{sv_required()}} if one or more values
should be required).}

\item{allowNA}{If \code{FALSE} (the default), then any \code{NA} element will cause
validation to fail.}

\item{allowNaN}{If \code{FALSE} (the default), then any \code{NaN} element will cause
validation to fail.}

\item{allowInfinite}{If \code{FALSE} (the default), then any \code{Inf} or \code{-Inf}
element will cause validation to fail.}
}
\value{
A function suitable for using as an
\code{\link[=InputValidator]{InputValidator$add_rule()}} rule.
}
\description{
\code{sv_numeric} and \code{sv_integer} validate that a field \code{is.numeric} and
\code{is.integer}, respectively. By default, only a single, finite, not-missing,
valid number/integer is allowed, but each of those criteria can be controlled
via arguments.
}
\examples{
# Ignore withReactiveDomain(), it's just required to get this example to run
# outside of Shiny
shiny::withReactiveDomain(shiny::MockShinySession$new(), {

  iv <- InputValidator$new()

  iv$add_rule("count", sv_integer())
  iv$add_rule("count", ~if (. <= 0) "A positive value is required")

})
}
