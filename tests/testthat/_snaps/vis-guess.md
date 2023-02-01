# vis_guess fails when the wrong palette is provided

    Code
      vis_guess(test_data, palette = "wat")
    Error <rlang_error>
      Palette arguments need to be one of: 'qual', 'cb_safe', or 'default'
      You palette argument was: `wat`

# vis_guess fails when an object of the wrong class is provided

    Code
      vis_guess(AirPassengers)
    Error <rlang_error>
      `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

