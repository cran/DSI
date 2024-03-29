% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datashield.login.R
\name{datashield.login}
\alias{datashield.login}
\title{Logs in a DataSHIELD R sessions and optionaly assigns variables to R}
\usage{
datashield.login(
  logins = NULL,
  assign = FALSE,
  variables = NULL,
  missings = FALSE,
  symbol = "D",
  id.name = NULL,
  opts = getOption("datashield.opts", list()),
  restore = NULL,
  failSafe = FALSE
)
}
\arguments{
\item{logins}{A dataframe table that holds login details. This table holds five elements required
to login to the servers where the data to analyse is stored. The expected column names are
'driver' (the \code{\link{DSDriver-class}} name, default is "OpalDriver"),
'server' (the server name), url' (the server url), 'user' (the user name or the certificate PEM file path),
'password' (the user password or the private key PEM file path),
'token' (the personal access token, ignored if 'user' is defined), 'table' (the fully qualified name of
the table in the data repository), 'resource' (the fully qualified name of
the resource reference in the data repository), 'profile' (an optional DataSHIELD profile name), 'options' (the SSL options). 
An additional column 'identifiers' can be specified for identifiers mapping (if supported by data repository). See also the documentation
of the examplar input table \code{logindata} for details of the login elements.}

\item{assign}{A boolean which tells whether or not data should be assigned from the data repository
table to R after login into the server(s).}

\item{variables}{Specific variables to assign. If \code{assign} is set to FALSE this argument is ignored
otherwise the specified variables are assigned to R. If no variables are specified (default) the whole
data repository's table is assigned.}

\item{missings}{If TRUE, missing values will be pushed from data repository to R, default is FALSE.}

\item{symbol}{A character, the name of the data frame to which the data repository's table will be
assigned after login into the server(s).}

\item{id.name}{Name of the column that will contain the entity identifiers. If not specified, the identifiers
will be the data frame row names. When specified this column can be used to perform joins between data frames.}

\item{opts}{Default SSL options to be used in case it is not specified in the logins structure.}

\item{restore}{The workspace name to restore (optional).}

\item{failSafe}{Ignores, with a warning, the servers for which the connection cannot be established. Optional, default is FALSE.}
}
\value{
object(s) of class DSConnection
}
\description{
This function allows for clients to login to data repository servers and (optionaly)
assign all the data or specific variables from the data repositories tables to R data
frames. The assigned dataframes (one for each data repository) are named 'D' (by default).
Different login strategies are supported: using a certificate/private key pair (2-way SSL encryption mechanism),
using user credentials (user name and password) or using a personal access token (could be
combined with a user name, depending on the data repository system).
}
\examples{
\dontrun{

#### The below examples illustrate an analysises that use test/simulated data ####

# build your data.frame
builder <- newDSLoginBuilder()
builder$append(server="server1", url="https://opal-demo.obiba.org",
               table="datashield.CNSIM1", resource="datashield.CNSIM1r",
               user="dsuser", password="password",
               options="list(ssl_verifyhost=0,ssl_verifypeer=0)")
builder$append(server="server2", url="dslite.server",
               table="CNSIM2", resource="CNSIM2r", driver="DSLiteDriver")
builder$append(server="server3", url="https://molgenis.example.org",
               table="CNSIM3", resource="CNSIM3r", token="123456789", driver="MolgenisDriver")
builder$append(server="server4", url="dslite.server",
               table="CNSIM4", resource="CNSIM4r", driver="DSLiteDriver")
logindata <- builder$build()

# or load the data.frame that contains the login details
data(logindata)

# Example 1: just login (default)
connections <- datashield.login(logins=logindata)

# Example 2: login and assign the whole dataset
connections <- datashield.login(logins=logindata, assign=TRUE)

# Example 3: login and assign specific variable(s)
myvar <- list("LAB_TSC")
connections <- datashield.login(logins=logindata, assign=TRUE, variables=myvar)

# Example 4: ignore with a warning message servers for which connection cannot be established
connections <- datashield.login(logins=logindata, failSafe=TRUE)

# note that the asignment information can also be provided afterwards
builder <- newDSLoginBuilder()
builder$append(server="server1", url="https://opal-demo.obiba.org",
               user="dsuser", password="password")
builder$append(server="server2", url="https://opal-test.obiba.org",
               token="123456789")
logindata <- builder$build()
connections <- datashield.login(logins=logindata)
datashield.assign.table(connections, symbol = "D",
                        table = list(server1 = "CNSIM.CNSIM1",
                                     server2 = "CNSIM.CNSIM2"))
datashield.assign.resource(connections, symbol = "rsrc",
                           resource = list(server1 = "res.CNSIM1",
                                        server2 = "res.CNSIM2"))
}

}
