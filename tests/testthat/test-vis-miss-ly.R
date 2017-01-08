context("vis_miss_ly")

vis_miss_ly_plot <- vis_miss_ly(airquality)

vdiffr::expect_doppelganger("vis_miss_ly is plotly, hopefully this works!",
                            vis_miss_ly_plot)
