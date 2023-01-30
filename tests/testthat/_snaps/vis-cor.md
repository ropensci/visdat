# vis_cor sends an error when used with the wrong data

    Code
      vis_cor(iris)
    Error <rlang_error>
      Data input can only contain numeric values
      Please subset the data to the numeric values you would like.
      `dplyr::select(<data>, where(is.numeric))`
      Can be helpful here!

# vis_cor fails when an object of the wrong class is provided

    Code
      vis_cor(AirPassengers)
    Error <rlang_error>
      `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

