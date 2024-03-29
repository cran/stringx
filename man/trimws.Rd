% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trimws.R
\name{trimws}
\alias{trimws}
\title{Trim Leading or Trailing Whitespaces}
\usage{
trimws(x, which = "both", whitespace = "\\\\p{Wspace}")
}
\arguments{
\item{x}{character vector
whose elements are to be trimmed}

\item{which}{single string; either \code{"both"}, \code{"left"},
or \code{"right"}; side(s) from which the code points matching
the \code{whitespace} pattern are to be removed}

\item{whitespace}{single string; specifies the set of Unicode code points
for removal, see 'Character Classes' in
\link[stringi]{about_search_regex} for more details}
}
\value{
Returns a character vector (in UTF-8).
}
\description{
Removes whitespaces (or other code points as specified by the
\code{whitespace} argument) from left, right, or both sides of each string.
}
\details{
Not to be confused with \code{\link{strtrim}}.
}
\section{Differences from Base R}{

Replacement for base \code{\link[base]{trimws}}
implemented with \code{\link[stringi]{stri_replace_all_regex}}
(and not \code{\link[stringi]{stri_trim}}, which uses a slightly different
syntax for pattern specifiers).

\itemize{
\item the default \code{whitespace} argument does not reflect the
    'contemporary' definition of whitespaces
    (e.g., does not include zero-width spaces)
    \bold{[fixed here]}
\item base R implementation is not portable as it is based on
    the system PCRE library
    (e.g., some Unicode classes may not be available or matching thereof
    can depend on the current \code{LC_CTYPE} category)
    \bold{[fixed here]}
\item no sanity checks are performed on \code{whitespace}
    \bold{[fixed here]}
}
}

\examples{
base::trimws("NAAAAANA!!!NANAAAAA", whitespace=NA)  # stringx raises an error
x <- "   :)\\v\u00a0 \n\r\t"
base::trimws(x)
stringx::trimws(x)

}
\seealso{
The official online manual of \pkg{stringx} at \url{https://stringx.gagolewski.com/}

Related function(s): \code{\link{sub}}
}
\author{
\href{https://www.gagolewski.com/}{Marek Gagolewski}
}
