# vis_expect fails when an object of the wrong class is provided

    Code
      vis_expect(AirPassengers, ~.x < 20)
    Error <simpleError>
      vis_dat requires a data.frame but the object I see has class/es: ts

