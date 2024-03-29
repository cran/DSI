% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datashield.workspace.R
\name{datashield.workspace_save}
\alias{datashield.workspace_save}
\title{Save DataSHIELD R session to a workspace}
\usage{
datashield.workspace_save(conns, ws)
}
\arguments{
\item{conns}{\code{\link{DSConnection-class}} object or a list of \code{\link{DSConnection-class}}s.}

\item{ws}{The workspace name}
}
\description{
Save the current state of the DataSHIELD R session in a workspace with the provided name in each data repository.
The workspace can be restored on the next \code{\link{datashield.login}} or with \code{\link{datashield.workspace_restore}}.
}
