% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gregexpr.R
\name{regexpr2}
\alias{regexpr2}
\alias{gregexpr2}
\alias{regexec2}
\alias{gregexec2}
\alias{regexpr}
\alias{gregexpr}
\alias{regexec}
\alias{gregexec}
\title{Locate Pattern Occurrences}
\usage{
regexpr2(x, pattern, ..., ignore_case = FALSE, fixed = FALSE)

gregexpr2(x, pattern, ..., ignore_case = FALSE, fixed = FALSE)

regexec2(x, pattern, ..., ignore_case = FALSE, fixed = FALSE)

gregexec2(x, pattern, ..., ignore_case = FALSE, fixed = FALSE)

regexpr(
  pattern,
  x = text,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE,
  text
)

gregexpr(
  pattern,
  x = text,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE,
  text
)

regexec(
  pattern,
  x = text,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE,
  text
)

gregexec(
  pattern,
  x = text,
  ...,
  ignore.case = FALSE,
  fixed = FALSE,
  perl = FALSE,
  useBytes = FALSE,
  text
)
}
\arguments{
\item{x}{character vector whose elements are to be examined}

\item{pattern}{character vector of nonempty search patterns}

\item{...}{further arguments to \code{\link[stringi]{stri_locate}},
e.g., \code{omit_empty}, \code{locale}, \code{dotall}}

\item{ignore_case, ignore.case}{single logical value; indicates whether matching
should be case-insensitive}

\item{fixed}{single logical value;
\code{FALSE} for matching with regular expressions
    (see \link[stringi]{about_search_regex});
\code{TRUE} for fixed pattern matching
    (\link[stringi]{about_search_fixed});
\code{NA} for the Unicode collation algorithm
    (\link[stringi]{about_search_coll})}

\item{perl, useBytes}{not used (with a warning if
attempting to do so) [DEPRECATED]}

\item{text}{alias to the \code{x} argument [DEPRECATED]}
}
\value{
\code{regexpr2} and [DEPRECATED] \code{regexpr} return an integer vector
which gives the start positions of the first substrings matching a pattern.
The \code{match.length} attribute gives the corresponding
match lengths. If there is no match, the two values are set to -1.

\code{gregexpr2} and [DEPRECATED] \code{gregexpr} yield
a list whose elements are integer vectors with \code{match.length}
attributes, giving the positions of all the matches.
For consistency with \code{regexpr2}, a no-match is denoted with
a single -1, hence the output is guaranteed to consist of non-empty integer
vectors.

\code{regexec2} and [DEPRECATED] \code{regexec} return
a list of integer vectors giving the positions of the first matches
and the locations of matches to the consecutive parenthesised subexpressions
(which can only be recognised if \code{fixed=FALSE}).
Each vector is equipped with the \code{match.length} attribute.

\code{gregexec2} and [DEPRECATED] \code{gregexec} generate
a list of matrices, where each column corresponds to a separate match;
the first row is the start index of the match, the second row gives the
position of the first captured group, and so forth.
Their \code{match.length} attributes are matrices of corresponding sizes.

These functions preserve the attributes of the longest inputs (unless they
are dropped due to coercion). Missing values in the inputs are propagated
consistently.
}
\description{
\code{regexpr2} and \code{gregexpr2} locate, respectively, first and all
(i.e., \bold{g}lobally) occurrences of a pattern.
\code{regexec2} and \code{gregexec2} can additionally
pinpoint the matches to parenthesised subexpressions (regex capture groups).
}
\details{
These functions are fully vectorised with respect to both \code{x} and
\code{pattern}.

Use \code{\link{substrl}} and \code{\link{gsubstrl}}
to extract or replace the identified chunks.
Also, consider using \code{\link{regextr2}} and
\code{\link{gregextr2}} directly instead.
}
\section{Differences from Base R}{

Replacements for base \code{\link[base]{gregexpr}} (and others)
implemented with \code{\link[stringi]{stri_locate}}.

\itemize{
\item there are inconsistencies between the argument order and naming
    in \code{\link[base]{grepl}}, \code{\link[base]{strsplit}},
    and \code{\link[base]{startsWith}} (amongst others); e.g.,
    where the needle can precede the haystack, the use of the forward
    pipe operator, \code{\link[base]{|>}}, is less convenient
    \bold{[fixed here]}
\item base R implementation is not portable as it is based on
    the system PCRE or TRE library
    (e.g., some Unicode classes may not be available or matching thereof
    can depend on the current \code{LC_CTYPE} category
    \bold{[fixed here]}
\item not suitable for natural language processing
    \bold{[fixed here -- use \code{fixed=NA}]}
\item two different regular expression libraries are used
    (and historically, ERE was used in place of TRE)
    \bold{[here, \pkg{ICU} Java-like regular expression engine
    is only available, hence the \code{perl} argument has no meaning]}
\item not vectorised w.r.t. \code{pattern}
    \bold{[fixed here]}
\item \code{ignore.case=TRUE} cannot be used with \code{fixed=TRUE}
    \bold{[fixed here]}
\item no attributes are preserved
    \bold{[fixed here; see Value]}
\item in \code{regexec}, \code{match.length} attribute is unnamed
    even if the capture groups are (but \code{gregexec} sets dimnames
    of both start positions and lengths)
    \bold{[fixed here]}
\item \code{regexec} and \code{gregexec} with \code{fixed} other than
    \code{FALSE} make little sense.
    \bold{[this argument is [DEPRECATED] in \code{regexec2}
    and \code{gregexec2}]}
\item \code{gregexec} does not always yield a list of matrices
    \bold{[fixed here]}
\item a no-match to a conditional capture group is assigned length 0
    \bold{[fixed here]}
\item no-matches result in a single -1, even if capture groups are
    defined in the pattern
    \bold{[fixed here]}
}
}

\examples{
x <- c(aca1="acacaca", aca2="gaca", noaca="actgggca", na=NA)
regexpr2(x, "(A)[ACTG]\\\\1", ignore_case=TRUE)
regexpr2(x, "aca") >= 0  # like grepl2
gregexpr2(x, "aca", fixed=TRUE, overlap=TRUE)

# two named capture groups:
regexec2(x, "(?<x>a)(?<y>cac?)")
gregexec2(x, "(?<x>a)(?<y>cac?)")

# extraction:
gsubstrl(x, gregexpr2(x, "(A)[ACTG]\\\\1", ignore_case=TRUE))
gregextr2(x, "(A)[ACTG]\\\\1", ignore_case=TRUE)  # equivalent

}
\seealso{
The official online manual of \pkg{stringx} at \url{https://stringx.gagolewski.com/}

Related function(s): \code{\link{paste}}, \code{\link{nchar}},
    \code{\link{strsplit}}, \code{\link{gsub2}},
    \code{\link{grepl2}}, \code{\link{gregextr2}}, \code{\link{gsubstrl}}
}
\author{
\href{https://www.gagolewski.com/}{Marek Gagolewski}
}
