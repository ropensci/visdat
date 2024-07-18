# vis_guess fails when the wrong palette is provided

    Code
      vis_guess(test_data, palette = "wat")
    Condition
      Error in `add_vis_dat_pal()`:
      ! Palette arguments need to be one of: 'qual', 'cb_safe', or 'default'
      You palette argument was: `wat`

# vis_guess fails when an object of the wrong class is provided

    Code
      vis_guess(AirPassengers)
    Condition
      Error in `test_if_dataframe()`:
      ! `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

