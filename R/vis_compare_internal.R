# This is just a set of notes on using vis_compare and friends.

# at this point there isn't much going on with it, just some chicken scracthings, really.

# Another thing to think about is this idea of storing differences betweem two dataframes in an organised way.

### experimenting with vis_compare ====================================

# let's make two versions of iris and then change two cells in the other one.

# iris_2

# copy
iris_2 <- iris

# Assign the first value to NA
iris_2[1,1] <- NA

# assign the first row, second column to be 0.001
iris_2[1,2] <- 0.001

# when you do a direct comparison, where you have the same dimension of the data, you get TRUE/FALSE where they are different.
iris == iris_2

# this should show "different", "same", and "missing"
vis_compare(iris, iris_2)

plotly::ggplotly()

df1 = iris
df2 = iris_2

if(identical(df1, df2)){

  print("No differences detected, so at the moment, there's not much point in plotting, is there?")

} else{

  print("Differences Detected!")

}

## exploring & finding where differences lie between two dataframes.

# where is there a difference?
df_diff <- iris == iris_2

# where is there a difference in the rows?
row_diff_loc <- which(rowSums(df_diff, na.rm = TRUE) != ncol(df1))

# where is there a difference in the columns?
col_diff_loc <- as.numeric(which(colSums(df_diff, na.rm = TRUE) != nrow(df1)))

# how many things are different?
row_col_intx <- interaction(row_diff_loc, col_diff_loc)

levels(row_col_intx)

n_diff <- length(row_col_intx)

# I want to know the location (row,col) or each of the things that are different
tt <- df1 == df2
 tt %>%
  as.data.frame() %>%
purrr::dmap(visdat:::compare_print)

diff_pos <- which(df_diff == FALSE)

row_num <- diff_pos %% nrow(df1)
col_num <- floor(diff_pos/nrow(df1))

# what is the value is different?
df1[row_num, col_num]

# print me the value that is different
sprintf("df1[%s, %s]", row_num, col_num)

# currently, we miss out on when values become NA.

df1[row_diff_loc, col_diff_loc]
df2[row_diff_loc, col_diff_loc]

# r
loop_box <- vector("list", n_diff)

row_diff_loc <- c(1,2)
col_diff_loc

for(i in seq_along(row_diff_loc)){
  for(j in seq_along(col_diff_loc)){
    print(paste("df[", i,",", j,"]", sep = ""))
  }
}

# can we store what the differences were, in a meaningful way?

data.frame(row = c(1),
           col = c(1),
           value_df1 = c(17.2),
           value_df2 = c("NA"),
           type = c("numeric to NA"))

