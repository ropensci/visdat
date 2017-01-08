context("comparing vis")

# make a new dataset of iris that contains some NA values

iris_diff <- iris
iris_diff[1:10, 1:2] <- NA

vis_compare_plot <- vis_compare(iris, iris_diff)

vdiffr::expect_doppelganger("vis_compare vanilla", vis_compare_plot)

# for some ... very strange reason I cannot load visdat when I have the above
# code uncommented. Very strange!
# maybe it is because of all the warnings that vis_compare drops...
# > devtools::load_all(".")
# Loading visdat
# Error: 'vis_compare' is not an exported object from 'namespace:visdat'
