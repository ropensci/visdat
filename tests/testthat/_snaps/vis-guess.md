# vis_guess fails when the wrong palette is provided

    Code
      vis_guess(typical_data, palette = "wat")
    Error <simpleError>
      palette arguments need to be either 'qual' 'cb_safe' or 'default'

# vis_guess fails when an object of the wrong class is provided

    Code
      vis_guess(AirPassengers)
    Error <simpleError>
      vis_dat requires a data.frame but the object I see has class/es: ts

