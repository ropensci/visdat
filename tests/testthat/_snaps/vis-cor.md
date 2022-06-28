# vis_cor sends an error when used with the wrong data

    Code
      vis_cor(iris)
    Error <simpleError>
      data input can only contain numeric values, please subset the data to the numeric values you would like. dplyr::select_if(data, is.numeric) can be helpful here!

# vis_cor fails when an object of the wrong class is provided

    Code
      vis_cor(AirPassengers)
    Error <simpleError>
      `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

