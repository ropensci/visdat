# vis_dat and vis_miss throw warnings when the DF is above size

    Code
      vis_dat(big_df)
    Condition
      Error in `test_if_large_data()`:
      ! Data exceeds recommended size for visualisation
      Consider downsampling your data with `dplyr::slice_sample()`
      Or set argument, `warn_large_data` = `FALSE`

---

    Code
      vis_miss(big_df)
    Condition
      Error in `test_if_large_data()`:
      ! Data exceeds recommended size for visualisation
      Consider downsampling your data with `dplyr::slice_sample()`
      Or set argument, `warn_large_data` = `FALSE`

