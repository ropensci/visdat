# vis_dat fails when the wrong palette is provided

    Code
      vis_dat(typical_data, palette = "wat")
    Error <simpleError>
      palette arguments need to be either 'qual' 'cb_safe' or 'default'

# vis_dat fails when an object of the wrong class is provided

    Code
      vis_dat(AirPassengers)
    Error <simpleError>
      `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

