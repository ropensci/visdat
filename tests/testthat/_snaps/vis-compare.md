# vis_compare will not accept two dataframes of differing dims

    Code
      vis_compare(iris, iris_add)
    Error <simpleError>
      vis_compare requires identical dimensions of df1 and df2

# vis_compare fails when an object of the wrong class is provided

    Code
      vis_compare(iris, AirPassengers)
    Error <simpleError>
      `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

---

    Code
      vis_compare(AirPassengers, iris)
    Error <simpleError>
      `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

---

    Code
      vis_compare(AirPassengers, AirPassengers)
    Error <simpleError>
      `vis_dat()` requires a <data.frame>
      the object I see has class(es):
      <ts>

