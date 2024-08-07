\name{NEWS}
\title{News for Package \pkg{MatrixGenerics}}
\encoding{UTF-8}

\section{Version 1.12.1{\itemize{
  \item Modify calls to \pkg{matrixStats} functions to mitigate non-backward comptible changes in \pkg{matrixStats} 1.0.0. More precisely: (1) \code{useNames=NA} became deprecated in \pkg{matrixStats} 1.0.0 so we make sure to never pass \code{useNames=NA} when calling a \pkg{matrixStats} function; (2) furthermore, we make sure to pass a \code{useNames} value that preserves the pre-\pkg{matrixStats} 1.0.0 behavior in order to avoid disruption. See https://github.com/Bioconductor/MatrixGenerics/issues/31 for a discussion of these changes.
}}

\section{Version 1.11.3{\itemize{
  \item Add \pkg{SparseArray} to Suggests.
}}

\section{Version 1.11.1{\itemize{
  \item Move \code{rowSum()}/\code{colSums()} and \code{rowMeans()}/\code{colMeans()} generics from \pkg{BiocGenerics}.
}}

\section{Version 1.9.1}{\itemize{
  \item Fix for functions whose first argument is not \code{x} (\url{https://github.com/Bioconductor/MatrixGenerics/issues/28} and \url{https://github.com/Bioconductor/MatrixGenerics/pull/29}).
}}

\section{Version 1.5.4}{\itemize{
  \item Sync API with \pkg{matrixStats} \code{v0.60.1}.
}}

\section{Version 1.5.2}{\itemize{
  \item Sync API with \pkg{matrixStats} \code{v0.60.0}.
}}

\section{Version 1.5.1}{\itemize{
  \item Fix problem with function environment of fallback mechanism (\url{https://github.com/Bioconductor/MatrixGenerics/issues/25} and \url{https://github.com/Bioconductor/MatrixGenerics/pull/26}). Make sure that packages can use \pkg{MatrixGenerics} with the \code{::} notation to call functions from \pkg{sparseMatrixStats} and \pkg{DelayedMatrixStats}.
}}

\section{Version 1.2.1}{\itemize{
  \item Sync API with \pkg{matrixStats} \code{v0.58.0}.
}}

\section{Version 1.2.0}{\itemize{
  \item Add \code{drop} and \code{type} to generic signature of \code{[row|col]Quantiles} (\url{https://github.com/Bioconductor/MatrixGenerics/pull/14}).
  \item Sync API with \pkg{matrixStats} \code{v0.57.0} (\url{https://github.com/Bioconductor/MatrixGenerics/issues/17}).
  \item Add default methods with user-friendly fallback mechanism (\url{https://github.com/Bioconductor/MatrixGenerics/pull/16}). Suggested packages are now loaded the first time a \pkg{MatrixGenerics}' generic is called (e.g. the first time \code{MatrixGenerics::colVars()} is called). With this new approach, if the user passes a \emph{dgCMatrix} object and if \pkg{sparseMatrixStats} is already loaded, will 'just work' and the fallback mechanism won't try to load anything.
  \item Dispatch on methods for matrix objects when table objects are supplied (\url{https://github.com/Bioconductor/MatrixGenerics/pull/15})
}}

\section{Version 1.0.0}{\itemize{
  \item New package \pkg{MatrixGenerics}, providing S4 generic functions modeled after the 'matrixStats' API for alternative matrix implementations.
}}
