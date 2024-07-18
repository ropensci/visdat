# vis_compare will not accept two dataframes of differing dims

    Code
      vis_compare(iris, iris_add)
    Condition
      Error in `vis_compare()`:
      ! `vis_compare()` requires identical dimensions of `df1` and `df2`
      The dimensions of `df1` are: 150 and 5
      The dimensions of `df2` are: 150 and 6

# vis_compare fails when an object of the wrong class is provided

    Code
      vis_compare(iris, AirPassengers)
    Condition
      Error in `test_if_dataframe()`:
      ! `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

---

    Code
      vis_compare(AirPassengers, iris)
    Condition
      Error in `test_if_dataframe()`:
      ! `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

---

    Code
      vis_compare(AirPassengers, AirPassengers)
    Condition
      Error in `test_if_dataframe()`:
      ! `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

