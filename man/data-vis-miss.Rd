% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data-vis-miss.R
\name{data-vis-miss}
\alias{data-vis-miss}
\alias{data_vis_miss}
\alias{data_vis_miss.default}
\alias{data_vis_miss.data.frame}
\alias{data_vis_miss.grouped_df}
\title{Return data used to create vis_miss plot}
\usage{
data_vis_miss(x, ...)

\method{data_vis_miss}{default}(x, ...)

\method{data_vis_miss}{data.frame}(x, cluster = FALSE, ...)

\method{data_vis_miss}{grouped_df}(x, ...)
}
\arguments{
\item{x}{data.frame}

\item{...}{extra arguments (currently unused)}

\item{cluster}{logical - whether to cluster missingness. Default is FALSE.}
}
\value{
data frame

tidy dataframe of missing data
}
\description{
Return data used to create vis_miss plot

Create a tidy dataframe of missing data suitable for plotting
}
\examples{
data_vis_miss(airquality)

\dontrun{
#return vis_dat data for each group
library(dplyr)
airquality \%>\%
  group_by(Month) \%>\%
  data_vis_miss()
}
data_vis_miss(airquality)

}
