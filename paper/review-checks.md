# Things to check with reviewers

# @seaaan

> In the "Using visdat" vignette, it says "missing data represented by black", but it shows up as gray on my computer.

- I think I've fixed this now, does it still happen?

> I don't know why, but in the plotly section, a vis_dat() (non-interactive) plot of df_test appears between the first two interactive plots. I can't explain it, hopefully it's just a weird quirk on my computer.

- I can't seem to replicate this, can you maybe take a screenshot of this if this is still happening?


> Did you mean to export guess_type()?

- Yes, as I thought that it might be a useful function for users, although I can't think of a good usecase outside of `vis_guess` right now. Perhaps it might be best for `guess_type` to be unexported?


> vis_compare and vis_guess are indicated as being in beta, which seems also to apply to the plotly versions of the functions. The message that they emit is a helpful indication that they may change in the future. Before submitting to CRAN, however, you might consider moving those functions to the development version of the package and only uploading the functions with a stable API, then adding the beta version later once they stabilize. This is a judgment call; I think I tend towards being conservative on this issue personally.

- Agreed, I need to create a dev branch, where these experimental features can reside.

*task*
- create "dev" branch on github where I put the experimental features of visdat.
