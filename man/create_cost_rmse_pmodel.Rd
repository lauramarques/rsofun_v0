% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_cost_function.R
\name{create_cost_rmse_pmodel}
\alias{create_cost_rmse_pmodel}
\title{Creates a cost function for different simulation setups based on RMSE}
\usage{
create_cost_rmse_pmodel(params_modl, setup, method)
}
\arguments{
\item{params_modl}{A list of model parameter values, including \code{'kphio',
'soilm_par_a', 'soilm_par_b', 'tau_acclim_tempstress' }and \code{'par_shape_tempstress'}
in that order.}

\item{setup}{A character string (\code{'BRC'} or \code{'FULL'}) indicating which
parameters are calibrated. For \code{setup = 'BRC'} only the quantum yield
efficiency \code{kphio} is calibrated; for \code{setup = 'FULL'} it also includes
the soil moisture stress parameters \code{soilm_par_a} and \code{soilm_par_b}
for calibration.}

\item{method}{A character string indicating the optimization method that will
be used, either \code{'BayesianTools'} or \code{'GenSA'}.}
}
\value{
A cost function which computes the RMSE of the simulated GPP by the P-model 
versus the observed GPP. This cost function has as arguments a list of calibratable
model parameters \code{par}, a data frame of observations \code{obs}, and a
data frame of driver data \code{drivers}.
}
\description{
Creates a cost function for parameter calibration, keeping non-calibrated
parameter values fixed and calibrating the parameters corresponding to setups
\code{BRC} and \code{FULL} from Stocker et al., 2020 GMD. The cost function
computes the root mean squared error (RMSE) on the calibrated parameters.
}
\details{
The resulting cost function performs a P-model run for the value of
\code{par} given as argument and the remaining non-calibratable parameters
are held constant (specified via \code{params_modl}).

Since the calibration routine in \code{BayesianTools} is based on maximizing 
a cost function and we want to minimize the RMSE, the opposite value, 
\code{(-1)*RMSE}, is returned if \code{method = 'BayesianTools'}. \code{GenSA}
minimizes the given objective function, so the plain RMSE is returned when
\code{method = 'GenSA'}.
}
\examples{
\dontrun{
# Set model parameters
pars <- list(
  kphio          = 0.04,
  soilm_par_a    = 2.8,
  soilm_par_b    = 1.7,
  tau_acclim_tempstress  = 7.3,
  par_shape_tempstress   = 0.1
  )

# Write cost function
cost_rmse_kphio <- create_cost_rmse_pmodel(
  params_modl = pars,
  setup = 'BRC',
  method = 'BayesianTools'
  )
}
}
